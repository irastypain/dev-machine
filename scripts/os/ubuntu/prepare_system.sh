#!/bin/bash

echo '[OS][Prepare system] #1 Self-update'
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
apt update && apt upgrade \
  -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold" \
  -yq

echo '[OS][Prepare system] #2 Installing... requirements for Docker Engine'
apt install \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg-agent \
  software-properties-common \
  -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
apt-key fingerprint 0EBFCD88 -y

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable" \
   -y

echo '[OS][Prepare system] #2 Installing... Docker Engine'
apt update && apt install \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  -y

echo '[OS][Prepare system] #2 Installing... Docker Compose'
curl \
  -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose
curl \
  -L "https://raw.githubusercontent.com/docker/compose/1.25.5/contrib/completion/bash/docker-compose" \
  -o /etc/bash_completion.d/docker-compose

echo '[OS][Prepare system] #2 Post-installation steps for Docker'
groupadd docker
systemctl enable docker

echo '[OS][Prepare system] #3 Installing... ag gh git vim'
apt install \
  git \
  silversearcher-ag \
  vim \
  -y

curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null
apt update && apt install gh -y

echo '[OS][Prepare system] Done'
