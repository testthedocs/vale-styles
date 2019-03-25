#!/bin/bash

set -eo pipefail

# Vars
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"

# Functions


LATEST_COMMIT=$(git rev-parse HEAD)
# latest commit where packages/material-ui-codemod was changed
FOLDER_COMMIT=$(git log -1 --format=format:%H --full-diff CHANGELOG.md)
if [ "$FOLDER_COMMIT" != "$LATEST_COMMIT" ]
then
    echo -en "$COL_RED It seems you forgot to update the Changelog :) $COL_RESET\n"
    exit 1
fi
exit 0

