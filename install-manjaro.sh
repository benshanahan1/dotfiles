# Ubuntu Installation Script
#
# Run as sudo:
#
#     $ sudo bash install
#
# Benjamin Shanahan

ORIGIN_DIR=$(pwd)
SRC_DIR=~/code  # where git repos are cloned
cd ~

# Update packages
sudo pacman -Syu

# Build / install yay aur helper
sudo pacman -S --needed git base-devel
mkdir -p "$SRC_DIR"
cd "$SRC_DIR"
git clone https://aur.archlinux.org/yay.git
cd "$SRC_DIR/yay"
makepkg -si
cd ~

# Build / install packages
yay -S \
    gitflow-avh \
    chromium \
    htop \
    the_silver_searcher \
    mosh \
    jq \
    tmux \
    tree \
    ncdu \ # ncurses disk usage
    ttf-fira-code \
    ttf-inconsolata \
    tlp \
    tlp-rdw \
    neovim \
    code \
    neofetch \
    ufw

# Git clone warpdrive (jump to directories, https://github.com/JoeriHermans/warpdrive)
cd ~
git clone https://github.com/JoeriHermans/warpdrive.git

# Setup neovim configuration
# NOTE: when you first open vim, you need to run these commands:
#  :source ~/.vimrc
#  :PlugInstall
# The wakatime package will then ask for an API key to do time-tracking.
# You can disable this package by removing it from ~/.vimrc.
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir -p ~/.config ~/.config/nvim

# Rename folders in user home directory to lowercase versions
mv ~/Desktop   ~/desktop
mv ~/Downloads ~/downloads
mv ~/Templates ~/templates
mv ~/Public    ~/public
mv ~/Documents ~/documents
mv ~/Music     ~/music
mv ~/Pictures  ~/pictures
mv ~/Videos    ~/videos

# Update folder names in XDG settings
USER_DIRS=~/.config/user-dirs.dirs
echo 'XDG_DESKTOP_DIR="$HOME/desktop"'     >  $USER_DIRS
echo 'XDG_DOWNLOAD_DIR="$HOME/downloads"'  >> $USER_DIRS
echo 'XDG_TEMPLATES_DIR="$HOME/templates"' >> $USER_DIRS
echo 'XDG_PUBLICSHARE_DIR="$HOME/public"'  >> $USER_DIRS
echo 'XDG_DOCUMENTS_DIR="$HOME/documents"' >> $USER_DIRS
echo 'XDG_MUSIC_DIR="$HOME/music"'         >> $USER_DIRS
echo 'XDG_PICTURES_DIR="$HOME/pictures"'   >> $USER_DIRS
echo 'XDG_VIDEOS_DIR="$HOME/videos"'       >> $USER_DIRS

# Setup software firewall; initial setup only allows incoming SSH.
# More info:
# https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-ubuntu-18-04
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw enable

# Finish up
cd $ORIGIN_DIR
echo "========================================================"
echo "Finished installation script. Please reboot your system."
echo "========================================================"

exit 0
