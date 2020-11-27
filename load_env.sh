#!/bin/bash

# Export ENV variables
dotenv () {
  set -a
  source $1
  set +a
}

echo "Loading... ENV variables from ${ENV_FILE}"
if [ -f $ENV_FILE ]; then
  dotenv $ENV_FILE
else
  echo "Error: File $ENV_FILE must exist!" >&2
  exit 1
fi
