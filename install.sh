#!/bin/bash

#-- Dotfiles Installation Script



#-------------------------------------------------------------------------------
#-- Source Environment Variables

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/zsh/zshenv"



#-------------------------------------------------------------------------------
#-- Workspace Directory

mkdir -p "$WORKSPACE"



#-------------------------------------------------------------------------------
#-- Neovim

rm -rf "$XDG_CONFIG_HOME/nvim"
mkdir -p "$XDG_DATA_HOME/nvim/undo"
ln -s "$DOTFILES/nvim" "$XDG_CONFIG_HOME"



#-------------------------------------------------------------------------------
#-- Zsh

mkdir -p "$XDG_CONFIG_HOME/zsh"
ln -sf "$DOTFILES/zsh/zshenv" "$HOME/.zshenv"
ln -sf "$DOTFILES/zsh/zshrc" "$XDG_CONFIG_HOME/zsh/.zshrc"



#-------------------------------------------------------------------------------
#-- Git

rm -rf "$XDG_CONFIG_HOME/git"
ln -s "$DOTFILES/git" "$XDG_CONFIG_HOME"



#-------------------------------------------------------------------------------
#-- Tmux

mkdir -p "$XDG_CONFIG_HOME/tmux"
ln -sf "$DOTFILES/tmux/tmux.conf" "$XDG_CONFIG_HOME/tmux/tmux.conf"

# install tmux plugin manager if not already installed
[ ! -d "$XDG_CONFIG_HOME/tmux/plugins/tpm" ] \
    && git clone https://github.com/tmux-plugins/tpm \
    "$XDG_CONFIG_HOME/tmux/plugins/tpm"



#-------------------------------------------------------------------------------
#-- Tmuxp

rm -rf "$XDG_CONFIG_HOME/tmuxp"
ln -s "$DOTFILES/tmuxp" "$XDG_CONFIG_HOME"



#-------------------------------------------------------------------------------
#-- Starship Prompt

rm -rf "$XDG_CONFIG_HOME/starship"
ln -s "$DOTFILES/starship" "$XDG_CONFIG_HOME"



#-------------------------------------------------------------------------------
#-- Kitty

rm -rf "$XDG_CONFIG_HOME/kitty"
ln -s "$DOTFILES/kitty" "$XDG_CONFIG_HOME"



#-------------------------------------------------------------------------------
#-- Linux Environment Variables

if [[ $(uname) == "Linux" ]]; then
    #-- X11
    rm -rf "$XDG_CONFIG_HOME/X11"
    ln -s "$DOTFILES/X11" "$XDG_CONFIG_HOME"

    #-- i3
    rm -rf "$XDG_CONFIG_HOME/i3"
    ln -s "$DOTFILES/i3" "$XDG_CONFIG_HOME"

    #-- Dunst Notifications
    mkdir -p "$XDG_CONFIG_HOME/dunst"
    ln -sf "$DOTFILES/dunst/dunstrc" "$XDG_CONFIG_HOME/dunst/dunstrc"

    #-- Rofi
    mkdir -p "$XDG_CONFIG_HOME/rofi"
    ln -sf "$DOTFILES/rofi/config.rasi" "$XDG_CONFIG_HOME/rofi/config.rasi"
    # themes
    mkdir -p "$XDG_DATA_HOME/rofi"
    rm -rf "$XDG_DATA_HOME/rofi/themes"
    ln -s "$DOTFILES/rofi/themes" "$XDG_DATA_HOME/rofi"
fi
