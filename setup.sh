#!/bin/bash

rm -rf .vim
cp -r dots/vim .vim

rm .vimrc
ln -s dots/vimrc .vimrc

rm .bashrc
ln -s dots/aliases.sh .bashrc
