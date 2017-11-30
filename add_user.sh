#!/bin/bash

# CONFIGURATION
GROUP="aodshub"                                          # new user group
REPO="https://github.com/scalation/scalation_kernel.git" # scalation_kernel repo
REPO_BRANCH="HEAD"                                       # branch to use
REPO_NOTEBOOKS="notebooks"                               # notebooks subdir in repo
USER_NOTEBOOKS="default-notebooks"                       # notebooks subdir in home

# OTHER VARIABLES
SCRIPT_NAME=$(readlink -f $0)                            # abs path for this script
USERNAME=$1

# CHECK COMMAND LINE ARGUMENTS
if [[ $# -ne 1 ]]; then
    echo "Invalid command line arguments." >&2
    echo "Usage: $SCRIPT_NAME username" >&2
    exit 1
fi

# create new user and add them to the group
adduser -q --gecos "" --disabled-password $USERNAME
usermod -a -G $GROUP $USERNAME
USERHOME=$(eval echo "~$USERNAME")

# add the default notebooks from the repo
cd "$USERHOME"
git clone --quiet "$REPO" "$USER_NOTEBOOKS"
cd "$USER_NOTEBOOKS"
git filter-branch --prune-empty --subdirectory-filter "$REPO_NOTEBOOKS" "$REPO_BRANCH"
chown -R $USERNAME:$USERNAME .
rm -rf .git

# fianlly exit
exit 0
