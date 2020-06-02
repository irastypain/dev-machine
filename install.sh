#!/bin/bash

# Export ENV variables
dotenv () {
  set -a
  source $1
  set +a
}

echo 'Loading... ENV variables'
ENV_FILE=.env

if [ -f $ENV_FILE ]; then
  dotenv $ENV_FILE
else
  echo "Error: File $ENV_FILE must exist!" >&2
  exit 1
fi

# Prepare OS
ssh -t $DEV_MACHINE_HOST "$(echo $(< $ENV_FILE)) sh" < ./os/ubuntu.sh

# Prepare SSH
sh ./ssh/copy_id.sh
