#!/bin/bash

rm -rf .vim
cp -r dots/vim .vim
git clone https://github.com/VundleVim/Vundle.vim.git .vim/bundle/Vundle.vim

rm .vimrc
ln -s dots/vimrc .vimrc

rm .bashrc
ln -s dots/aliases.sh .bashrc

vim +PluginInstall +qall

