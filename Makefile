# Installation makefile for dotfiles.
#
# Usage:
# 	make install
# 	make uninstall
# 	make install-requirements
#
SHELL=/bin/bash
HOME=/home/$(USER)
REPO=$(HOME)/dotfiles

all: help

help:
	@echo "Available targets:"
	@echo " - install: install dotfiles"
	@echo " - remove: remove dotfiles"
	@echo " - help: show this help"

###############################################################################
## installation targets
###############################################################################

install: i-neovim i-tmux i-bashrc i-sublime

remove: r-neovim r-tmux r-bashrc r-sublime

install-requirements:
	sudo apt -y install tmux
	sudo apt -y install neovim
	sudo snap -y install sublime-text --classic

###############################################################################
## dotfiles
###############################################################################

# neovim
i-neovim:
	@echo "=== INSTALL neovim dotfiles ==="
	mkdir -p "$(HOME)/.config/nvim"
	ln -sfv "$(REPO)/nvim/init.vim" "$(HOME)/.config/nvim/init.vim"
	ln -sfv "$(REPO)/nvim/init.vim" "$(HOME)/.vimrc"

r-neovim:
	@echo "=== REMOVE neovim dotfiles ==="
	rm "$(HOME)/.config/nvim/init.vim"
	rm "$(HOME)/.vimrc"

# tmux
i-tmux:
	@echo "=== INSTALL tmux dotfiles ==="
	ln -sfv "$(REPO)/tmux/.tmux.conf" "$(HOME)/.tmux.conf"
	ln -sfv "$(REPO)/tmux/.tmux.conf.local" "$(HOME)/.tmux.conf.local"

r-tmux:
	@echo "=== REMOVE tmux dotfiles ==="
	rm "$(HOME)/.tmux.conf"
	rm "$(HOME)/.tmux.conf.local"

# bashrc
i-bashrc:
	@echo "=== INSTALL bashrc dotfiles ==="
	ln -sfv "$(REPO)/bashrc/.bashrc" "$(HOME)/.bashrc"

r-bashrc:
	@echo "=== REMOVE bashrc dotfiles ==="
	rm "$(HOME)/.bashrc"

# flake8
i-flake8:
	@echo "=== INSTALL flake8 dotfiles ==="
	ln -sfv "$(REPO)/flake8/flake8" "$(HOME)/.config/flake8"

r-flake8:
	@echo "=== REMOVE flake8 dotfiles ==="
	rm "$(HOME)/.config/flake8"

# sublime text 3
i-sublime:
	@echo "=== INSTALL sublime text 3 dotfiles ==="
	ln -sfv "$(REPO)/sublime/Preferences.sublime-settings" "$(HOME)/.config/sublime-text-3/Packages/User/Preferences.sublime-settings"

r-sublime:
	@echo "=== REMOVE sublime text 3 dotfiles ==="
	rm "$(HOME)/.config/sublime-text-3/Packages/User/Preferences.sublime-settings"
