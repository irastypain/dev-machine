echo '[Configs] #1 Prepare temporary directory...'

cd ~

mkdir -p configs
cd configs

echo '[Configs] #2 Pull dotfiles...'
git clone https://github.com/irastypain/dotfiles.git
cd dotfiles

echo '[Configs] #2.1 Configure vim...'
make vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -E -s -u "$HOME/.vimrc" -c "PlugInstall" -c "qa"

echo '[Configs] Done'
