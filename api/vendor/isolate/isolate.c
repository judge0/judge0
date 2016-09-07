/*
 *	A Process Isolator based on Linux Containers
 *
 *	(c) 2012-2016 Martin Mares <mj@ucw.cz>
 *	(c) 2012-2014 Bernard Blackham <bernard@blackham.com.au>
 */

#include "isolate.h"

#include <errno.h>
#include <fcntl.h>
#include <getopt.h>
#include <grp.h>
#include <sched.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mount.h>
#include <sys/resource.h>
#include <sys/signal.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/vfs.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

/* May not be defined in older glibc headers */
#ifndef MS_PRIVATE
#warning "Working around old glibc: no MS_PRIVATE"
#define MS_PRIVATE (1 << 18)
#endif
#ifndef MS_REC
#warning "Working around old glibc: no MS_REC"
#define MS_REC     (1 << 14)
#endif

#define TIMER_INTERVAL_US 100000

static int timeout;			/* milliseconds */
static int wall_timeout;
static int extra_timeout;
int pass_environ;
int verbose;
static int silent;
static int fsize_limit;
static int memory_limit;
static int stack_limit;
int block_quota;
int inode_quota;
static int max_processes = 1;
static char *redir_stdin, *redir_stdout, *redir_stderr;
static char *set_cwd;
static int share_net;

int cg_enable;
int cg_memory_limit;
int cg_timing;

int box_id;
static char box_dir[1024];
static pid_t box_pid;

uid_t box_uid;
gid_t box_gid;
static uid_t orig_uid;
static gid_t orig_gid;

static int partial_line;
static int cleanup_ownership;

static struct timeval start_time;
static int ticks_per_sec;
static int total_ms, wall_ms;
static volatile sig_atomic_t timer_tick, interrupt;

static int error_pipes[2];
static int write_errors_to_fd;
static int read_errors_from_fd;

static int get_wall_time_ms(void);
static int get_run_time_ms(struct rusage *rus);

/*** Messages and exits ***/

static void
final_stats(struct rusage *rus)
{
  total_ms = get_run_time_ms(rus);
  wall_ms = get_wall_time_ms();

  meta_printf("time:%d.%03d\n", total_ms/1000, total_ms%1000);
  meta_printf("time-wall:%d.%03d\n", wall_ms/1000, wall_ms%1000);
  meta_printf("max-rss:%ld\n", rus->ru_maxrss);
  meta_printf("csw-voluntary:%ld\n", rus->ru_nvcsw);
  meta_printf("csw-forced:%ld\n", rus->ru_nivcsw);

  cg_stats();
}

static void NONRET
box_exit(int rc)
{
  if (box_pid > 0)
    {
      kill(-box_pid, SIGKILL);
      kill(box_pid, SIGKILL);
      meta_printf("killed:1\n");

      struct rusage rus;
      int p, stat;
      do
	p = wait4(box_pid, &stat, 0, &rus);
      while (p < 0 && errno == EINTR);
      if (p < 0)
	fprintf(stderr, "UGH: Lost track of the process (%m)\n");
      else
	final_stats(&rus);
    }

  if (rc < 2 && cleanup_ownership)
    chowntree("box", orig_uid, orig_gid);

  meta_close();
  exit(rc);
}

static void
flush_line(void)
{
  if (partial_line)
    fputc('\n', stderr);
  partial_line = 0;
}

/* Report an error of the sandbox itself */
void NONRET __attribute__((format(printf,1,2)))
die(char *msg, ...)
{
  va_list args;
  va_start(args, msg);
  char buf[1024];
  int n = vsnprintf(buf, sizeof(buf), msg, args);

  // If the child process is still running, show no mercy.
  if (box_pid > 0)
    {
      kill(-box_pid, SIGKILL);
      kill(box_pid, SIGKILL);
    }

  if (write_errors_to_fd)
    {
      // We are inside the box, have to use error pipe for error reporting.
      // We hope that the whole error message fits in PIPE_BUF bytes.
      write(write_errors_to_fd, buf, n);
      exit(2);
    }

  // Otherwise, we in the box keeper process, so we report errors normally
  flush_line();
  meta_printf("status:XX\nmessage:%s\n", buf);
  fputs(buf, stderr);
  fputc('\n', stderr);
  box_exit(2);
}

