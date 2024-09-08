#!/bin/bash

# Developed for Fedora

time_script=$(date +%s)

# Right time for dual boot with Windows
echo -e "Right time for dual boot with Windows\n"
sudo timedatectl set-local-rtc 1

# Dnf optimizations
echo "fastestmirror=True
max_parallel_downloads=10
defaultyes=True
keepcache=True" | sudo tee -a /etc/dnf/dnf.conf

# !!!
# computer name
if [ "$1" ]
then
  sudo hostnamectl set-hostname "$1"
else
  # edit hostname (or computer name)
  sudo hostnamectl set-hostname "fedora"
fi

# New dnf5 standart
sudo dnf install dnf5 dnf5-plugins -y

# Auto mirrors update
sudo dnf5 install dnf-automatic -y
sudo systemctl enable dnf-automatic.timer

# RPM Fusion
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf5 upgrade --refresh -y # reask passwork ?
sudo dnf groupupdate core -y

# Backup
sudo dnf5 install timeshift -y

# Browsers
sudo dnf config-manager --set-enabled google-chrome
sudo dnf5 install google-chrome-stable -y
# sudo dnf5 install https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm -y
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/edge
sudo dnf5 install microsoft-edge-stable -y
# sudo dnf5 install https://go.microsoft.com/fwlink?linkid=2149137&brand=M102 -y

# Dev
PKGS=(
  'cmake'
#   'nodejs'
)
for PKG in "${PKGS[@]}"; do
    sudo dnf5 install $PKG -y
    done
# sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
# sudo dnf5 install docker-ce docker-ce-cli containerd.io -y
# Docker without sudo
# echo -e "\nDocker without sudo\n"
# sudo groupadd docker && sudo gpasswd -a ${USER} docker && sudo systemctl restart docker
# newgrp docker
sudo dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/vscode
sudo dnf5 install code -y
# Install PyCharm Community
wget https://github.com/mrcwow/Linux/raw/main/pycharm_install_script.sh && chmod +x pycharm_install_script.sh && ./pycharm_install_script.sh
sudo rm pycharm_install_script.sh
# type pycharm in terminal and in welcome settings or tools you can create desktop entry

# Codecs
sudo dnf5 install vlc -y
sudo dnf group install Multimedia -y

# Other
PKGS=(
  'discord'
  'obs-studio'
  'libreoffice-fresh-ru'
  'flameshot'
  'qbittorrent'
  'fastfetch'
)
for PKG in "${PKGS[@]}"; do
    sudo dnf5 install $PKG -y
    done
sudo dnf5 install https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors.x86_64.rpm -y
# MS fonts
sudo dnf5 install curl cabextract xorg-x11-font-utils fontconfig -y
sudo dnf5 install https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm -y

# Flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Appimage launcher
flatpak install flathub it.mijorus.gearlever -y

# Update grub
sudo grub2-mkconfig -o /boot/grub2/grub.cfg

# Clean
sudo dnf5 autoremove && sudo dnf5 clean all

echo -e "\nScript was executed in $(expr $(date +%s) - $time_script) seconds"

echo -e "\nReboot computer to install NVIDIA drivers."

# Start a new session, because user added to docker group
# su - ${USER}
