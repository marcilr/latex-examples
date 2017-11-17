# -*- Mode: Makefile -*-
#
# Created Wed Feb 16 10:20:27 AKST 2011
# by Raymond E. Marcil <marcilr@gmail.com>
# Copyright (C) Raymond E. Marcil
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# This Makefile dives into src/tex and runs the Makefile there to
# build the Elluminate Manifesto from the elive-manifesto.tex.in 
# input file.
#


# Present working directory in BASE variable
BASE = $(shell pwd)

# Hardcode BASENAME
BASENAME=latex-examples


#
# Source code directory
#
SRC =  src

# Set VERSION file to use.
VERSIONFILE = "VERSION"

#
# Extract major,minor, and debug numbers from VERSION file.
# 1. Look at VERSION file with cat.
# 2. Extract "major =" line with grep.
# 3. Get 2nd field with major using cut.
# 4. Strip spaces with tr.
#
MAJOR = `${CAT} ${VERSIONFILE} | ${GREP} major | ${CUT} -f 2 -d '=' | ${TR} -d " "`
MINOR = `${CAT} ${VERSIONFILE} | ${GREP} minor | ${CUT} -f 2 -d '=' | ${TR} -d " "`
PATCH = `${CAT} ${VERSIONFILE} | ${GREP} patch | ${CUT} -f 2 -d '=' | ${TR} -d " "`

#
# Build VERSION number from MAJOR, MINOR, and PATCH
# The use of shell resolves the cat, grep, cut, and tr commands
# before executing targets.
#
VERSION = $(shell echo ${MAJOR}.${MINOR}.${PATCH})

#
# Build dist directory with basename and version.
# i.e. Ready to tar for distribution tarball.
#
DIST = ${BASENAME}-${VERSION}

#
# Distribution tarball filename.
#
BZ2 = ${DIST}.tar.bz2


#
# Directories with Makefiles to run
# 
DIRS = ${SRC}/tex


#
# Binaries
#
CAT    = cat
CP     = cp
CUT    = cut
FIND   = find
GREP   = grep
MKDIR  = mkdir -p
PS2PDF = ps2pdf
RM     = rm -rf
RSYNC  = rsync -va --progress --stats --exclude ".svn" --exclude "*~" --exclude "*bak"
SED    = sed
TAR    = tar
TR     = tr


# Define phony. i.e. non-file targets.
.PHONY: all clean mostlyclean cycle dist


#
# Dive into DIRS and run Makefiles.
#
all:
	for dir in $(DIRS); do make -C $$dir $@; done



#
# Copy all files to versioned subdirectory.  Used to create distribution 
# tarball.  A trailing slash on the rsync source path tells rsync copy the
# files from that directory into the target directory.  If there is no 
# trailing slash, the directory itself will be copied and created if 
# necessary.  Using rsync since no exclude with cp.  Remember the rsync
# trailing slash means to copy all files in a subdirectory.
#
${DIST}: 
	${RSYNC} ${BASE}/ ${DIST}

#
# Build distribution tarball.
#
${BZ2}: ${DIST}
	${TAR} -cvjpf ${BZ2} ${DIST}
	

#
# Build source distribution tarball.
# o Builds Elluminate Manifesto for inclusion.
# o Cleans out build and extraneous files.
# o Builds elive-manifesto-x.y.x.tar.bz2 distribution.
#
dist: all mostlyclean ${BZ2}
	${RM} ${DIST}


#
# Clean up 
#
clean:
	for dir in $(DIRS); do make -C $$dir $@ clean; done
	${RM} *.pdf ${BASENAME}-${VERSION} ${BZ2}

#
# Clean up with exception of Elluminate Manifesto pdf.
#
mostlyclean:
	for dir in $(DIRS); do make -C $$dir $@ mostlyclean; done
	${RM} ${BASENAME}-${VERSION} ${BZ2}

#
# Cycle through rebuild.
#
cycle: clean all
