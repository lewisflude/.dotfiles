#!/bin/zsh
dir=$(pwd -P)
dotfiles=(vimrc zshrc tmux.conf)

echo -e "\e[3mRunning bootstrap script\e[0m\n"

which -s brew
if [[ $? != 0 ]] ; then
    echo "Installing brew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo "Updating brew"
    brew update
fi

echo -e "\n\e[3mInstalling packages from brew\e[0m\n"
brew bundle 

echo "Installing zplugin"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"

echo "Installing vim-plug"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo -e "\n\e[3mAdding symlinks for dotfiles\e[0m\n"

for file in $dotfiles; do
    echo "Symlinking $file"
    ln -sf $dir/.$file ~/.$file
done

echo "Symlinking alacritty.yml"
ln -sf $dir/alacritty.yml ~/.config/alacritty/alacritty.yml