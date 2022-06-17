#!/bin/bash

echo '[SSH] Copy identity...'

if hash sshpass 2>/dev/null; then
  sshpass -p $DEV_MACHINE_PASSWORD ssh-copy-id -i $DEV_MACHINE_IDENTITY_PATH $DEV_MACHINE_USER@$DEV_MACHINE_HOST
else
  ssh-copy-id -i $DEV_MACHINE_IDENTITY_PATH $DEV_MACHINE_USER@$DEV_MACHINE_HOST
fi

echo '[SSH] Done'
