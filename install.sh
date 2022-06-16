#!/bin/bash

source './lib/utils'

# Export ENV variables
dotenv '.env'

scripts_path="./scripts/os/$DEV_MACHINE_OS"

# Prepare OS
ssh -t $DEV_MACHINE_HOST "$(echo $(< $CURRENT_ENV_FILE)) sh" < "$scripts_path/prepare_system.sh"

# Create workspaces
for workspace in "${DEV_MACHINE_WORKSPACES[@]}"; do
  echo "[Workspace: $workspace] Prepare..."
  dotenv ".env.$workspace"

  # Create user
  ssh -t $DEV_MACHINE_HOST "$(echo $(< $CURRENT_ENV_FILE)) sh" < "$scripts_path/create_user.sh"

  # Prepare SSH
  sh ./scripts/copy_identity.sh

  # Configure devtools
  ssh -t $DEV_MACHINE_USER@$DEV_MACHINE_HOST "$(echo $(< $CURRENT_ENV_FILE)) sh" < "$scripts_path/configure_devtools.sh"

  # Prepare workspace
  ssh -t $DEV_MACHINE_USER@$DEV_MACHINE_HOST "$(echo $(< $CURRENT_ENV_FILE)) sh" < "$scripts_path/prepare_workspace.sh"

  echo "[Workspace: $workspace] Done"
done
