#!/bin/bash
###############################################################################
# HOOK ADAPTER START
###############################################################################
SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
ROOT_PATH=$SCRIPT_PATH/../..

# colors
LIME_YELLOW=$(tput setaf 190)
POWDER_BLUE=$(tput setaf 153)
NORMAL=$(tput sgr0)

# This script will live in .git/hooks/pre-commit
# Must set relative directory in HOOK_DIR to hooks directory
HOOK_DIR=$SCRIPT_PATH/../../.dev_tools/hooks

printf "%40s\n" "${LIME_YELLOW}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${POWDER_BLUE} [CUSTOM HOOKS START] ${LIME_YELLOW}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NORMAL}"
# iterate over all hooks list all files in a directory
for f in $(find $HOOK_DIR -type f); do
    # check if file does not ends in sh or begin with on
    if [[ $f != *.sh && $f != *on_* ]]; then
        continue
    fi

    # get file name
    hook_name=$(basename $f)
    printf "%40s\n" "${LIME_YELLOW}### ${POWDER_BLUE}Executing hook [${LIME_YELLOW}$hook_name${POWDER_BLUE}] ...${NORMAL}"
    # execute bash script and get exit code
    if ! bash $f;
    then
        printf "%40s\n" "${LIME_YELLOW}### ${POWDER_BLUE}[${LIME_YELLOW}$hook_name${POWDER_BLUE}] Failed"
        exit 1
    fi
    printf "%40s\n" "${LIME_YELLOW}### ${POWDER_BLUE}[${LIME_YELLOW}$hook_name${POWDER_BLUE}] Succeded"
done
printf "%40s\n" "${LIME_YELLOW}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${POWDER_BLUE} [CUSTOM HOOKS END] ${LIME_YELLOW}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NORMAL}"
###############################################################################
# HOOK ADAPTER END
###############################################################################
