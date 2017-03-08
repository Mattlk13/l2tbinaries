#!/bin/bash
#
# Script to set up Travis-CI test VM.

PYTHON2_DEPENDENCIES="python-plaso";

PYTHON3_DEPENDENCIES="python3-plaso";

# Exit on error.
set -e;

if test `uname -s` = "Darwin";
then
	git clone https://github.com/log2timeline/l2tdevtools.git;

	mv l2tdevtools ../;
	mkdir dependencies;

	PYTHONPATH=../l2tdevtools ../l2tdevtools/tools/update.py --download-directory=dependencies

elif test `uname -s` = "Linux";
then
	sudo add-apt-repository ppa:gift/dev -y;
	sudo apt-get update -q;
	sudo apt-get install -y ${PYTHON2_DEPENDENCIES};
fi
