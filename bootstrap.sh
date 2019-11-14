#!/bin/zsh
dir=$(pwd -P)
dotfiles=(alacritty zsh tmux vim)

echo -e "\e[3mRunning bootstrap script\e[0m\n"

which -s brew
if [[ $? != 0 ]] ; then
    echo "Installing brew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if (( $+commands[brew] )); then
    echo "Brew already installed"
else
    echo "Installing brew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo -e "\n\e[3mInstalling packages from brew\e[0m\n"
brew bundle 
echo -e "\n"


if [ -d ~/.zplugin/bin ]; then
    echo "Zplugin already installed" 
else
    echo "Installing zplugin"
    mkdir ~/.zplugin
    git clone https://github.com/zdharma/zplugin.git ~/.zplugin/bin
fi

if cat ~/.vim/autoload/plug.vim &> /dev/null; then
    echo "Vim-plug already installed"
else
    echo "Installing vim-plug"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi


if (( $+commands[node] )); then
    echo "Node already installed"
else
    echo "Installing node"
    . ~/.nvm/nvm.sh
    nvm install node
fi

echo -e "\n\e[3mAdding symlinks for dotfiles\e[0m\n"

for file in $dotfiles; do
    echo "Symlinking $file"
    stow -t ~/ $file
done

echo "Symlinking alacritty.yml"
ln -sf $dir/alacritty.yml ~/.config/alacritty/alacritty.yml