/* Report an error of the program inside the sandbox */
void NONRET __attribute__((format(printf,1,2)))
err(char *msg, ...)
{
  va_list args;
  va_start(args, msg);
  flush_line();
  if (msg[0] && msg[1] && msg[2] == ':' && msg[3] == ' ')
    {
      meta_printf("status:%c%c\n", msg[0], msg[1]);
      msg += 4;
    }
  char buf[1024];
  vsnprintf(buf, sizeof(buf), msg, args);
  meta_printf("message:%s\n", buf);
  if (!silent)
    {
      fputs(buf, stderr);
      fputc('\n', stderr);
    }
  box_exit(1);
}

/* Write a message, but only if in verbose mode */
void __attribute__((format(printf,1,2)))
msg(char *msg, ...)
{
  va_list args;
  va_start(args, msg);
  if (verbose)
    {
      int len = strlen(msg);
      if (len > 0)
        partial_line = (msg[len-1] != '\n');
      vfprintf(stderr, msg, args);
      fflush(stderr);
    }
  va_end(args);
}

/*** Signal handling in keeper process ***/

/*
 *   Signal handling is tricky. We must set up signal handlers before
 *   we start the child process (and reset them in the child process).
 *   Otherwise, there is a short time window where a SIGINT can kill
 *   us and leave the child process running.
 */

struct signal_rule {
  int signum;
  enum { SIGNAL_IGNORE, SIGNAL_INTERRUPT, SIGNAL_FATAL } action;
};

static const struct signal_rule signal_rules[] = {
  { SIGHUP,	SIGNAL_INTERRUPT },
  { SIGINT,	SIGNAL_INTERRUPT },
  { SIGQUIT,	SIGNAL_INTERRUPT },
  { SIGILL,	SIGNAL_FATAL },
  { SIGABRT,	SIGNAL_FATAL },
  { SIGFPE,	SIGNAL_FATAL },
  { SIGSEGV,	SIGNAL_FATAL },
  { SIGPIPE,	SIGNAL_IGNORE },
  { SIGTERM,	SIGNAL_INTERRUPT },
  { SIGUSR1,	SIGNAL_IGNORE },
  { SIGUSR2,	SIGNAL_IGNORE },
  { SIGBUS,	SIGNAL_FATAL },
};

static void
signal_alarm(int unused UNUSED)
{
  /* Time limit checks are synchronous, so we only schedule them there. */
  timer_tick = 1;
  msg("[timer]");
}

static void
signal_int(int signum)
{
  /* Interrupts (e.g., SIGINT) are synchronous, too. */
  interrupt = signum;
}

static void
signal_fatal(int signum)
{
  /* If we receive SIGSEGV or a similar signal, we try to die gracefully. */
  die("Sandbox keeper received fatal signal %d", signum);
}

static void
setup_signals(void)
{
  struct sigaction sa_int, sa_fatal;
  bzero(&sa_int, sizeof(sa_int));
  sa_int.sa_handler = signal_int;
  bzero(&sa_fatal, sizeof(sa_fatal));
  sa_fatal.sa_handler = signal_fatal;

  for (int i=0; i < ARRAY_SIZE(signal_rules); i++)
    {
      const struct signal_rule *sr = &signal_rules[i];
      switch (sr->action)
	{
	case SIGNAL_IGNORE:
	  signal(sr->signum, SIG_IGN);
	  break;
	case SIGNAL_INTERRUPT:
	  sigaction(sr->signum, &sa_int, NULL);
	  break;
	case SIGNAL_FATAL:
	  sigaction(sr->signum, &sa_fatal, NULL);
	  break;
	default:
	  die("Invalid signal rule");
	}
    }
}

