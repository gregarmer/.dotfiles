#!/bin/bash -x

FILES=".gitconfig .zlogin .zprofile .zshenv .zshrc .vimrc"
FILES="$FILES .zprezto .zpreztorc .tmux.conf .muttrc"

cd ~

for f in $FILES; do
  if [ ! -L $f ]; then
    ln -s .dotfiles/$f
  fi
done
