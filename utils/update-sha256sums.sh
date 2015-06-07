#!/bin/bash
# Script to generate the SHA256SUM files.

EXIT_SUCCESS=0;
EXIT_FAILURE=1;
EXIT_MISSING_ARGS=2;

SCRIPTNAME=`basename $0`;

DIRECTORY=$1;

if test -z "${DIRECTORY}" || test "${DIRECTORY}" = "macosx";
then
	(cd macosx && sha256sum *.dmg > SHA256SUMS);

	git commit -a -m "Updated Mac OS X builds of dependencies.";
fi

if test -z "${DIRECTORY}" || test "${DIRECTORY}" = "win32";
then
	(cd win32 && sha256sum *.exe *.msi > SHA256SUMS);

	git commit -a -m "Updated 32-bit Windows builds of dependencies.";
fi

if test -z "${DIRECTORY}" || test "${DIRECTORY}" = "win64";
then
	(cd win64 && sha256sum *.exe *.msi > SHA256SUMS);

	git commit -a -m "Updated 64-bit Windows builds of dependencies.";
fi