static void
reset_signals(void)
{
  for (int i=0; i < ARRAY_SIZE(signal_rules); i++)
    signal(signal_rules[i].signum, SIG_DFL);
}

/*** The keeper process ***/

#define PROC_BUF_SIZE 4096
static void
read_proc_file(char *buf, char *name, int *fdp)
{
  int c;

  if (!*fdp)
    {
      sprintf(buf, "/proc/%d/%s", (int) box_pid, name);
      *fdp = open(buf, O_RDONLY);
      if (*fdp < 0)
	die("open(%s): %m", buf);
    }
  lseek(*fdp, 0, SEEK_SET);
  if ((c = read(*fdp, buf, PROC_BUF_SIZE-1)) < 0)
    die("read on /proc/$pid/%s: %m", name);
  if (c >= PROC_BUF_SIZE-1)
    die("/proc/$pid/%s too long", name);
  buf[c] = 0;
}

static int
get_wall_time_ms(void)
{
  struct timeval now, wall;
  gettimeofday(&now, NULL);
  timersub(&now, &start_time, &wall);
  return wall.tv_sec*1000 + wall.tv_usec/1000;
}

static int
get_run_time_ms(struct rusage *rus)
{
  if (cg_timing)
    return cg_get_run_time_ms();

  if (rus)
    {
      struct timeval total;
      timeradd(&rus->ru_utime, &rus->ru_stime, &total);
      return total.tv_sec*1000 + total.tv_usec/1000;
    }

  char buf[PROC_BUF_SIZE], *x;
  int utime, stime;
  static int proc_stat_fd;

  read_proc_file(buf, "stat", &proc_stat_fd);
  x = buf;
  while (*x && *x != ' ')
    x++;
  while (*x == ' ')
    x++;
  if (*x++ != '(')
    die("proc stat syntax error 1");
  while (*x && (*x != ')' || x[1] != ' '))
    x++;
  while (*x == ')' || *x == ' ')
    x++;
  if (sscanf(x, "%*c %*d %*d %*d %*d %*d %*d %*d %*d %*d %*d %d %d", &utime, &stime) != 2)
    die("proc stat syntax error 2");

  return (utime + stime) * 1000 / ticks_per_sec;
}

static void
check_timeout(void)
{
  if (wall_timeout)
    {
      int wall_ms = get_wall_time_ms();
      if (wall_ms > wall_timeout)
        err("TO: Time limit exceeded (wall clock)");
      if (verbose > 1)
        fprintf(stderr, "[wall time check: %d msec]\n", wall_ms);
    }
  if (timeout)
    {
      int ms = get_run_time_ms(NULL);
      if (verbose > 1)
	fprintf(stderr, "[time check: %d msec]\n", ms);
      if (ms > timeout && ms > extra_timeout)
	err("TO: Time limit exceeded");
    }
}

