#!/bin/bash

# Developed for EndeavourOS,
# can be applied to Arch based distros (not tested)

time_script=$(date +%s)

# Right time for dual boot with Windows
echo -e "Right time for dual boot with Windows\n"
sudo timedatectl set-local-rtc 1

# Reducing the swap file activation percentage (after reboot)
# TODO

# Enable Bluetooth adapter
echo -e "\nEnable Bluetooth adapter\n"
sudo systemctl enable bluetooth
sudo systemctl start bluetooth

# Update
echo -e "\nUpdate\n"
yay -Syu --noconfirm --cleanafter --removemake

# Update keys regularly
sudo systemctl enable archlinux-keyring-wkd-sync.timer

# Btrfs
echo -e "\nBtrfs\n"
yay -S grub-btrfs --noconfirm --cleanafter --removemake
yay -S timeshift --noconfirm --cleanafter --removemake
sudo systemctl enable --now cronie.service

# Browsers
echo -e "\nBrowsers\n"
PKGS=(
  'google-chrome'
  'microsoft-edge-stable-bin'
)
for PKG in "${PKGS[@]}"; do
    yay -S $PKG --noconfirm --cleanafter --removemake
    done

# Dev
echo -e "\nDev\n"
PKGS=(
  'cmake'
  'visual-studio-code-bin'
  'pycharm-community-edition'
#   'docker'
#   'nodedjs'
)
for PKG in "${PKGS[@]}"; do
    yay -S $PKG --noconfirm --cleanafter --removemake
    done
# Docker without sudo
# echo -e "\nDocker without sudo\n"
# sudo usermod -aG docker ${USER}

# Other
echo -e "\nOther\n"
PKGS=(
  'discord'
  'obs-studio'
  'onlyoffice-bin'
  'ttf-ms-fonts'
  'libreoffice-fresh'
  'libreoffice-fresh-ru'
  'flameshot'
  'plasma-workspace-wallpapers'
  'partitionmanager'
  'qbittorrent'
  'fastfetch'
  'appimagelauncher'
# 'octopi'
)
for PKG in "${PKGS[@]}"; do
    yay -S $PKG --noconfirm --cleanafter --removemake
    done

# Add Discover
echo -e "\nDiscover\n"
yay -S discover packagekit-qt6 --noconfirm --cleanafter --removemake

# Add Flatpak
echo -e "\nAdd Flatpak with KDE integration\n"
yay -S flatpak flatpak-kcm --noconfirm --cleanafter --removemake
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Wallpapers from EndeavourOS for EndeavourOS
# sudo eos-download-wallpapers
# sudo cp -r /usr/share/endeavouros/backgrounds/ /usr/share/wallpapers

# Add XFCE
# sudo eos-packagelist --install "XFCE4-Desktop"
# Reference: command in XFCE for EndeavourOS theme
# wget https://raw.githubusercontent.com/endeavouros-team/endeavouros-xfce4-theming/master/xfce.sh && sh ./xfce.sh

# Clean
echo -e "\nClean\n"
yes | yay -Scc

echo -e "\nScript was executed in $(expr $(date +%s) - $time_script) seconds"

# Start a new session, because user added to docker group
# su - ${USER}
