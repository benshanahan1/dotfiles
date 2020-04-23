# Ubuntu Installation Script
#
# Run as sudo:
#
#     $ sudo bash install
#
# Benjamin Shanahan

ORIGIN_DIR=$(pwd)
cd ~

# Update apt and install packages
sudo apt -y update
sudo apt install -y \
    openssh-server \
    software-properties-common \
    chromium-browser \
    ctags \
    curl \
    git \
    gnome-tweaks \
    gparted \
    htop \
    intel-microcode \
    jq \
    mosh \
    net-tools \
    python-dev \
    silversearcher-ag \
    speedtest-cli \
    tmux \
    tree \
    ufw \
    virtualenv \
    wget \
    wmctrl \
    xclip

# Install Node.js and NPM
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt -y install nodejs

# Install video drivers, if applicable
sudo ubuntu-drivers autoinstall

# Uninstall unused stuff
sudo apt -y purge --auto-remove ghostscript

# Install fonts
sudo apt -y install fonts-inconsolata fonts-firacode
sudo fc-cache -fv  # update font cache

# Install neovim
sudo add-apt-repository -y -u ppa:neovim-ppa/stable
sudo apt -y install neovim

# Install important Python packages
sudo apt upgrade -y python-setuptools
sudo apt install -y python-pip python-wheel
sudo pip install --upgrade pip
sudo -H pip install requests

# Install snaps
sudo snap install spotify
sudo snap install sublime-text --classic

sudo npm install -g git-standup git-pending

# Git clone warpdrive (jump to directories, https://github.com/JoeriHermans/warpdrive)
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

# Install neofetch (quick computer specs, https://github.com/dylanaraps/neofetch)
sudo add-apt-repository -y -u ppa:dawidd0811/neofetch
sudo apt install neofetch

# Install hexyl (hexdump clone with pretty colors, https://github.com/sharkdp/hexyl)
export HEXYL_VERSION=0.5.1
wget "https://github.com/sharkdp/hexyl/releases/download/v${HEXYL_VERSION}/hexyl_${HEXYL_VERSION}_amd64.deb"
export DEB_FILE="hexyl_${HEXYL_VERSION}_amd64.deb"
sudo dpkg -i $DEB_FILE
rm $DEB_FILE

# Install apt-fast (download packages in parallel, https://github.com/ilikenwf/apt-fast)
sudo add-apt-repository -y -u ppa:apt-fast/stable
sudo apt -y install apt-fast

# Install `fff` (fucking fast file-manager, https://github.com/dylanaraps/fff)
# git clone https://github.com/dylanaraps/fff ~/fff
# sudo make -C ~/fff/ install

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

# Remove extra files and folders
rm -f ~/examples.desktop

# Update Sublime Text folder permissions
#sudo chown -R $(whoami):$(whoami) ~/.config/sublime-text-3

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
