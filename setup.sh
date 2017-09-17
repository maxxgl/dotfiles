#!/bin/bash

rm -rf .vim
cp -r dots/vim .vim
git clone https://github.com/VundleVim/Vundle.vim.git .vim/bundle/Vundle.vim

rm .vimrc
ln -s dots/vimrc .vimrc

rm .bashrc
ln -s dots/aliases.sh .bashrc


# Font stuff
if [[ `uname` == 'Darwin' ]]; then
  font_dir="$HOME/Library/Fonts"
else
  font_dir="$HOME/.local/share/fonts"
  mkdir -p $font_dir
fi

echo "Installing Patched Inconsolata"
cp dots/fonts/inconsolata-powerline.otf "$font_dir/"

echo "Resetting font cache, this may take a moment..."
fc-cache -f $font_dir
"Powerline Inconsolata installed to $font_dir"


vim +PluginInstall +qall

