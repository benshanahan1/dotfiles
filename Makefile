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

install: i-neovim i-tmux i-bashrc i-flake8

remove: r-neovim r-tmux r-bashrc i-flake8

install-requirements:
	sudo apt -y install tmux
	sudo apt -y install neovim
	sudo snap install sublime-text --classic
	subl --command install_package_control
	sudo apt -y install fonts-firacode
	sudo fc-cache -fv

###############################################################################
## dotfiles
###############################################################################

# neovim
i-neovim:
	@echo "=== INSTALL neovim dotfiles ==="
	mkdir -p "$(HOME)/.config/nvim"
	ln -sf "$(REPO)/nvim/init.vim" "$(HOME)/.config/nvim/init.vim"
	ln -sf "$(REPO)/nvim/init.vim" "$(HOME)/.vimrc"

r-neovim:
	@echo "=== REMOVE neovim dotfiles ==="
	rm "$(HOME)/.config/nvim/init.vim"
	rm "$(HOME)/.vimrc"

# tmux
i-tmux:
	@echo "=== INSTALL tmux dotfiles ==="
	ln -sf "$(REPO)/tmux/.tmux.conf" "$(HOME)/.tmux.conf"
	ln -sf "$(REPO)/tmux/.tmux.conf.local" "$(HOME)/.tmux.conf.local"

r-tmux:
	@echo "=== REMOVE tmux dotfiles ==="
	rm "$(HOME)/.tmux.conf"
	rm "$(HOME)/.tmux.conf.local"

# bashrc
i-bashrc:
	@echo "=== INSTALL bashrc dotfiles ==="
	ln -sf "$(REPO)/bashrc/.bashrc" "$(HOME)/.bashrc"

r-bashrc:
	@echo "=== REMOVE bashrc dotfiles ==="
	rm "$(HOME)/.bashrc"

# flake8
i-flake8:
	@echo "=== INSTALL flake8 dotfiles ==="
	ln -sf "$(REPO)/flake8/flake8" "$(HOME)/.config/flake8"

r-flake8:
	@echo "=== REMOVE flake8 dotfiles ==="
	rm "$(HOME)/.config/flake8"
