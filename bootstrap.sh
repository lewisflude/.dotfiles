#!/bin/sh
files="vimrc zshrc tmux.conf"

echo "Installing zsh and tmux"
brew install zsh tmux

echo "Adding symlinks for dotfiles"

for file in $files; do
    echo "Symlinking $file"
    ln -s -f $file ~/.$file
done

echo "Symlinking alacritty.yml"
ln -s -f alacritty.yml ~/.config/alacritty/alacritty.yml