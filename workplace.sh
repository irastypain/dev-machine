#!/bin/bash

# Export ENV variables
ENV_FILE=$ENV_FILE source ./load_env.sh

# Create project directory
workplace_dir="$HOME/projects/test/$DEV_MACHINE_WORKPLACE_NAME"
mkdir -p $workplace_dir

# Create gitconfig from template
mkdir -p ./temporary
envsubst > ./temporary/gitconfig < ./templates/gitconfig

# Copy gitconfig to destination
cp -i ./temporary/gitconfig "$workplace_dir/.gitconfig"

# Include current gitconfig in global gitconfig
global_gitconfig="$HOME/.gitconfig"
if ! grep -q "gitdir/i:$workplace_dir" $global_gitconfig; then
  GIT_DIR=$workplace_dir envsubst >> $global_gitconfig < ./templates/gitconfig_include_if
fi

# Cleanup
rm -rf ./temporary
