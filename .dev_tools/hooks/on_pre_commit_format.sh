#!/bin/bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
cd $SCRIPTPATH/

SRC_PATH=$SCRIPTPATH/../../pyrelay/pyrelay/
LINE_LENGTH=150

source $SCRIPTPATH/../env/bin/activate

# #################################################################################
# # [isort]
# #################################################################################
echo "[isort] $SRC_PATH"
if ! isort $SRC_PATH --check-only --diff --sp $SCRIPTPATH/../config/.isort.cfg; then
    echo "Early exit: isort exited with code != 0"
    exit 1
fi

#################################################################################
# [black]
#################################################################################
echo "[black] $SRC_PATH"
if ! black $SRC_PATH --check --diff --color -l $LINE_LENGTH; then
    echo "Early exit: black exited with code != 0"
    exit 1
fi
