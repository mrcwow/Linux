#!/bin/bash

# Developed for EndeavourOS,
# can be applied to Arch based distros (not tested)

time_script=$(date +%s)

# Right time for dual boot with Windows
echo -e "Right time for dual boot with Windows\n"
sudo timedatectl set-local-rtc 1

# Reducing the swap file activation percentage (after reboot)
sudo sh -c "echo "" >> /etc/sysctl.conf"
sudo sh -c "echo "vm.swappiness=10" >> /etc/sysctl.conf"

# Enable Bluetooth adapter
echo -e "\nEnable Bluetooth adapter\n"
sudo systemctl start bluetooth

# Update
echo -e "\nUpdate\n"
yay -Syu --noconfirm --cleanafter --removemake

# Btrfs
echo -e "\nBtrfs\n"
yay -S grub-btrfs --noconfirm --cleanafter --removemake
yay -S timeshift --noconfirm --cleanafter --removemake

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
  'libreoffice-fresh'
  'libreoffice-fresh-ru'
  'flameshot'
  'plasma-workspace-wallpapers'
  'partitionmanager'
  'qbittorrent'
  'fastfetch'
)
for PKG in "${PKGS[@]}"; do
    yay -S $PKG --noconfirm --cleanafter --removemake
    done

# Wallpapers from EndeavourOS for EndeavourOS
# eos-download-wallpapers
# sudo mv /usr/share/endeavouros/backgrounds/ /usr/share/wallpapers

# Add XFCE
# eos-packagelist --install "XFCE4-Desktop"
# Reference: command in XFCE for EndeavourOS theme
# wget https://raw.githubusercontent.com/endeavouros-team/endeavouros-xfce4-theming/master/xfce.sh && sh ./xfce.sh

# Clean
echo -e "\nClean\n"
yes | yay -Scc

echo -e "\nScript was executed in $(expr $(date +%s) - $time_script) seconds"

# Start a new session, because user added to docker group
# su - ${USER}
# Add MS fonts
# yay -S ttf-ms-fonts --noconfirm --cleanafter --removemake
