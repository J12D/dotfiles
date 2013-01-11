#!/bin/bash

# Symlink the files/folders to appropriate locations 
ln -s ~/dotfiles/vim ~/.vim           
ln -s ~/dotfiles/vim/vimrc ~/.vimrc
ln -s ~/dotfiles/fish/config.fish ~/.config/fish/config.fish
ln -s ~/dotfiles/git/gitconfig ~/.gitconfig
ln -s ~/dotfiles/zsh/zshrc ~/.zshrc

git submodule init && git submodule update
