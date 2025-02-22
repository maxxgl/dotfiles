#!/bin/bash

# Font stuff
# if [[ $(uname) == 'Darwin' ]]; then
# 	font_dir="$HOME/Library/Fonts"
# else
# 	font_dir="$HOME/.local/share/fonts"
# 	mkdir -p $font_dir
# fi
#
# echo "Installing Patched Inconsolata"
# cp dots/fonts/inconsolata-powerline.otf "$font_dir/"
#
# echo "Resetting font cache, this may take a moment..."
# fc-cache -f $font_dir
# "Powerline Inconsolata installed to $font_dir"

mv ~/.bashrc ~/.old-bashrc
mv ~/.zshrc ~/.old-zshrc
mv ~/.gitconfig ~/.gitconfig-old
mv ~/.alacritty.toml ~/.alacritty.toml-old
mv ~/.tmux ~/.tmux-old
mv ~/.tmux.conf ~/.tmux.conf-old

ln -s ~/dotfiles/.bashrc ~/.bashrc
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.alacritty.toml ~/.alacritty.toml
ln -s ~/dotfiles/.tmux ~/.tmux
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf

mkdir ~/.config
mv ~/.config/nvim ~/.config/old-nvim
ln -s ~/dotfiles/lazygit ~/.config/lazygit
ln -s ~/dotfiles/nvim ~/.config/nvim
