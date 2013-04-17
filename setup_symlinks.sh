#!/bin/bash -x

FILES=".gitconfig .zlogin .zprofile .zshenv .zshrc"
FILES="$FILES .zprezto .zpreztorc"

cd ~

for f in $FILES; do
  ln -s .dotfiles/$f
done
