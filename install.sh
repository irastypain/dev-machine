#!/bin/bash

# Export ENV variables
ENV_FILE=.env source ./load_env.sh

# Prepare OS
ssh -t $DEV_MACHINE_HOST "$(echo $(< $ENV_FILE)) sh" < ./os/ubuntu.sh

# Prepare SSH
sh ./ssh/copy_id.sh

# Configure devtools
ssh -t $DEV_MACHINE_USER@$DEV_MACHINE_HOST "$(echo $(< $ENV_FILE)) sh" < ./configs/devtools.sh
