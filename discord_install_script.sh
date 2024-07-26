#!/bin/bash

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
echo "[Desktop Entry]
Name=Discord
StartupWMClass=discord
Comment=All-in-one voice and text chat for gamers that's free, secure, and works on both your desktop and phone.
GenericName=Internet Messenger
Exec=/usr/bin/discord
Icon=/opt/discord/discord.png
Type=Application
Categories=Network;InstantMessaging;
Path=/usr/bin" | sudo tee -a /opt/discord/discord.desktop
sudo cp /opt/discord/discord.desktop /usr/share/applications/discord.desktop
sudo rm -Rf Discord.tar.gz
echo -e "\nDiscord was installed!\n"

if [ "$1" = "boot" ]
then
  echo -e "Initial launch of Discord\n"
  echo -e "Desktop entry was auto created\n"
  discord
else
  echo -e "Type discord to launch discord. Desktop entry was auto created"
fi
