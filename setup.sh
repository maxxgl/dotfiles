#!/bin/bash

rm .vimrc
ln -s dots/vimrc .vimrc

rm -rf .vim
cp -r dots/vim .vim

rm .bashrc
ln -s dots/aliases.sh .bashrc
