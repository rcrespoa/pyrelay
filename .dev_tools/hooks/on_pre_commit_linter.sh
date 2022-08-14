#!/bin/bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
cd $SCRIPTPATH/
exec 1>&2
SRC_PATH=$SCRIPTPATH/../../pysub/pysub/

source $SCRIPTPATH/../env/bin/activate

# #################################################################################
# [flake8]
# #################################################################################
echo "$SCRIPTPATH/../config/.flake8"
echo "[flake8] $SRC_PATH"
if ! flake8 $SRC_PATH --config $SCRIPTPATH/../config/.flake8;
then
    echo "Early exit: flake8 exited with code != 0"
    exit 1
fi

# #################################################################################
# [mypy]
# #################################################################################
echo "[mypy] $SRC_PATH"
if ! mypy $SRC_PATH;
then
    echo "Early exit: mypy exited with code != 0"
    exit 1
fi