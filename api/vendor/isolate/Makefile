# Makefile for Isolate
# (c) 2015--2016 Martin Mares <mj@ucw.cz>

all: isolate isolate.1 isolate.1.html

CC=gcc
CFLAGS=-std=gnu99 -Wall -Wextra -Wno-parentheses -Wno-unused-result -Wno-missing-field-initializers -D_GNU_SOURCE

VERSION=1.2
YEAR=2016
BUILD_DATE:=$(shell date '+%Y-%m-%d')
BUILD_COMMIT:=$(shell if git rev-parse >/dev/null 2>/dev/null ; then git describe --always ; else echo '<unknown>' ; fi)

PREFIX = $(DESTDIR)/usr/local
VARPREFIX = $(DESTDIR)/var/local
CONFIGDIR = $(PREFIX)/etc
CONFIG = $(CONFIGDIR)/isolate
BINDIR = $(PREFIX)/bin
DATAROOTDIR = $(PREFIX)/share
DATADIR = $(DATAROOTDIR)
MANDIR = $(DATADIR)/man
MAN1DIR = $(MANDIR)/man1
BOXDIR = $(VARPREFIX)/lib/isolate

isolate: isolate.o util.o rules.o cg.o config.o
	$(CC) $(LDFLAGS) -o $@ $^

%.o: %.c isolate.h config.h
	$(CC) $(CFLAGS) -c -o $@ $<

isolate.o: CFLAGS += -DVERSION='"$(VERSION)"' -DYEAR='"$(YEAR)"' -DBUILD_DATE='"$(BUILD_DATE)"' -DBUILD_COMMIT='"$(BUILD_COMMIT)"'
config.o: CFLAGS += -DCONFIG_FILE='"$(CONFIG)"'

isolate.1: isolate.1.txt
	a2x -f manpage $<

# The dependency on isolate.1 is there to serialize both calls of asciidoc,
# which does not name temporary files safely.
isolate.1.html: isolate.1.txt isolate.1
	a2x -f xhtml -D . $<

clean:
	rm -f *.o
	rm -f isolate isolate.1 isolate.1.html
	rm -f docbook-xsl.css

install: isolate
	install -D $< $(BINDIR)/$<
	chmod u+s $(BINDIR)/$<
	install -d $(BOXDIR)
	install -D default.cf $(CONFIG)

install-doc: isolate.1
	install -D $< $(MAN1DIR)/$<

.PHONY: all clean install install-doc