static void
box_keeper(void)
{
  read_errors_from_fd = error_pipes[0];
  close(error_pipes[1]);

  gettimeofday(&start_time, NULL);
  ticks_per_sec = sysconf(_SC_CLK_TCK);
  if (ticks_per_sec <= 0)
    die("Invalid ticks_per_sec!");

  if (timeout || wall_timeout)
    {
      struct sigaction sa;
      bzero(&sa, sizeof(sa));
      sa.sa_handler = signal_alarm;
      sigaction(SIGALRM, &sa, NULL);
      struct itimerval timer = {
	.it_interval = { .tv_usec = TIMER_INTERVAL_US },
	.it_value = { .tv_usec = TIMER_INTERVAL_US },
      };
      setitimer(ITIMER_REAL, &timer, NULL);
    }

  for(;;)
    {
      struct rusage rus;
      int stat;
      pid_t p;
      if (interrupt)
	{
	  meta_printf("exitsig:%d\n", interrupt);
	  err("SG: Interrupted");
	}
      if (timer_tick)
	{
	  check_timeout();
	  timer_tick = 0;
	}
      p = wait4(box_pid, &stat, 0, &rus);
      if (p < 0)
	{
	  if (errno == EINTR)
	    continue;
	  die("wait4: %m");
	}
      if (p != box_pid)
	die("wait4: unknown pid %d exited!", p);
      box_pid = 0;

      // Check error pipe if there is an internal error passed from inside the box
      char interr[1024];
      int n = read(read_errors_from_fd, interr, sizeof(interr) - 1);
      if (n > 0)
	{
	  interr[n] = 0;
	  die("%s", interr);
	}

      if (WIFEXITED(stat))
	{
	  final_stats(&rus);
	  if (WEXITSTATUS(stat))
	    {
	      meta_printf("exitcode:%d\n", WEXITSTATUS(stat));
	      err("RE: Exited with error status %d", WEXITSTATUS(stat));
	    }
	  if (timeout && total_ms > timeout)
	    err("TO: Time limit exceeded");
	  if (wall_timeout && wall_ms > wall_timeout)
	    err("TO: Time limit exceeded (wall clock)");
	  flush_line();
	  if (!silent)
	    {
	      fprintf(stderr, "OK (%d.%03d sec real, %d.%03d sec wall)\n",
		total_ms/1000, total_ms%1000,
		wall_ms/1000, wall_ms%1000);
	    }
	  box_exit(0);
	}
      else if (WIFSIGNALED(stat))
	{
	  meta_printf("exitsig:%d\n", WTERMSIG(stat));
	  final_stats(&rus);
	  err("SG: Caught fatal signal %d", WTERMSIG(stat));
	}
      else if (WIFSTOPPED(stat))
	{
	  meta_printf("exitsig:%d\n", WSTOPSIG(stat));
	  final_stats(&rus);
	  err("SG: Stopped by signal %d", WSTOPSIG(stat));
	}
      else
	die("wait4: unknown status %x, giving up!", stat);
    }
}

/*** The process running inside the box ***/

static void
setup_root(void)
{
  if (mkdir("root", 0750) < 0 && errno != EEXIST)
    die("mkdir('root'): %m");

  /*
   * Ensure all mounts are private, not shared. We don't want our mounts
   * appearing outside of our namespace.
   * (systemd since version 188 mounts filesystems shared by default).
   */
  if (mount(NULL, "/", NULL, MS_REC|MS_PRIVATE, NULL) < 0)
    die("Cannot privatize mounts: %m");

  if (mount("none", "root", "tmpfs", 0, "mode=755") < 0)
    die("Cannot mount root ramdisk: %m");

  apply_dir_rules();

  if (chroot("root") < 0)
    die("Chroot failed: %m");

  if (chdir("root/box") < 0)
    die("Cannot change current directory: %m");
}

static void
setup_credentials(void)
{
  if (setresgid(box_gid, box_gid, box_gid) < 0)
    die("setresgid: %m");
  if (setgroups(0, NULL) < 0)
    die("setgroups: %m");
  if (setresuid(box_uid, box_uid, box_uid) < 0)
    die("setresuid: %m");
  setpgrp();
}

static void
setup_fds(void)
{
  if (redir_stdin)
    {
      close(0);
      if (open(redir_stdin, O_RDONLY) != 0)
	die("open(\"%s\"): %m", redir_stdin);
    }
  if (redir_stdout)
    {
      close(1);
      if (open(redir_stdout, O_WRONLY | O_CREAT | O_TRUNC, 0666) != 1)
	die("open(\"%s\"): %m", redir_stdout);
    }
  if (redir_stderr)
    {
      close(2);
      if (open(redir_stderr, O_WRONLY | O_CREAT | O_TRUNC, 0666) != 2)
	die("open(\"%s\"): %m", redir_stderr);
    }
  else
    dup2(1, 2);
}

static void
setup_rlim(const char *res_name, int res, rlim_t limit)
{
  struct rlimit rl = { .rlim_cur = limit, .rlim_max = limit };
  if (setrlimit(res, &rl) < 0)
    die("setrlimit(%s, %jd)", res_name, (intmax_t) limit);
}

