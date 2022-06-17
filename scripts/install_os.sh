#!/bin/bash

INITIAL_DIR=$(pwd)
cd "$(dirname $0)"

source '../lib/utils'

workspace=$1

# Export ENV variables
dotenv "../.env.$workspace"

scripts_path="./os/$DEV_MACHINE_OS"

# Prepare OS
ssh -t $DEV_MACHINE_HOST "$(echo $(< $CURRENT_ENV_FILE)) sh" < "$scripts_path/prepare_system.sh"

cd $INITIAL_DIR
