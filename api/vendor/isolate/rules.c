/*
 *	Process Isolator -- Rules
 *
 *	(c) 2012-2016 Martin Mares <mj@ucw.cz>
 *	(c) 2012-2014 Bernard Blackham <bernard@blackham.com.au>
 */

#include "isolate.h"

#include <limits.h>
#include <mntent.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mount.h>
#include <sys/quota.h>
#include <sys/stat.h>
#include <sys/vfs.h>
#include <unistd.h>

/*** Environment rules ***/

struct env_rule {
  char *var;			// Variable to match
  char *val;			// ""=clear, NULL=inherit
  int var_len;
  struct env_rule *next;
};

static struct env_rule *first_env_rule;
static struct env_rule **last_env_rule = &first_env_rule;

static struct env_rule default_env_rules[] = {
  { .var = "LIBC_FATAL_STDERR_", .val = "1", .var_len = 18 },
};

int
set_env_action(char *a0)
{
  struct env_rule *r = xmalloc(sizeof(*r) + strlen(a0) + 1);
  char *a = (char *)(r+1);
  strcpy(a, a0);

  char *sep = strchr(a, '=');
  if (sep == a)
    return 0;
  r->var = a;
  if (sep)
    {
      *sep++ = 0;
      r->val = sep;
    }
  else
    r->val = NULL;
  *last_env_rule = r;
  last_env_rule = &r->next;
  r->next = NULL;
  return 1;
}

static int
match_env_var(char *env_entry, struct env_rule *r)
{
  if (strncmp(env_entry, r->var, r->var_len))
    return 0;
  return (env_entry[r->var_len] == '=');
}

static void
apply_env_rule(char **env, int *env_sizep, struct env_rule *r)
{
  // First remove the variable if already set
  int pos = 0;
  while (pos < *env_sizep && !match_env_var(env[pos], r))
    pos++;
  if (pos < *env_sizep)
    {
      (*env_sizep)--;
      env[pos] = env[*env_sizep];
      env[*env_sizep] = NULL;
    }

  // What is the new value?
  char *new;
  if (r->val)
    {
      if (!r->val[0])
	return;
      new = xmalloc(r->var_len + 1 + strlen(r->val) + 1);
      sprintf(new, "%s=%s", r->var, r->val);
    }
  else
    {
      pos = 0;
      while (environ[pos] && !match_env_var(environ[pos], r))
	pos++;
      if (!(new = environ[pos]))
	return;
    }

  // Add it at the end of the array
  env[(*env_sizep)++] = new;
  env[*env_sizep] = NULL;
}

char **
setup_environment(void)
{
  // Link built-in rules with user rules
  for (int i=ARRAY_SIZE(default_env_rules)-1; i >= 0; i--)
    {
      default_env_rules[i].next = first_env_rule;
      first_env_rule = &default_env_rules[i];
    }

  // Scan the original environment
  char **orig_env = environ;
  int orig_size = 0;
  while (orig_env[orig_size])
    orig_size++;

  // For each rule, reserve one more slot and calculate length
  int num_rules = 0;
  for (struct env_rule *r = first_env_rule; r; r=r->next)
    {
      num_rules++;
      r->var_len = strlen(r->var);
    }

  // Create a new environment
  char **env = xmalloc((orig_size + num_rules + 1) * sizeof(char *));
  int size;
  if (pass_environ)
    {
      memcpy(env, environ, orig_size * sizeof(char *));
      size = orig_size;
    }
  else
    size = 0;
  env[size] = NULL;

  // Apply the rules one by one
  for (struct env_rule *r = first_env_rule; r; r=r->next)
    apply_env_rule(env, &size, r);

  // Return the new env and pass some gossip
  if (verbose > 1)
    {
      fprintf(stderr, "Passing environment:\n");
      for (int i=0; env[i]; i++)
	fprintf(stderr, "\t%s\n", env[i]);
    }
  return env;
}

/*** Directory rules ***/

struct dir_rule {
  char *inside;			// A relative path
  char *outside;		// This can be an absolute path or a relative path starting with "./"
  unsigned int flags;		// DIR_FLAG_xxx
  struct dir_rule *next;
};

enum dir_rule_flags {
  DIR_FLAG_RW = 1,
  DIR_FLAG_NOEXEC = 2,
  DIR_FLAG_FS = 4,
  DIR_FLAG_MAYBE = 8,
  DIR_FLAG_DEV = 16,
};

static const char * const dir_flag_names[] = { "rw", "noexec", "fs", "maybe", "dev" };

static struct dir_rule *first_dir_rule;
static struct dir_rule **last_dir_rule = &first_dir_rule;

static int add_dir_rule(char *in, char *out, unsigned int flags)
{
  // Make sure that "in" is relative
  while (in[0] == '/')
    in++;
  if (!*in)
    return 0;

  // Check "out"
  if (flags & DIR_FLAG_FS)
    {
      if (!out || out[0] == '/')
	return 0;
    }
  else
    {
      if (out && out[0] != '/' && strncmp(out, "./", 2))
	return 0;
    }

  // Override an existing rule
  struct dir_rule *r;
  for (r = first_dir_rule; r; r = r->next)
    if (!strcmp(r->inside, in))
      break;

  // Add a new rule
  if (!r)
    {
      r = xmalloc(sizeof(*r));
      r->inside = in;
      *last_dir_rule = r;
      last_dir_rule = &r->next;
      r->next = NULL;
    }
  r->outside = out;
  r->flags = flags;
  return 1;
}

