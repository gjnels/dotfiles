#!/bin/bash

#-- Dotfiles Installation Script



#---------------------------------------
#-- Source Environment Variables

SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)
source "$SCRIPT_DIR/zsh/zshenv"



#---------------------------------------
#-- Neovim

# create directories if they don't exist
mkdir -p "$XDG_CONFIG_HOME/nvim"
mkdir -p "$XDG_CONFIG_HOME/nvim/undo"

# link Neovim config
ln -sf "$DOTFILES/nvim/init.vim" "$XDG_CONFIG_HOME/nvim"



#---------------------------------------
#-- X11

# remove directory before creating link
rm -rf "$XDG_CONFIG_HOME/X11"

# link entire X11 directory
ln -s "$DOTFILES/X11" "$XDG_CONFIG_HOME"



#---------------------------------------
#-- i3

# remove directory before creating link
rm -rf "$XDG_CONFIG_HOME/i3"

# link entire i3 directory
ln -s "$DOTFILES/i3" "$XDG_CONFIG_HOME"



#---------------------------------------
#-- Zsh

# create directory if it doesn't exist
mkdir -p "$XDG_CONFIG_HOME/zsh"

# link zsh files
# .zshenv
ln -sf "$DOTFILES/zsh/zshenv" "$HOME/.zshenv"
# .zshrc
ln -sf "$DOTFILES/zsh/zshrc" "$XDG_CONFIG_HOME/zsh/.zshrc"



#---------------------------------------
#-- Dunst Notifications

mkdir -p "$XDG_CONFIG_HOME/dunst"
ln -sf "$DOTFILES/dunst/dunstrc" "$XDG_CONFIG_HOME/dunst/dunstrc"



#---------------------------------------
#-- Rofi

# link config file
mkdir -p "$XDG_CONFIG_HOME/rofi"
ln -sf "$DOTFILES/rofi/config.rasi" "$XDG_CONFIG_HOME/rofi/config.rasi"

# link themes
mkdir -p "$XDG_DATA_HOME/rofi"
rm -rf "$XDG_DATA_HOME/rofi/themes"
ln -s "$DOTFILES/rofi/themes" "$XDG_DATA_HOME/rofi"
