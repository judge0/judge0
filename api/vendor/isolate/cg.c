/*
 *	Process Isolator -- Control Groups
 *
 *	(c) 2012-2016 Martin Mares <mj@ucw.cz>
 *	(c) 2012-2014 Bernard Blackham <bernard@blackham.com.au>
 */

#include "isolate.h"

#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <unistd.h>

struct cg_controller_desc {
  const char *name;
  int optional;
};

typedef enum {
  CG_MEMORY = 0,
  CG_CPUACCT,
  CG_CPUSET,
  CG_NUM_CONTROLLERS,
} cg_controller;

static const struct cg_controller_desc cg_controllers[CG_NUM_CONTROLLERS+1] = {
  [CG_MEMORY]  = { "memory",  0 },
  [CG_CPUACCT] = { "cpuacct", 0 },
  [CG_CPUSET]  = { "cpuset",  1 },
  [CG_NUM_CONTROLLERS] = { NULL, 0 },
};

#define FOREACH_CG_CONTROLLER(_controller) \
  for (cg_controller (_controller) = 0; \
       (_controller) < CG_NUM_CONTROLLERS; (_controller)++)

static const char *cg_controller_name(cg_controller c)
{
  return cg_controllers[c].name;
}

static int cg_controller_optional(cg_controller c)
{
  return cg_controllers[c].optional;
}

static char cg_name[256];

#define CG_BUFSIZE 1024

static void
cg_makepath(char *buf, size_t len, cg_controller c, const char *attr)
{
  snprintf(buf, len, "%s/%s/%s/%s", cf_cg_root, cg_controller_name(c), cg_name, attr);
}

static int
cg_read(cg_controller controller, const char *attr, char *buf)
{
  int result = 0;
  int maybe = 0;
  if (attr[0] == '?')
    {
      attr++;
      maybe = 1;
    }

  char path[256];
  cg_makepath(path, sizeof(path), controller, attr);

  int fd = open(path, O_RDONLY);
  if (fd < 0)
    {
      if (maybe)
	goto fail;
      die("Cannot read %s: %m", path);
    }

  int n = read(fd, buf, CG_BUFSIZE);
  if (n < 0)
    {
      if (maybe)
	goto fail_close;
      die("Cannot read %s: %m", path);
    }
  if (n >= CG_BUFSIZE - 1)
    die("Attribute %s too long", path);
  if (n > 0 && buf[n-1] == '\n')
    n--;
  buf[n] = 0;

  if (verbose > 1)
    msg("CG: Read %s = %s\n", attr, buf);

  result = 1;
fail_close:
  close(fd);
fail:
  return result;
}

static void __attribute__((format(printf,3,4)))
cg_write(cg_controller controller, const char *attr, const char *fmt, ...)
{
  int maybe = 0;
  if (attr[0] == '?')
    {
      attr++;
      maybe = 1;
    }

  va_list args;
  va_start(args, fmt);

  char buf[CG_BUFSIZE];
  int n = vsnprintf(buf, sizeof(buf), fmt, args);
  if (n >= CG_BUFSIZE)
    die("cg_write: Value for attribute %s is too long", attr);

  if (verbose > 1)
    msg("CG: Write %s = %s", attr, buf);

  char path[256];
  cg_makepath(path, sizeof(path), controller, attr);

  int fd = open(path, O_WRONLY | O_TRUNC);
  if (fd < 0)
    {
      if (maybe)
	goto fail;
      else
	die("Cannot write %s: %m", path);
    }

  int written = write(fd, buf, n);
  if (written < 0)
    {
      if (maybe)
	goto fail_close;
      else
	die("Cannot set %s to %s: %m", path, buf);
    }
  if (written != n)
    die("Short write to %s (%d out of %d bytes)", path, written, n);

fail_close:
  close(fd);
fail:
  va_end(args);
}

void
cg_init(void)
{
  if (!cg_enable)
    return;

  if (!dir_exists(cf_cg_root))
    die("Control group filesystem at %s not mounted", cf_cg_root);

  snprintf(cg_name, sizeof(cg_name), "box-%d", box_id);
  msg("Using control group %s\n", cg_name);
}

void
cg_prepare(void)
{
  if (!cg_enable)
    return;

  struct stat st;
  char buf[CG_BUFSIZE];
  char path[256];

  FOREACH_CG_CONTROLLER(controller)
    {
      cg_makepath(path, sizeof(path), controller, "");
      if (stat(path, &st) >= 0 || errno != ENOENT)
	{
	  msg("Control group %s already exists, trying to empty it.\n", path);
	  if (rmdir(path) < 0)
	    die("Failed to reset control group %s: %m", path);
	}

      if (mkdir(path, 0777) < 0 && !cg_controller_optional(controller))
	die("Failed to create control group %s: %m", path);
    }

  // If cpuset module is enabled, copy allowed cpus and memory nodes from parent group
  if (cg_read(CG_CPUSET, "?cpuset.cpus", buf))
    cg_write(CG_CPUSET, "cpuset.cpus", "%s", buf);
  if (cg_read(CG_CPUSET, "?cpuset.mems", buf))
    cg_write(CG_CPUSET, "cpuset.mems", "%s", buf);
}

void
cg_enter(void)
{
  if (!cg_enable)
    return;

  msg("Entering control group %s\n", cg_name);

  FOREACH_CG_CONTROLLER(controller)
    {
      if (cg_controller_optional(controller))
	cg_write(controller, "?tasks", "%d\n", (int) getpid());
      else
	cg_write(controller, "tasks", "%d\n", (int) getpid());
    }

  if (cg_memory_limit)
    {
      cg_write(CG_MEMORY, "memory.limit_in_bytes", "%lld\n", (long long) cg_memory_limit << 10);
      cg_write(CG_MEMORY, "?memory.memsw.limit_in_bytes", "%lld\n", (long long) cg_memory_limit << 10);
    }

  if (cg_timing)
    cg_write(CG_CPUACCT, "cpuacct.usage", "0\n");
}

int
cg_get_run_time_ms(void)
{
  if (!cg_enable)
    return 0;

  char buf[CG_BUFSIZE];
  cg_read(CG_CPUACCT, "cpuacct.usage", buf);
  unsigned long long ns = atoll(buf);
  return ns / 1000000;
}

void
cg_stats(void)
{
  if (!cg_enable)
    return;

  char buf[CG_BUFSIZE];

  // Memory usage statistics
  unsigned long long mem=0, memsw=0;
  if (cg_read(CG_MEMORY, "?memory.max_usage_in_bytes", buf))
    mem = atoll(buf);
  if (cg_read(CG_MEMORY, "?memory.memsw.max_usage_in_bytes", buf))
    {
      memsw = atoll(buf);
      if (memsw > mem)
	mem = memsw;
    }
  if (mem)
    meta_printf("cg-mem:%lld\n", mem >> 10);
}

void
cg_remove(void)
{
  char buf[CG_BUFSIZE];

  if (!cg_enable)
    return;

  FOREACH_CG_CONTROLLER(controller)
    {
      if (cg_controller_optional(controller))
	{
	  if (!cg_read(controller, "?tasks", buf))
	    continue;
	}
      else
	cg_read(controller, "tasks", buf);

      if (buf[0])
	die("Some tasks left in controller %s of cgroup %s, failed to remove it",
	    cg_controller_name(controller), cg_name);

      char path[256];
      cg_makepath(path, sizeof(path), controller, "");

      if (rmdir(path) < 0)
	die("Cannot remove control group %s: %m", path);
    }
}
