#!/bin/bash

rm ../.vimrc
ln -s vimrc ../.vimrc

rm -rf ../.vim
ln -s vim ../.vim

rm ../.bashrc
ln -s aliases.sh ../.bashrc