static void
setup_rlimits(void)
{
#define RLIM(res, val) setup_rlim("RLIMIT_" #res, RLIMIT_##res, val)

  if (memory_limit)
    RLIM(AS, (rlim_t)memory_limit * 1024);

  if (fsize_limit)
    RLIM(FSIZE, (rlim_t)fsize_limit * 1024);

  RLIM(STACK, (stack_limit ? (rlim_t)stack_limit * 1024 : RLIM_INFINITY));
  RLIM(NOFILE, 64);
  RLIM(MEMLOCK, 0);

  if (max_processes)
    RLIM(NPROC, max_processes);

#undef RLIM
}

static int
box_inside(void *arg)
{
  char **args = arg;
  write_errors_to_fd = error_pipes[1];
  close(error_pipes[0]);
  meta_close();

  reset_signals();
  cg_enter();
  setup_root();
  setup_credentials();
  setup_fds();
  setup_rlimits();
  char **env = setup_environment();

  if (set_cwd && chdir(set_cwd))
    die("chdir: %m");

  execve(args[0], args, env);
  die("execve(\"%s\"): %m", args[0]);
}

static void
box_init(void)
{
  if (box_id < 0 || box_id >= cf_num_boxes)
    die("Sandbox ID out of range (allowed: 0-%d)", cf_num_boxes-1);
  box_uid = cf_first_uid + box_id;
  box_gid = cf_first_gid + box_id;

  snprintf(box_dir, sizeof(box_dir), "%s/%d", cf_box_root, box_id);
  make_dir(box_dir);
  if (chdir(box_dir) < 0)
    die("chdir(%s): %m", box_dir);
}

/*** Commands ***/

static void
init(void)
{
  msg("Preparing sandbox directory\n");
  rmtree("box");
  if (mkdir("box", 0700) < 0)
    die("Cannot create box: %m");
  if (chown("box", orig_uid, orig_gid) < 0)
    die("Cannot chown box: %m");

  cg_prepare();
  set_quota();

  puts(box_dir);
}

static void
cleanup(void)
{
  if (!dir_exists("box"))
    die("Box directory not found, there isn't anything to clean up");

  msg("Deleting sandbox directory\n");
  rmtree(box_dir);
  cg_remove();
}

static void
run(char **argv)
{
  if (!dir_exists("box"))
    die("Box directory not found, did you run `isolate --init'?");

  chowntree("box", box_uid, box_gid);
  cleanup_ownership = 1;

  if (pipe(error_pipes) < 0)
    die("pipe: %m");
  for (int i=0; i<2; i++)
    if (fcntl(error_pipes[i], F_SETFD, fcntl(error_pipes[i], F_GETFD) | FD_CLOEXEC) < 0 ||
        fcntl(error_pipes[i], F_SETFL, fcntl(error_pipes[i], F_GETFL) | O_NONBLOCK) < 0)
      die("fcntl on pipe: %m");

  setup_signals();

  box_pid = clone(
    box_inside,			// Function to execute as the body of the new process
    argv,			// Pass our stack
    SIGCHLD | CLONE_NEWIPC | (share_net ? 0 : CLONE_NEWNET) | CLONE_NEWNS | CLONE_NEWPID,
    argv);			// Pass the arguments
  if (box_pid < 0)
    die("clone: %m");
  if (!box_pid)
    die("clone returned 0");
  box_keeper();
}

static void
show_version(void)
{
  printf("The process isolator " VERSION "\n");
  printf("(c) 2012--" YEAR " Martin Mares and Bernard Blackham\n");
  printf("Built on " BUILD_DATE " from Git commit " BUILD_COMMIT "\n");
}

/*** Options ***/

