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

install: i-neovim i-tmux i-bashrc

remove: r-neovim r-tmux r-bashrc

install-requirements:
	sudo apt -y install tmux
	sudo apt -y install neovim

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
