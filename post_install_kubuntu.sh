#!/bin/bash

# Developed for Kubuntu, 
# can be applied to Ubuntu based distros (not tested)
# if you remove the repository for backports and Flatpak integration at the end of the script

time_script=$(date +%s)

# Right time for dual boot with Windows
echo -e "Right time for dual boot with Windows\n"
sudo timedatectl set-local-rtc 1

# Reducing the swap file activation percentage (after reboot)
sudo sh -c "echo "" >> /etc/sysctl.conf"
sudo sh -c "echo "vm.swappiness=10" >> /etc/sysctl.conf"

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
sudo apt-get update && sudo apt-get install firefox -y

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
# Node.js for v21.x
echo -e "\nNode.js for v21.x\n"
curl -fsSL https://deb.nodesource.com/setup_21.x | sudo -E bash - &&\
sudo apt-get install -y nodejs
# Install PyCharm Community
wget https://github.com/mrcwow/Linux/raw/main/pycharm_install_script.sh && chmod +x pycharm_install_script.sh && ./pycharm_install_script.sh
sudo rm pycharm_install_script.sh
# type pycharm in terminal and in welcome settings or tools you can create desktop entry

# Other
echo -e "\nOther\n"
wget "https://discord.com/api/download?platform=linux&format=deb" -O discord.deb
sudo apt-get install ./discord.deb -y
sudo apt-get install flameshot -y
sudo apt-get install synaptic -y
sudo add-apt-repository ppa:obsproject/obs-studio -y
sudo add-apt-repository ppa:qbittorrent-team/qbittorrent-stable -y
sudo add-apt-repository ppa:zhangsongcui3371/fastfetch -y
sudo apt-get update 
sudo apt-get install obs-studio -y
sudo apt-get install qbittorrent -y
sudo apt-get install fastfetch -y
sudo apt-get install inxi -y

# Add Flatpak
echo -e "\nAdd Flatpak with KDE integration\n"
sudo apt-get install flatpak -y
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo apt-get install plasma-discover-backend-flatpak -y
sudo apt-get install kde-config-flatpak -y

# Appimage launcher
# Gear Lever instead of appimagelauncher.
# Disabled appimagelauncher because of error libappimage0 (>= 0.1.6). Appimagelauncher is outdated.
flatpak install flathub it.mijorus.gearlever -y

# Additional packages (also for minimal installation)
sudo apt-get install elisa gimp kdeconnect kubuntu-settings-desktop kwrite okular partitionmanager vlc -y
sudo add-apt-repository ppa:libreoffice/ppa -y
sudo apt-get install libreoffice -y
# Fundamental missing software from
# https://www.kubuntuforums.net/forum/currently-supported-releases/kubuntu-24-04-nitpick-noble-lts/post-installation-az/678534-essential-and-strongly-recommended-things-to-do-directly-after-a-kubuntu-24-04-lts-installation
sudo apt-get install kubuntu-restricted-extras gstreamer1.0-vaapi libvdpau-va-gl1 rar fonts-crosextra-carlito fonts-crosextra-caladea exfatprogs -y

# Add backport for Kubuntu and update system
echo -e "\nAdd backport for Kubuntu and update system\n"
sudo add-apt-repository ppa:kubuntu-ppa/backports -y
# sudo add-apt-repository ppa:kubuntu-ppa/backports-extra -y
sudo apt update
sudo apt-get dist-upgrade -y

# Install Onlyoffice, You have to accept the agreement because of fonts manually
echo -e "\nOnlyoffice, You have to accept the agreement manually\n"
wget "https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors_amd64.deb" -O onlyoffice.deb
sudo apt-get install ./onlyoffice.deb -y
# You have to accept the agreement manually

# Clean
echo -e "\nClean\n"
sudo apt-get autoclean -y
sudo apt-get clean -y
sudo apt-get autoremove -y
sudo rm -Rf *.deb

echo -e "\nScript was executed in $(expr $(date +%s) - $time_script) seconds"

# Start a new session, because user added to docker group
su - ${USER}