static unsigned int parse_dir_option(char *opt)
{
  for (unsigned int i = 0; i < ARRAY_SIZE(dir_flag_names); i++)
    if (!strcmp(opt, dir_flag_names[i]))
      return 1U << i;
  die("Unknown directory option %s", opt);
}

int set_dir_action(char *arg)
{
  arg = xstrdup(arg);

  char *colon = strchr(arg, ':');
  unsigned int flags = 0;
  while (colon)
    {
      *colon++ = 0;
      char *next = strchr(colon, ':');
      if (next)
	*next = 0;
      flags |= parse_dir_option(colon);
      colon = next;
    }

  char *eq = strchr(arg, '=');
  if (eq)
    {
      *eq++ = 0;
      return add_dir_rule(arg, (*eq ? eq : NULL), flags);
    }
  else
    {
      char *out = xmalloc(1 + strlen(arg) + 1);
      sprintf(out, "/%s", arg);
      return add_dir_rule(arg, out, flags);
    }
}

void init_dir_rules(void)
{
  set_dir_action("box=./box:rw");
  set_dir_action("bin");
  set_dir_action("dev:dev");
  set_dir_action("lib");
  set_dir_action("lib64:maybe");
  set_dir_action("proc=proc:fs");
  set_dir_action("usr");
}

void apply_dir_rules(void)
{
  for (struct dir_rule *r = first_dir_rule; r; r=r->next)
    {
      char *in = r->inside;
      char *out = r->outside;
      if (!out)
	{
	  msg("Not binding anything on %s\n", r->inside);
	  continue;
	}

      if ((r->flags & DIR_FLAG_MAYBE) && !dir_exists(out))
	{
	  msg("Not binding %s on %s (does not exist)\n", out, r->inside);
	  continue;
	}

      char root_in[1024];
      snprintf(root_in, sizeof(root_in), "root/%s", in);
      make_dir(root_in);

      unsigned long mount_flags = 0;
      if (!(r->flags & DIR_FLAG_RW))
	mount_flags |= MS_RDONLY;
      if (r->flags & DIR_FLAG_NOEXEC)
	mount_flags |= MS_NOEXEC;
      if (!(r->flags & DIR_FLAG_DEV))
	mount_flags |= MS_NODEV;

      if (r->flags & DIR_FLAG_FS)
	{
	  msg("Mounting %s on %s (flags %lx)\n", out, in, mount_flags);
	  if (mount("none", root_in, out, mount_flags, "") < 0)
	    die("Cannot mount %s on %s: %m", out, in);
	}
      else
	{
	  mount_flags |= MS_BIND | MS_NOSUID;
	  msg("Binding %s on %s (flags %lx)\n", out, in, mount_flags);
	  // Most mount flags need remount to work
	  if (mount(out, root_in, "none", mount_flags, "") < 0 ||
	      mount(out, root_in, "none", MS_REMOUNT | mount_flags, "") < 0)
	    die("Cannot mount %s on %s: %m", out, in);
	}
    }
}

/*** Disk quotas ***/

static int
path_begins_with(char *path, char *with)
{
  while (*with)
    if (*path++ != *with++)
      return 0;
  return (!*with || *with == '/');
}

static char *
find_device(char *path)
{
  FILE *f = setmntent("/proc/mounts", "r");
  if (!f)
    die("Cannot open /proc/mounts: %m");

  struct mntent *me;
  int best_len = 0;
  char *best_dev = NULL;
  while (me = getmntent(f))
    {
      if (!path_begins_with(me->mnt_fsname, "/dev"))
	continue;
      if (path_begins_with(path, me->mnt_dir))
	{
	  int len = strlen(me->mnt_dir);
	  if (len > best_len)
	    {
	      best_len = len;
	      free(best_dev);
	      best_dev = xstrdup(me->mnt_fsname);
	    }
	}
    }
  endmntent(f);
  return best_dev;
}

void
set_quota(void)
{
  if (!block_quota)
    return;

  char cwd[PATH_MAX];
  if (!getcwd(cwd, sizeof(cwd)))
    die("getcwd: %m");

  char *dev = find_device(cwd);
  if (!dev)
    die("Cannot identify filesystem which contains %s", cwd);
  msg("Quota: Mapped path %s to a filesystem on %s\n", cwd, dev);

  // Sanity check
  struct stat dev_st, cwd_st;
  if (stat(dev, &dev_st) < 0)
    die("Cannot identify block device %s: %m", dev);
  if (!S_ISBLK(dev_st.st_mode))
    die("Expected that %s is a block device", dev);
  if (stat(".", &cwd_st) < 0)
    die("Cannot stat cwd: %m");
  if (cwd_st.st_dev != dev_st.st_rdev)
    die("Identified %s as a filesystem on %s, but it is obviously false", cwd, dev);

  struct dqblk dq = {
    .dqb_bhardlimit = block_quota,
    .dqb_bsoftlimit = block_quota,
    .dqb_ihardlimit = inode_quota,
    .dqb_isoftlimit = inode_quota,
    .dqb_valid = QIF_LIMITS,
  };
  if (quotactl(QCMD(Q_SETQUOTA, USRQUOTA), dev, box_uid, (caddr_t) &dq) < 0)
    die("Cannot set disk quota: %m");
  msg("Quota: Set block quota %d and inode quota %d\n", block_quota, inode_quota);

  free(dev);
}
