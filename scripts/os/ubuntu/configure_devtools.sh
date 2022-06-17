#!/bin/bash

echo '[Configs] #1 Prepare temporary directory...'
cd ~
mkdir -p temporary_configs
cd temporary_configs

echo '[Configs] #2 Pull dotfiles...'
git clone https://github.com/irastypain/dotfiles.git
cd dotfiles

echo '[Configs] #2.1 Configure vim...'
yes | make vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -E -s -u "$HOME/.vimrc" -c "PlugInstall" -c "qa"

echo '[Configs] # 2.2 Configure git...'
yes | make git

echo '[Configs] #3 Remove temporary directory...'
cd ~
rm -rf temporary_configs

echo '[Configs] Done'
