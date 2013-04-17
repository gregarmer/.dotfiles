#!/bin/bash -x

FILES=".gitconfig .zlogin .zprofile .zshenv .zshrc"
FILES="$FILES .zprezto .zpreztorc .tmux.conf"

cd ~

for f in $FILES; do
  if [ ! -L $f ]; then
    ln -s .dotfiles/$f
  fi
done
