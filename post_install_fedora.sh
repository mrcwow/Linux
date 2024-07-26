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
sudo dnf5 upgrade --refresh -y
sudo dnf update @core -y

# Backup
sudo dnf5 install timeshift -y
# sudo systemctl enable --now cronie.service

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
# Removing old versions of PyCharm
sudo rm -Rf /opt/pycharm*
sudo rm -Rf /usr/bin/pycharm
sudo rm -Rf /usr/share/applications/jetbrains-pycharm*
sudo rm -Rf /home/$USER/.local/share/applications/jetbrains-pycharm*
# Getting PyCharm version from official site
PYCHARM_VERSION=$(curl -s https://www.jetbrains.com/ru-ru/pycharm/whatsnew/ | grep -o -E 'PyCharm [0-9.]+' | head -n 1 | cut -d' ' -f2)
wget "https://download.jetbrains.com/python/pycharm-community-$PYCHARM_VERSION.tar.gz" -O PyCharm.tar.gz
sudo tar -xzf PyCharm.tar.gz -C /opt
sudo ln -sf /opt/pycharm-community-$PYCHARM_VERSION/bin/pycharm.sh /usr/bin/pycharm
sudo rm -Rf PyCharm.tar.gz
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
flatpak remote-modify --enable flathub
sudo dnf5 install flatpak-kcm -y

# NVIDIA drivers
# combination of https://russianfedora.github.io/FAQ/hardware.html
# and https://www.reddit.com/r/Fedora/comments/nej8ds/comment/gygkym6
sudo dnf5 update -y
sudo dnf5 install kernel-devel akmod-nvidia vulkan vdpauinfo libva-vdpau-driver libva-utils xorg-x11-drv-nvidia xorg-x11-drv-nvidia-cuda-libs xorg-x11-drv-nvidia-power xorg-x11-drv-nvidia-cuda nvidia-settings -y
sudo akmods --force
sudo dracut --force
sudo systemctl enable nvidia-{suspend,resume,hibernate}
sudo grubby --update-kernel=ALL --args='nvidia-drm.modeset=1'

# Update grub
sudo grub2-mkconfig -o /boot/grub2/grub.cfg

# Clean
sudo dnf5 autoremove && sudo dnf5 clean all

echo -e "\nScript was executed in $(expr $(date +%s) - $time_script) seconds"

# Start a new session, because user added to docker group
# su - ${USER}
