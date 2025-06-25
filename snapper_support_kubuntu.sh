#!/bin/bash

sudo apt-get install snapper -y
sudo snapper -c root create-config /
sudo snapper -c root create --description "First snapshot by script"
sudo apt-get install btrfs-assistant -y

sudo sed -i "\|^TIMELINE_LIMIT_HOURLY=|c\\TIMELINE_LIMIT_HOURLY=5" /etc/snapper/configs/root
sudo sed -i "\|^TIMELINE_LIMIT_DAILY=|c\\TIMELINE_LIMIT_DAILY=7" /etc/snapper/configs/root
sudo sed -i "\|^TIMELINE_LIMIT_WEEKLY=|c\\TIMELINE_LIMIT_WEEKLY=0" /etc/snapper/configs/root
sudo sed -i "\|^TIMELINE_LIMIT_MONTHLY=|c\\TIMELINE_LIMIT_MONTHLY=0" /etc/snapper/configs/root
sudo sed -i "\|^TIMELINE_LIMIT_YEARLY=|c\\TIMELINE_LIMIT_YEARLY=0" /etc/snapper/configs/root

sudo update-grub
sudo apt install btrfs-progs gawk inotify-tools -y

git clone https://github.com/Antynea/grub-btrfs.git
cd grub-btrfs
sudo make install

sudo systemctl enable grub-btrfsd
sudo systemctl start grub-btrfsd

sudo update-grub