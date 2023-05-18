#!/bin/bash

#-- Dotfiles Installation Script



#---------------------------------------
#-- Neovim

# create directories if they don't exist
mkdir -p "$HOME/.config/nvim"
mkdir -p "$HOME/.config/nvim/undo"

# link Neovim config
ln -sf "$HOME/dotfiles/nvim/init.vim" "$HOME/.config/nvim"



#---------------------------------------
#-- X11

# remove directory before creating link
rm -rf "$HOME/.config/X11"

# link entire X11 directory
ln -s "$HOME/dotfiles/X11" "$HOME/.config"



#---------------------------------------
#-- i3

# remove directory before creating link
rm -rf "$HOME/.config/i3"

# link entire i3 directory
ln -s "$HOME/dotfiles/i3" "$HOME/.config"



#---------------------------------------
#-- Zsh

# create directory if it doesn't exist
mkdir -p "$HOME/.config/zsh"

# link zsh files
# .zshenv
ln -sf "$HOME/dotfiles/zsh/zshenv" "$HOME/.zshenv"
# .zshrc
ln -sf "$HOME/dotfiles/zsh/zshrc" "$HOME/.config/zsh/.zshrc"

