#!/bin/bash

ROOT=$(cd "$(dirname "$0")" && pwd)

function green { printf "\033[32m$1\033[0m\n"; }
function yellow { printf "\033[33m$1\033[0m\n"; }
function red { printf "\033[31m$1\033[0m\n"; }

function install {
  local from="$1" to="$2" from_="$ROOT/$1" to_="$HOME/$2"

  if [ ! -e "$from_" ]; then
  red "ERROR: $from doesn't exist! This is an error in $0"
  return 1
  fi

  if [ ! -e "$to_" ] ; then
    if [ -L "$to_" ]; then
      red "~/$to exists but doesn't point to a valid file, removing ..."
      unlink $to_
    fi
    yellow "Linking ~/$to => $from"

    if [ -d "$from_" ]; then
      ln -s "$from_/" "$to_"
    else
      ln -s "$from_" "$to_"
    fi
  else
    local link=$(readlink "$to_")
    if [ "$?" == 0 -a \( "$link" == "$from_" -o "$link" == "$from_/" \) ]; then
      green "Link ~/$to => $from already exists!"
    else
      red "Error linking ~/$to to $from: $to already exists!"
    fi
  fi
}

function install_dot {
  install "$1" ".$1"
}


cd "$ROOT"
git submodule init
git submodule update


# Symlink files/folders to appropriate locations 
install vim                                .vim
install vim/vimrc                          .vimrc
install vim/gvimrc                         .gvimrc
install fish/config.fish                   .config/fish/config.fish
install fish/iterm2_shell_integration.fish .config/fish/iterm2_shell_integration.fish
install git/gitconfig                      .gitconfig
install zsh/zshrc                          .zshrc
install tmux/tmux.conf                     .tmux.conf
install tmux/tmux                          .tmux

if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
  git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
else
  green "Vundle already initialized"
fi
green "Updating vim bundles"
vim +BundleInstall +qall
#open ~/dotfiles/vim/Monaco_Linux-Powerline.ttf
green "Don't forget to install the fonts in $ROOT/font"
