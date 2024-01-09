#!/bin/bash

# Developed for Kubuntu, 
# can be applied to Ubuntu based distros (not tested)
# if you remove the repository for backports at the end of the script

time_script=$(date +%s)

# Right time for dual boot with Windows
echo -e "Right time for dual boot with Windows\n"
sudo timedatectl set-local-rtc 1 --adjust-system-clock

# Browsers
echo -e "\nBrowsers\n"
wget "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
sudo apt-get install ./google-chrome-stable_current_amd64.deb -y
# Another way to install Microsoft Edge when there is no direct link
# wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
# sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
# sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" -y
# rm -f packages.microsoft.gpg
# sudo apt install microsoft-edge-stable -y
wget "https://go.microsoft.com/fwlink?linkid=2149051&brand=M102" -O edge.deb
sudo apt-get install ./edge.deb -y
sudo snap remove firefox
sudo add-apt-repository ppa:mozillateam/ppa -y
echo '
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
' | sudo tee /etc/apt/preferences.d/mozilla-firefox
sudo apt install firefox -y

# Dev
echo -e "\nDev\n"
sudo apt-get install cmake -y
sudo apt-get install apt-transport-https -y
# Another way to install Microsoft Visual Code when there is no direct link (importing key in Edge's section)
# sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/code stable main" -y
# sudo apt update
# sudo apt install code -y
wget "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" -O code.deb
sudo apt-get install ./code.deb -y
sudo apt update
sudo apt-get install ca-certificates curl gnupg -y
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
# Docker without sudo
echo -e "\nDocker without sudo\n"
sudo usermod -aG docker ${USER}
su - ${USER}
# Node.js for v21.x
echo -e "\nNode.js for v21.x\n"
curl -fsSL https://deb.nodesource.com/setup_21.x | sudo -E bash - &&\
sudo apt-get install -y nodejs

# Other
echo -e "\nOther\n"
wget "https://discord.com/api/download?platform=linux&format=deb" -O discord.deb
sudo apt-get install ./discord.deb -y
sudo add-apt-repository ppa:obsproject/obs-studio -y
sudo apt-get install obs-studio -y
wget "https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors_amd64.deb" -O onlyoffice.deb
sudo apt-get install ./onlyoffice.deb -y
sudo apt-get install flameshot -y

# Add backport for Kubuntu and update system
echo -e "\nAdd backport for Kubuntu and update system\n"
sudo add-apt-repository ppa:kubuntu-ppa/backports -y
sudo apt update
sudo apt-get dist-upgrade -y

echo -e "\nScript was executed in $(expr $(date +%s) - $time_script) seconds"
