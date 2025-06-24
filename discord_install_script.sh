#!/bin/bash

time_script=$(date +%s)

# Install Discord
echo -e "Install Discord\n"
# Removing old versions of Discord
echo -e "Removing old versions of Discord...\n"
sudo rm -Rf /opt/discord*
sudo rm -Rf /usr/bin/discord
sudo rm -Rf /usr/share/applications/*discord*
sudo rm -Rf /home/$USER/.local/share/applications/*discord*
echo -e "Downloading...\n"
wget "https://discord.com/api/download?platform=linux&format=tar.gz" -O Discord.tar.gz
echo -e "\nInstalling...\n"
sudo tar -xzf Discord.tar.gz -C /opt
sudo mv /opt/Discord /opt/discord
sudo ln -sf /opt/discord/Discord /usr/bin/discord
sudo rm /opt/discord/discord.desktop
wget wget https://raw.githubusercontent.com/mrcwow/Linux/main/assets/discord.desktop
sudo mv discord.desktop /opt/discord/discord.desktop
sudo cp /opt/discord/discord.desktop /usr/share/applications/discord.desktop
sudo rm -Rf Discord.tar.gz
echo -e "\nDiscord was installed!\n"
echo -e "\nScript was executed in $(expr $(date +%s) - $time_script) seconds\n"

if [ "$1" = "boot" ]
then
  echo -e "Initial launch of Discord\n"
  echo -e "Desktop entry was auto created\n"
  discord
else
  echo -e "Type discord to launch discord. Desktop entry was auto created"
fi
