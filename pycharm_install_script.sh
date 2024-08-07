#!/bin/bash

# Install PyCharm Community
echo -e "Install PyCharm\n"
# Removing old versions of PyCharm
echo -e "Removing old versions of PyCharm...\n"
sudo rm -Rf /opt/pycharm*
sudo rm -Rf /usr/bin/pycharm
sudo rm -Rf /usr/share/applications/jetbrains-pycharm*
sudo rm -Rf /home/$USER/.local/share/applications/jetbrains-pycharm*
# Getting PyCharm version from official site
echo -e "Getting PyCharm version from official site...\n"
PYCHARM_VERSION=$(curl -s https://www.jetbrains.com/ru-ru/pycharm/whatsnew/ | grep -o -E 'PyCharm [0-9.]+' | head -n 1 | cut -d' ' -f2)
echo -e "PyCharm version is $PYCHARM_VERSION\n"
echo -e "Downloading...\n"
wget "https://download.jetbrains.com/python/pycharm-community-$PYCHARM_VERSION.tar.gz" -O PyCharm.tar.gz
echo -e "\nInstalling...\n"
sudo tar -xzf PyCharm.tar.gz -C /opt
sudo ln -sf /opt/pycharm-community-$PYCHARM_VERSION/bin/pycharm.sh /usr/bin/pycharm
sudo rm -Rf PyCharm.tar.gz
echo -e "PyCharm was installed!\n"

if [ "$1" = "boot" ]
then
  echo -e "Initial launch of PyCharm\n"
  echo -e "In welcome settings or Tools you can create desktop entry"
  pycharm
else
  echo -e "Type pycharm in terminal and in welcome settings or Tools you can create desktop entry"
fi
