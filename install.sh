#!/bin/bash


## nvim ##

# create directories if they don't exist
mkdir -p "$HOME/.config/nvim"
mkdir -p "$HOME/.config/nvim/undo"

# link nvim config
ln -sf "$HOME/dotfiles/nvim/init.vim" "$HOME/.config/nvim"


## X11 ##

# remove directory before creating link
rm -rf "$HOME/.config/X11"

# link entire X11 directory
ln -s "$HOME/dotfiles/X11" "$HOME/.config"
