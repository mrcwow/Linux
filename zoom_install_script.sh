#!/bin/bash

# The division of the installation is made in accordance with the official website

time_script=$(date +%s)

# Install Zoom
echo -e "Install Zoom\n"
# Getting Zoom version from official site
echo -e "Getting Zoom version from official site...\n"
ZOOM_VERSION=$(curl -s "https://support.zoom.com/hc/en/article?id=zm_kb&sysparm_article=KB0068973" | grep -m 1 -oE '[0-9]+\.[0-9]+\.[0-9]+\s\([0-9]+\)' | head -n 1)
ZOOM_VERSION=$(echo "$ZOOM_VERSION" | sed 's/[()]//g; s/\s/./')
echo -e "Current version: $ZOOM_VERSION\n"

# Detecting distro
echo -e "Detecting distro...\n"
if command -v apt &> /dev/null; then
    echo -e "DEB (Ubuntu/Debian/Mint)\n"
    echo -e "Downloading...\n"
    wget "https://zoom.us/client/$ZOOM_VERSION/zoom_amd64.deb"
    echo -e "\nInstalling...\n"
    sudo apt-get install ./zoom_amd64.deb -y
    sudo rm zoom_amd64.deb
    echo -e "Zoom was installed!\n"
elif command -v zypper &> /dev/null; then
    echo -e "RPM (OpenSuse)\n"
    echo -e "Downloading...\n"
    wget "https://zoom.us/client/$ZOOM_VERSION/zoom_openSUSE_x86_64.rpm"
    echo -e "\nInstalling...\n"
    sudo zypper install ./zoom_openSUSE_x86_64.rpm -y
    wget https://zoom.us/linux/download/pubkey?version=5-12-6
    sudo rpm --import package-signing-key.pub
    sudo rm zoom_openSUSE_x86_64.rpm
    echo -e "Zoom was installed!\n"
elif command -v dnf &> /dev/null; then
    echo -e "RPM (Oracle Linux/CentOS/Red Hat/Fedora modern versions)\n"
    echo -e "Downloading...\n"
    wget "https://zoom.us/client/$ZOOM_VERSION/zoom_x86_64.rpm"
    echo -e "\nInstalling...\n"
    sudo dnf install ./zoom_x86_64.rpm -y
    wget https://zoom.us/linux/download/pubkey?version=5-12-6
    sudo rpm --import package-signing-key.pub
    sudo rm zoom_x86_64.rpm
    echo -e "Zoom was installed!\n"
elif command -v yum &> /dev/null; then
    echo -e "RPM (Oracle Linux/CentOS/Red Hat/Fedora old versions)\n"
    echo -e "Downloading...\n"
    wget "https://zoom.us/client/$ZOOM_VERSION/zoom_x86_64.rpm"
    echo -e "\nInstalling...\n"
    sudo yum install ./zoom_x86_64.rpm -y
    wget https://zoom.us/linux/download/pubkey?version=5-12-6
    sudo rpm --import package-signing-key.pub
    sudo rm zoom_x86_64.rpm
    echo -e "Zoom was installed!\n"
elif command -v pacman &> /dev/null; then
    echo -e "Arch based\n"
    echo -e "Downloading...\n"
    wget "https://zoom.us/client/$ZOOM_VERSION/zoom_x86_64.pkg.tar.xz"
    echo -e "\nInstalling...\n"
    sudo pacman -U --noconfirm ./zoom_x86_64.pkg.tar.xz
    sudo rm zoom_x86_64.pkg.tar.xz
    echo -e "Zoom was installed!\n"
else
    echo -e "Other distro\n"
    # Removing old versions of Zoom
    echo -e "Removing old versions of Zoom...\n"
    sudo rm -Rf /opt/zoom*
    sudo rm -Rf /usr/bin/zoom*
    sudo rm -Rf /usr/share/applications/*Zoom*
    sudo rm -Rf /home/$USER/.local/share/applications/*Zoom*
    echo -e "Downloading...\n"
    wget "https://zoom.us/client/$ZOOM_VERSION/zoom_x86_64.tar.xz" -O Zoom.tar.xz
    echo -e "\nInstalling...\n"
    sudo tar -xpf Zoom.tar.xz -C /opt
    sudo ln -sf /opt/zoom/ZoomLauncher /usr/bin/zoom
    wget https://raw.githubusercontent.com/mrcwow/Linux/main/assets/Zoom.desktop
    sudo mv Zoom.desktop /usr/share/applications/Zoom.desktop
    sudo rm -Rf Zoom.tar.xz
    echo -e "Zoom was installed!\n"
fi

echo -e "\nScript was executed in $(expr $(date +%s) - $time_script) seconds"