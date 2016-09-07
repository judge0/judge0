/*
 *	Process Isolator -- Utility Functions
 *
 *	(c) 2012-2016 Martin Mares <mj@ucw.cz>
 *	(c) 2012-2014 Bernard Blackham <bernard@blackham.com.au>
 */

#include "isolate.h"

#include <errno.h>
#include <ftw.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/fsuid.h>
#include <sys/stat.h>
#include <unistd.h>

void *
xmalloc(size_t size)
{
  void *p = malloc(size);
  if (!p)
    die("Out of memory");
  return p;
}

char *
xstrdup(char *str)
{
  char *p = strdup(str);
  if (!p)
    die("Out of memory");
  return p;
}

int
dir_exists(char *path)
{
  struct stat st;
  return (stat(path, &st) >= 0 && S_ISDIR(st.st_mode));
}

void make_dir(char *path)
{
  char *sep = (path[0] == '/' ? path+1 : path);

  for (;;)
    {
      sep = strchr(sep, '/');
      if (sep)
	*sep = 0;

      if (mkdir(path, 0777) < 0 && errno != EEXIST)
	die("Cannot create directory %s: %m", path);

      if (!sep)
	break;
      *sep++ = '/';
    }

 // mkdir() above may have returned EEXIST even if the path was not
 // a directory. Ensure that it is.
  struct stat st;
  if (stat(path, &st) < 0)
    die("Cannot stat %s: %m", path);
  if (!S_ISDIR(st.st_mode))
    die("Cannot create %s: already exists, but not a directory", path);
}


static int rmtree_helper(const char *fpath, const struct stat *sb,
    int typeflag UNUSED, struct FTW *ftwbuf UNUSED)
{
  if (S_ISDIR(sb->st_mode))
    {
      if (rmdir(fpath) < 0)
	die("Cannot rmdir %s: %m", fpath);
    }
  else
    {
      if (unlink(fpath) < 0)
	die("Cannot unlink %s: %m", fpath);
    }
  return FTW_CONTINUE;
}

void
rmtree(char *path)
{
  nftw(path, rmtree_helper, 32, FTW_MOUNT | FTW_PHYS | FTW_DEPTH);
}

static uid_t chown_uid;
static gid_t chown_gid;

static int chowntree_helper(const char *fpath, const struct stat *sb UNUSED,
    int typeflag UNUSED, struct FTW *ftwbuf UNUSED)
{
  if (lchown(fpath, chown_uid, chown_gid) < 0)
    die("Cannot chown %s: %m", fpath);
  else
    return FTW_CONTINUE;
}

void
chowntree(char *path, uid_t uid, gid_t gid)
{
  chown_uid = uid;
  chown_gid = gid;
  nftw(path, chowntree_helper, 32, FTW_MOUNT | FTW_PHYS);
}

/*** Meta-files ***/

static FILE *metafile;

void
meta_open(const char *name)
{
  if (!strcmp(name, "-"))
    {
      metafile = stdout;
      return;
    }
  if (setfsuid(getuid()) < 0)
    die("Failed to switch FS UID: %m");
  metafile = fopen(name, "w");
  if (setfsuid(geteuid()) < 0)
    die("Failed to switch FS UID back: %m");
  if (!metafile)
    die("Failed to open metafile '%s'",name);
}

void
meta_close(void)
{
  if (metafile && metafile != stdout)
    fclose(metafile);
}

void
meta_printf(const char *fmt, ...)
{
  if (!metafile)
    return;

  va_list args;
  va_start(args, fmt);
  vfprintf(metafile, fmt, args);
  va_end(args);
}
