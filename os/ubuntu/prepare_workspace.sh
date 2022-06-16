#!/bin/bash

# Create project directory
echo '[Workspace] #1 Create project directory...'
workspace_dir="$HOME/projects"
mkdir -p $workspace_dir

# Create gitconfig from template
echo '[Workspace] #2 Create gitconfig...'
mkdir -p ./temporary

envsubst > ./temporary/gitconfig <<-EOL
[user]
  email = ${DEV_MACHINE_USER_EMAIL}
  name = ${DEV_MACHINE_USER_FULL_NAME}
  signinkey = ${DEV_MACHINE_SIGNINKEY}
[commit]
  gpgsign = true
EOL

# Copy gitconfig to destination
yes | cp -i ./temporary/gitconfig "$workspace_dir/.gitconfig"

# Include current gitconfig in global gitconfig
global_gitconfig="$HOME/.gitconfig"
if ! grep -q "gitdir/i:$workspace_dir" $global_gitconfig; then
envsubst >> $global_gitconfig <<-EOL

[includeIf "gitdir/i:${workspace_dir}/"]
  path = ${workspace_dir}/.gitconfig
EOL
fi

# Cleanup
rm -rf ./temporary

echo '[Workspace] Done'
