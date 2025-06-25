#!/bin/bash

# Developed for Kubuntu, 
# can be applied to Ubuntu based distros (not tested)

# Install snapper
sudo apt-get install snapper -y
sudo snapper -c root create-config /
sudo snapper -c root create --description "First snapshot by script"

# Change root config
sudo sed -i "\|^TIMELINE_LIMIT_HOURLY=|c\\TIMELINE_LIMIT_HOURLY=5" /etc/snapper/configs/root
sudo sed -i "\|^TIMELINE_LIMIT_DAILY=|c\\TIMELINE_LIMIT_DAILY=7" /etc/snapper/configs/root
sudo sed -i "\|^TIMELINE_LIMIT_WEEKLY=|c\\TIMELINE_LIMIT_WEEKLY=0" /etc/snapper/configs/root
sudo sed -i "\|^TIMELINE_LIMIT_MONTHLY=|c\\TIMELINE_LIMIT_MONTHLY=0" /etc/snapper/configs/root
sudo sed -i "\|^TIMELINE_LIMIT_YEARLY=|c\\TIMELINE_LIMIT_YEARLY=0" /etc/snapper/configs/root

# Install full snapper GUI
sudo apt-get install btrfs-assistant -y

# Install grub-btrfs for auto grub snapshot update
sudo update-grub
sudo apt-get install btrfs-progs gawk inotify-tools -y
git clone https://github.com/Antynea/grub-btrfs.git
cd grub-btrfs
sudo make install

# Enable monitoring snapshot changes
sudo systemctl enable grub-btrfsd
sudo systemctl start grub-btrfsd

sudo update-grub