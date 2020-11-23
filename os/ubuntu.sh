#!/bin/bash

echo '[OS] Installing packages for Ubuntu...'

# 1. Self-update
echo '[OS] #1 Self-update'
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
apt update && apt upgrade \
  -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold" \
  -yq

# 2. Install necessary tools
echo '[OS] #2 Necessary tools'

# For Docker
echo '[OS] #2 Installing... requirements for Docker Engine'
apt install \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg-agent \
  software-properties-common \
  -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
apt-key fingerprint 0EBFCD88 -y

# Docker Engine
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable" \
   -y

echo '[OS] #2 Installing... Docker Engine'
apt update && apt install \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  -y

echo '[OS] #2 Installing... Docker Compose'
# Docker Compose
curl \
  -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose
curl \
  -L "https://raw.githubusercontent.com/docker/compose/1.25.5/contrib/completion/bash/docker-compose" \
  -o /etc/bash_completion.d/docker-compose

echo '[OS] #2 Post-installation steps for Docker'
groupadd docker
systemctl enable docker

# 3. Create user
echo '[OS] #3 Creating... user'
useradd \
  --create-home \
  --groups docker,sudo \
  --password $(openssl passwd -1 $DEV_MACHINE_PASSWORD) \
  --shell /bin/bash \
  --user-group \
  $DEV_MACHINE_USER

# 4. Other instruments
echo '[OS] #4 Installing... git vim'
su - $DEV_MACHINE_USER && \
  apt install \
    git \
    vim \
    -y

echo '[OS] Done'