static void __attribute__((format(printf,1,2)))
usage(const char *msg, ...)
{
  if (msg != NULL)
    {
      va_list args;
      va_start(args, msg);
      vfprintf(stderr, msg, args);
      va_end(args);
    }
  printf("\
Usage: isolate [<options>] <command>\n\
\n\
Options:\n\
-b, --box-id=<id>\tWhen multiple sandboxes are used in parallel, each must get a unique ID\n\
    --cg\t\tEnable use of control groups\n\
    --cg-mem=<size>\tLimit memory usage of the control group to <size> KB\n\
    --cg-timing\t\tTime limits affects total run time of the control group\n\
-c, --chdir=<dir>\tChange directory to <dir> before executing the program\n\
-d, --dir=<dir>\t\tMake a directory <dir> visible inside the sandbox\n\
    --dir=<in>=<out>\tMake a directory <out> outside visible as <in> inside\n\
    --dir=<in>=\t\tDelete a previously defined directory rule (even a default one)\n\
    --dir=...:<opt>\tSpecify options for a rule:\n\
\t\t\t\tdev\tAllow access to special files\n\
\t\t\t\tfs\tMount a filesystem (e.g., --dir=/proc:proc:fs)\n\
\t\t\t\tmaybe\tSkip the rule if <out> does not exist\n\
\t\t\t\tnoexec\tDo not allow execution of binaries\n\
\t\t\t\trw\tAllow read-write access\n\
-f, --fsize=<size>\tMax size (in KB) of files that can be created\n\
-E, --env=<var>\t\tInherit the environment variable <var> from the parent process\n\
-E, --env=<var>=<val>\tSet the environment variable <var> to <val>; unset it if <var> is empty\n\
-x, --extra-time=<time>\tSet extra timeout, before which a timing-out program is not yet killed,\n\
\t\t\tso that its real execution time is reported (seconds, fractions allowed)\n\
-e, --full-env\t\tInherit full environment of the parent process\n\
-m, --mem=<size>\tLimit address space to <size> KB\n\
-M, --meta=<file>\tOutput process information to <file> (name:value)\n\
-q, --quota=<blk>,<ino>\tSet disk quota to <blk> blocks and <ino> inodes\n\
    --share-net\t\tShare network namespace with the parent process\n\
-s, --silent\t\tDo not print status messages except for fatal errors\n\
-k, --stack=<size>\tLimit stack size to <size> KB (default: 0=unlimited)\n\
-r, --stderr=<file>\tRedirect stderr to <file>\n\
-i, --stdin=<file>\tRedirect stdin from <file>\n\
-o, --stdout=<file>\tRedirect stdout to <file>\n\
-p, --processes[=<max>]\tEnable multiple processes (at most <max> of them); needs --cg\n\
-t, --time=<time>\tSet run time limit (seconds, fractions allowed)\n\
-v, --verbose\t\tBe verbose (use multiple times for even more verbosity)\n\
-w, --wall-time=<time>\tSet wall clock time limit (seconds, fractions allowed)\n\
\n\
Commands:\n\
    --init\t\tInitialize sandbox (and its control group when --cg is used)\n\
    --run -- <cmd> ...\tRun given command within sandbox\n\
    --cleanup\t\tClean up sandbox\n\
    --version\t\tDisplay program version and configuration\n\
");
  exit(2);
}

enum opt_code {
  OPT_INIT = 256,
  OPT_RUN,
  OPT_CLEANUP,
  OPT_VERSION,
  OPT_CG,
  OPT_CG_MEM,
  OPT_CG_TIMING,
  OPT_SHARE_NET,
};

static const char short_opts[] = "b:c:d:eE:i:k:m:M:o:p::q:r:st:vw:x:";

