/*
 *	Process Isolator -- Configuration File
 *
 *	(c) 2016 Martin Mares <mj@ucw.cz>
 */

#include "isolate.h"

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_LINE_LEN 1024

char *cf_box_root;
char *cf_cg_root;
int cf_first_uid;
int cf_first_gid;
int cf_num_boxes;

static int line_number;

static void NONRET
cf_err(char *msg)
{
  die("Error in config file, line %d: %s", line_number, msg);
}

static char *
cf_string(char *val)
{
  return xstrdup(val);
}

static int
cf_int(char *val)
{
  char *end;
  errno = 0;
  long int x = strtol(val, &end, 10);
  if (errno || end == val || end && *end)
    cf_err("Invalid number");
  if ((long int)(int) x != x)
    cf_err("Number out of range");
  return x;
}

void cf_entry(char *key, char *val)
{
  if (!strcmp(key, "box_root"))
    cf_box_root = cf_string(val);
  else if (!strcmp(key, "cg_root"))
    cf_cg_root = cf_string(val);
  else if (!strcmp(key, "first_uid"))
    cf_first_uid = cf_int(val);
  else if (!strcmp(key, "first_gid"))
    cf_first_gid = cf_int(val);
  else if (!strcmp(key, "num_boxes"))
    cf_num_boxes = cf_int(val);
  else
    cf_err("Unknown configuration item");
}

static void
cf_check(void)
{
  if (!cf_box_root ||
      !cf_cg_root ||
      !cf_first_uid ||
      !cf_first_gid ||
      !cf_num_boxes)
    cf_err("Configuration is not complete");
}

void
cf_parse(void)
{
  FILE *f = fopen(CONFIG_FILE, "r");
  if (!f)
    die("Cannot open %s: %m", CONFIG_FILE);

  char line[MAX_LINE_LEN];
  while (fgets(line, sizeof(line), f))
    {
      line_number++;
      char *nl = strchr(line, '\n');
      if (!nl)
	cf_err("Line not terminated or too long");
      *nl = 0;

      if (!line[0] || line[0] == '#')
	continue;

      char *s = line;
      while (*s && *s != ' ' && *s != '\t' && *s != '=')
	s++;
      while (*s == ' ' || *s == '\t')
	*s++ = 0;
      if (*s != '=')
	cf_err("Syntax error, expecting key=value");
      *s++ = 0;
      while (*s == ' ' || *s == '\t')
	*s++ = 0;

      cf_entry(line, s);
    }

  fclose(f);
  cf_check();
}
