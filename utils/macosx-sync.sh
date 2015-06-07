#!/bin/bash
# Script to sync Mac OS binary builds.

EXIT_SUCCESS=0;
EXIT_FAILURE=1;
EXIT_MISSING_ARGS=2;

SCRIPTNAME=`basename $0`;

if test $# -ne 1;
then
  echo "Usage: ./${SCRIPTNAME} PATH";
  echo "";
  echo "  PATH: path of the directory containing the Mac OS X DMG files.";
  echo "";

  exit ${EXIT_MISSING_ARGS};
fi

SOURCE_PATH=$1;

OLDIFS=$IFS;
IFS="
";

FILES=`ls -1 ${SOURCE_PATH}/*.dmg`;

for FILE in ${FILES};
do
  FILE=`basename ${FILE}`;

  if test ! -f macosx/${FILE};
  then
    BASENAME=`echo ${FILE} | sed 's/-[0-9].*$//'`;
    EXISTING_FILE=`ls -1 macosx/${BASENAME}-* 2> /dev/null`;

    if ! test -z ${EXISTING_FILE};
    then
      echo "Removing old file: macosx/${EXISTING_FILE}";
      git rm -f ${EXISTING_FILE}
    fi

    echo "Creating new file: macosx/${FILE}";
    cp -f ${SOURCE_PATH}/${FILE} macosx/;
    git add macosx/${FILE};
  fi
done

IFS=$OLDIFS;

# (cd macosx && sha256sum *.dmg >> SHA256SUMS)

