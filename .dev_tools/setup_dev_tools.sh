#!/bin/sh
SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
ENV_PATH=$SCRIPT_PATH/env
ROOT_PATH=$SCRIPT_PATH/..

############################################################################
# Set up main VENV
############################################################################
python3 -m venv $ENV_PATH
source $ENV_PATH/bin/activate
pip3 install -r $SCRIPT_PATH/dev-requirements.txt

############################################################################
# Set up pre-commit hooks
############################################################################
pre-commit install

############################################################################
# Set up custom bash pre-commit hooks
############################################################################
GIT_PRE_COMMIT_PATH=$SCRIPT_PATH/../.git/hooks/pre-commit
TMP1_PATH=$SCRIPT_PATH/tmp.sh
TMP2_PATH=$SCRIPT_PATH/tmp2.sh

# Create new file
cat $GIT_PRE_COMMIT_PATH > $TMP1_PATH
cat $SCRIPT_PATH/hook_adapter.sh > $TMP2_PATH

# Run pre-commit (python) last
cat $TMP1_PATH >> $TMP2_PATH

# Replace pre-commit file
cat $TMP2_PATH > $GIT_PRE_COMMIT_PATH

# delete temp files
rm $TMP1_PATH
rm $TMP2_PATH