static const struct option long_opts[] = {
  { "box-id",		1, NULL, 'b' },
  { "chdir",		1, NULL, 'c' },
  { "cg",		0, NULL, OPT_CG },
  { "cg-mem",		1, NULL, OPT_CG_MEM },
  { "cg-timing",	0, NULL, OPT_CG_TIMING },
  { "cleanup",		0, NULL, OPT_CLEANUP },
  { "dir",		1, NULL, 'd' },
  { "fsize",		1, NULL, 'f' },
  { "env",		1, NULL, 'E' },
  { "extra-time",	1, NULL, 'x' },
  { "full-env",		0, NULL, 'e' },
  { "init",		0, NULL, OPT_INIT },
  { "mem",		1, NULL, 'm' },
  { "meta",		1, NULL, 'M' },
  { "processes",	2, NULL, 'p' },
  { "quota",		1, NULL, 'q' },
  { "run",		0, NULL, OPT_RUN },
  { "share-net",	0, NULL, OPT_SHARE_NET },
  { "silent",		0, NULL, 's' },
  { "stack",		1, NULL, 'k' },
  { "stderr",		1, NULL, 'r' },
  { "stdin",		1, NULL, 'i' },
  { "stdout",		1, NULL, 'o' },
  { "time",		1, NULL, 't' },
  { "verbose",		0, NULL, 'v' },
  { "version",		0, NULL, OPT_VERSION },
  { "wall-time",	1, NULL, 'w' },
  { NULL,		0, NULL, 0 }
};

int
main(int argc, char **argv)
{
  int c;
  char *sep;
  enum opt_code mode = 0;

  init_dir_rules();

  while ((c = getopt_long(argc, argv, short_opts, long_opts, NULL)) >= 0)
    switch (c)
      {
      case 'b':
	box_id = atoi(optarg);
	break;
      case 'c':
	set_cwd = optarg;
	break;
      case OPT_CG:
	cg_enable = 1;
	break;
      case 'd':
	if (!set_dir_action(optarg))
	  usage("Invalid directory specified: %s\n", optarg);
	break;
      case 'f':
        fsize_limit = atoi(optarg);
        break;
      case 'e':
	pass_environ = 1;
	break;
      case 'E':
	if (!set_env_action(optarg))
	  usage("Invalid environment specified: %s\n", optarg);
	break;
      case 'k':
	stack_limit = atoi(optarg);
	break;
      case 'i':
	redir_stdin = optarg;
	break;
      case 'm':
	memory_limit = atoi(optarg);
	break;
      case 'M':
	meta_open(optarg);
	break;
      case 'o':
	redir_stdout = optarg;
	break;
      case 'p':
	if (optarg)
	  max_processes = atoi(optarg);
	else
	  max_processes = 0;
	break;
      case 'q':
	sep = strchr(optarg, ',');
	if (!sep)
	  usage("Invalid quota specified: %s\n", optarg);
	block_quota = atoi(optarg);
	inode_quota = atoi(sep+1);
	break;
      case 'r':
	redir_stderr = optarg;
	break;
      case 's':
	silent++;
	break;
      case 't':
	timeout = 1000*atof(optarg);
	break;
      case 'v':
	verbose++;
	break;
      case 'w':
	wall_timeout = 1000*atof(optarg);
	break;
      case 'x':
	extra_timeout = 1000*atof(optarg);
	break;
      case OPT_INIT:
      case OPT_RUN:
      case OPT_CLEANUP:
      case OPT_VERSION:
	if (!mode || (int) mode == c)
	  mode = c;
	else
	  usage("Only one command is allowed.\n");
	break;
      case OPT_CG_MEM:
	cg_memory_limit = atoi(optarg);
	break;
      case OPT_CG_TIMING:
	cg_timing = 1;
	break;
      case OPT_SHARE_NET:
	share_net = 1;
	break;
      default:
	usage(NULL);
      }

  if (!mode)
    usage("Please specify an isolate command (e.g. --init, --run).\n");
  if (mode == OPT_VERSION)
    {
      show_version();
      return 0;
    }

  if (geteuid())
    die("Must be started as root");
  orig_uid = getuid();
  orig_gid = getgid();

  umask(022);
  cf_parse();
  box_init();
  cg_init();

  switch (mode)
    {
    case OPT_INIT:
      if (optind < argc)
	usage("--init mode takes no parameters\n");
      init();
      break;
    case OPT_RUN:
      if (optind >= argc)
	usage("--run mode requires a command to run\n");
      run(argv+optind);
      break;
    case OPT_CLEANUP:
      if (optind < argc)
	usage("--cleanup mode takes no parameters\n");
      cleanup();
      break;
    default:
      die("Internal error: mode mismatch");
    }
  exit(0);
}
