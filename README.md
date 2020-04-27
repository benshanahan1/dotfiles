# dotfiles

My Ubuntu installation script and dotfiles.

**Important:** this repo thinks that it lives at `/home/$(USER)/dotfiles`, so please clone it there:

```bash
cd "/home/$USER"
git clone git@gitlab.com:bshanahan/dotfiles.git
```

## software

The `install-software-ubuntu-18.04.sh` bash file installs software for a minimal Ubuntu 18.04 installation. This should be run with `sudo`. Please note that this is not required for the dotfiles:

```bash
sudo bash install-software-ubuntu-18.04.sh
```

## dotfiles

Dotfiles should be installed as the user that will be using the dotfiles, do not use `sudo`.

First, install requirements:

```bash
make install-requirements
```

Then, install (or remove) the dotfiles:

```bash
make install  # install dotfiles
make remove   # uninstall dotfiles
```

### further customization

#### bashrc

The bashrc will source a local bashrc file (at `~/.bashrc.local`) if it exists. This allows you to write per-computer bashrc customizations that aren't version controlled in the repository (and therefore aren't synced between machines).
