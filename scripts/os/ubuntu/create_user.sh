#!/bin/bash

# Create user
echo "[Workspace] #1 Creating... User: $DEV_MACHINE_USER"
useradd \
  --create-home \
  --groups docker,sudo \
  --password $(openssl passwd -1 $DEV_MACHINE_PASSWORD) \
  --shell /bin/bash \
  --user-group \
  $DEV_MACHINE_USER
