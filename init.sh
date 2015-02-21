#!/bin/bash

# Symlink the files/folders to appropriate locations 
ln -s ~/dotfiles/vim ~/.vim           
ln -s ~/dotfiles/vim/vimrc ~/.vimrc
ln -s ~/dotfiles/fish/config.fish ~/.config/fish/config.fish
ln -s ~/dotfiles/git/gitconfig ~/.gitconfig
ln -s ~/dotfiles/zsh/zshrc ~/.zshrc
ln -s ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/tmux/tmux ~/.tmux

git submodule init && git submodule update
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +BundleInstall +qall
open ~/dotfiles/vim/Monaco_Linux-Powerline.ttf
