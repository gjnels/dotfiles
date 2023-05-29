#!/bin/bash

#-- Dotfiles Installation Script

# show status of each configuration
status() {
	echo "> $1"
	echo "Configuration linked to: $2"
	echo ""
}

echo ""
echo "Installing dotfiles..."
echo ""

#-------------------------------------------------------------------------------
#-- Source Environment Variables

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/zsh/zshenv"

#-------------------------------------------------------------------------------
#-- Workspace Directory

mkdir -p "$WORKSPACE"
echo "Workspace directory: $WORKSPACE"
echo ""

#-------------------------------------------------------------------------------
#-- Neovim

rm -rf "$XDG_CONFIG_HOME/nvim"
ln -s "$DOTFILES/nvim" "$XDG_CONFIG_HOME"
status "Neovim" "$XDG_CONFIG_HOME/nvim"

#-------------------------------------------------------------------------------
#-- Zsh

ZSH_DIR="$XDG_CONFIG_HOME/zsh"
mkdir -p "$ZSH_DIR"
ln -sf "$DOTFILES/zsh/zshenv" "$HOME/.zshenv"

ln -sf "$DOTFILES/zsh/zshrc" "$XDG_CONFIG_HOME/zsh/.zshrc"
status "Zsh" "$ZSH_DIR"

#-------------------------------------------------------------------------------
#-- Git

GIT_DIR="$XDG_CONFIG_HOME/git"
rm -rf "$GIT_DIR"
ln -s "$DOTFILES/git" "$XDG_CONFIG_HOME"

status "Git" "$GIT_DIR"

#-------------------------------------------------------------------------------
#-- Tmux

TMUX_DIR="$XDG_CONFIG_HOME/tmux"
mkdir -p "$TMUX_DIR"
ln -sf "$DOTFILES/tmux/tmux.conf" "$XDG_CONFIG_HOME/tmux/tmux.conf"

# install tmux plugin manager if not already installed
[ ! -d "$XDG_CONFIG_HOME/tmux/plugins/tpm" ] &&
	git clone https://github.com/tmux-plugins/tpm \
		"$XDG_CONFIG_HOME/tmux/plugins/tpm"

status "Tmux" "$TMUX_DIR"

#-------------------------------------------------------------------------------
#-- Tmuxp

TMUXP_DIR="$XDG_CONFIG_HOME/tmuxp"
rm -rf "$TMUXP_DIR"
ln -s "$DOTFILES/tmuxp" "$XDG_CONFIG_HOME"

status "Tmuxp" "$TMUXP_DIR"

#-------------------------------------------------------------------------------
#-- Starship Prompt

STARSHIP_DIR="$XDG_CONFIG_HOME/starship"
rm -rf "$STARSHIP_DIR"
ln -s "$DOTFILES/starship" "$XDG_CONFIG_HOME"

status "Starship Prompt" "$STARSHIP_DIR"

#-------------------------------------------------------------------------------
#-- Kitty

KITTY_DIR="$XDG_CONFIG_HOME/kitty"
rm -rf "$KITTY_DIR"
ln -s "$DOTFILES/kitty" "$XDG_CONFIG_HOME"

status "Kitty Terminal" "$KITTY_DIR"

#-------------------------------------------------------------------------------
#-- Linux Environment Variables

if [[ $(uname) == "Linux" ]]; then
	#-- X11
	X11_DIR="$XDG_CONFIG_HOME/X11"
	rm -rf "$X11_DIR"
	ln -s "$DOTFILES/X11" "$XDG_CONFIG_HOME"
	status "X11" "$X11_DIR"

	#-- i3
	I3_DIR="$XDG_CONFIG_HOME/i3"
	rm -rf "$I3_DIR"
	ln -s "$DOTFILES/i3" "$XDG_CONFIG_HOME"
	status "i3 Window Manager" "$I3_DIR"

	#-- Dunst Notifications
	DUNST_DIR="$XDG_CONFIG_HOME/dunst"
	mkdir -p "$DUNST_DIR"
	ln -sf "$DOTFILES/dunst/dunstrc" "$XDG_CONFIG_HOME/dunst/dunstrc"
	status "Dunst Notifications" "$DUNST_DIR"

	#-- Rofi
	ROFI_DIR="$XDG_CONFIG_HOME/rofi"
	mkdir -p "$ROFI_DIR"
	ln -sf "$DOTFILES/rofi/config.rasi" "$XDG_CONFIG_HOME/rofi/config.rasi"
	# themes
	mkdir -p "$XDG_DATA_HOME/rofi"
	rm -rf "$XDG_DATA_HOME/rofi/themes"
	ln -s "$DOTFILES/rofi/themes" "$XDG_DATA_HOME/rofi"
	status "Rofi Application Launcher" "$ROFI_DIR"
fi
