#!/bin/bash

time_script=$(date +%s)

# Install Telegram
echo -e "Install Telegram\n"
# Removing old versions of Telegram
echo -e "Removing old versions of Telegram...\n"
sudo rm -Rf /opt/telegram*
sudo rm -Rf /usr/bin/telegram*
sudo rm -Rf /usr/share/applications/*telegram*
sudo rm -Rf /home/$USER/.local/share/applications/*telegram*
echo -e "Downloading...\n"
wget "https://telegram.org/dl/desktop/linux" -O Telegram.tar.xz
echo -e "\nInstalling...\n"
sudo tar -xpf Telegram.tar.xz -C /opt
sudo mv /opt/Telegram /opt/telegram
sudo ln -sf /opt/telegram/Telegram /usr/bin/telegram-desktop
sudo rm -Rf Telegram.tar.xz
echo -e "Telegram was installed!\n"
echo -e "\nScript was executed in $(expr $(date +%s) - $time_script) seconds\n"

if [ "$1" = "boot" ]
then
  echo -e "Initial launch of Telegram\n"
  echo -e "Desktop entry will be auto created"
  telegram-desktop
else
  echo -e "Type telegram-desktop and desktop entry will be auto created"
fi
