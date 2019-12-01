# dotfiles
My dotfiles.

**NOTE:** install as the user that will be using the dotfiles, do not use `sudo`.

## Requirements
* neovim
* tmux

Requirements can be installed with an the included target:
```bash
make install-requirements
```

## Usage
```bash
make install  # install dotfiles
make remove   # uninstall dotfiles
```

## Customization
### bashrc
The bashrc will source a local bashrc file (at '~/.bashrc.local') if it exists. This allows you to write per-computer bashrc customizations that aren't version controlled in the repository (and therefore aren't synced between machines).
