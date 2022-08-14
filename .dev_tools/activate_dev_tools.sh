#!/bin/sh
SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
ENV_PATH=$SCRIPT_PATH/env
echo $SCRIPT_PATH
############################################################################
# Set up VENV
############################################################################
source $ENV_PATH/bin/activate

# source .dev_tools/activate_dev_tools.sh