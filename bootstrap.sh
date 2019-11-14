#!/bin/zsh
dir=$(pwd -P)
dotfiles=(alacritty zsh tmux vim)

print -P "%SRunning bootstrap script%s\n"

if (( $+commands[brew] )); then
    print -P "%F{yellow}Brew already installed%f\n"
else
    print -P "%F{green}Installing brew%f\n"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

print -P "%SInstalling packages from brew%s\n"

brew bundle 

print -P "\n"

if [ -d ~/.zplugin/bin ]; then
    print -P "%F{yellow}Zplugin already installed%f\n"
else
    print -P "%F{green}Installing zplugin%f\n"
    mkdir ~/.zplugin
    git clone https://github.com/zdharma/zplugin.git ~/.zplugin/bin
fi

if cat ~/.vim/autoload/plug.vim &> /dev/null; then
    print -P "%F{yellow}Vim-plug already installed%f\n"
else
    print -P "%F{green}Installing vim-plug%f\n"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi


if (( $+commands[node] )); then
    print -P "%F{yellow}Installing node%f\n"
else
    print -P "%F{green}Installing node%f\n"
    . ~/.nvm/nvm.sh
    nvm install node
fi

print -P "%SAdding symlinks for dotfiles%s\n"


for file in $dotfiles; do
    print -P "%F{green}Symlinking $file%f"
    stow -t ~/ $file
done

print -P "%F{green}Symlinking alacritty%f"
ln -sf $dir/alacritty.yml ~/.config/alacritty/alacritty.yml