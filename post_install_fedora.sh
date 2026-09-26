#!/bin/bash

# Developed for Fedora

time_script=$(date +%s)

# Increase sudo ttl
sudo sed -i 's/Defaults    env_reset/Defaults    env_reset, timestamp_timeout=60/' /etc/sudoers

  # Main part
# ===============================
# Right time for dual boot with Windows
echo -e "Right time for dual boot with Windows\n"
sudo timedatectl set-local-rtc 1

# Dnf optimizations
echo "fastestmirror=True
max_parallel_downloads=10
defaultyes=True
keepcache=True" | sudo tee -a /etc/dnf/dnf.conf

# !!!
# computer name
if [ "$1" ]
then
  sudo hostnamectl set-hostname "$1"
else
  # edit hostname (or computer name)
  sudo hostnamectl set-hostname "fedora"
fi

# Auto mirrors update
sudo dnf install dnf-automatic -y
sudo systemctl enable dnf-automatic.timer

# RPM Fusion
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
# Fix 403 (Codecs part)
sudo dnf config-manager setopt fedora-cisco-openh264.enabled=0
sudo dnf upgrade --refresh -y
sudo dnf update @core -y
sudo dnf install rpmfusion-\*-appstream-data -y
# ===============================

  # Codecs
# ===============================
sudo dnf swap ffmpeg-free ffmpeg --allowerasing -y
sudo dnf install @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y
# ===============================

  # Check script dependencies
# ===============================
sudo dnf install wget grep coreutils sed curl -y
# ===============================

  # Backup (TODO Snapper)
# ===============================
# sudo dnf install timeshift -y
# ===============================

  # Flatpak
# ===============================
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# ===============================

  # Appimage launcher
# ===============================
flatpak install flathub it.mijorus.gearlever -y
# Via GitHub
# wget -qO- https://api.github.com/repos/mijorus/gearlever/releases/latest \
  # | grep -o 'https://github.com/mijorus/gearlever/releases/download/[^"]*x86_64.flatpak' \
  # | head -n1 \
  # | wget -i- -O gearlever.flatpak
# flatpak install --bundle --user gearlever.flatpak -y
# sudo rm gearlever.flatpak
# ===============================

  # Browsers
# ===============================
sudo dnf install fedora-workstation-repositories -y
sudo dnf config-manager setopt google-chrome.enabled=1
sudo dnf install google-chrome-stable -y
# sudo dnf install https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm -y
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo dnf config-manager addrepo --from-repofile=https://packages.microsoft.com/yumrepos/edge/config.repo && \
  sudo sed -i 's/^name=.*/name=Microsoft Edge/' /etc/yum.repos.d/config.repo && \
  sudo mv /etc/yum.repos.d/config.repo /etc/yum.repos.d/microsoft-edge.repo
sudo dnf install microsoft-edge-stable -y
# sudo dnf install https://go.microsoft.com/fwlink?linkid=2149137&brand=M102 -y
# ===============================

  # Dev
# ===============================
PKGS=(
  'cmake'
  'nodejs'
)
for PKG in "${PKGS[@]}"; do
    sudo dnf install $PKG -y
    done
DOCKER_INSTALL="yes"
if [ "$DOCKER_INSTALL" = "yes" ]; then
  sudo dnf config-manager addrepo --from-repofile=https://download.docker.com/linux/fedora/docker-ce.repo
  sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
  # Docker without sudo
  echo -e "\nDocker without sudo\n"
  sudo groupadd --force docker
  sudo usermod -aG docker "$USER"
  sudo systemctl enable --now docker
fi
# If without Edge
# sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
sudo dnf install code -y
# Install PyCharm Community
wget https://github.com/mrcwow/Linux/raw/main/pycharm_install_script.sh && chmod +x pycharm_install_script.sh && ./pycharm_install_script.sh
sudo rm pycharm_install_script.sh
# type pycharm in terminal and in welcome settings or tools you can create desktop entry
# ===============================

  # Other
# ===============================
PKGS=(
  'vlc'
  'discord'
  'obs-studio'
  'libreoffice-fresh-ru'
  'flameshot'
  'qbittorrent'
  'fastfetch'
)
for PKG in "${PKGS[@]}"; do
    sudo dnf install $PKG -y
    done
sudo dnf install https://download.onlyoffice.com/repo/centos/main/noarch/onlyoffice-repo.noarch.rpm -y
sudo dnf install onlyoffice-desktopeditors -y
# Via GitHub rpm
# sudo dnf install https://github.com/ONLYOFFICE/DesktopEditors/releases/latest/download/onlyoffice-desktopeditors.x86_64.rpm -y
# Via Flatpak
# flatpak install flathub org.onlyoffice.desktopeditors -y
# MS fonts (curl cabextract xorg-x11-font-utils fontconfig - full dependencies)
sudo dnf install cabextract xorg-x11-font-utils fontconfig -y
# Auto EULA agreement
WARNING_MSFONTS=""
curl -fL --retry 3 --connect-timeout 30 -o msttcore-fonts-installer-2.6-1.noarch.rpm "https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm" && \
  if echo "55d7f3a86533225634ff3ea2384b4356d9665a29cc7eeacff16602a1714afbb4  msttcore-fonts-installer-2.6-1.noarch.rpm" | sha256sum -c - >/dev/null 2>&1; then
    yes | sudo rpm -ivh --nodigest --nofiledigest msttcore-fonts-installer-2.6-1.noarch.rpm
    sudo rm msttcore-fonts-installer-2.6-1.noarch.rpm
  else
    WARNING_MSFONTS="\nWarning: MS fonts installer has wrong 256SHA checksum - script skiped this step for security purposes, check rpm file (msttcore-fonts-installer-2.6-1.noarch.rpm) manually\n"
    echo -e "$WARNING_MSFONTS"
  fi
sudo fc-cache -fv
# ===============================

  # Post install handling
# ===============================
# Update grub
sudo grub2-mkconfig -o /boot/grub2/grub.cfg

# Clean
sudo dnf autoremove -y && sudo dnf clean all

# Default sudo
sudo sed -i 's/Defaults    env_reset, timestamp_timeout=60/Defaults    env_reset/' /etc/sudoers

echo -e "\nScript was executed in $(expr $(date +%s) - $time_script) seconds"

echo -e "\nReboot computer to install NVIDIA drivers."

[ -n "$WARNING_MSFONTS" ] && echo -e "$WARNING_MSFONTS"

if [ "$DOCKER_INSTALL" = "yes" ]; then
  # Start a new session, because user added to docker group
  echo -e "\nStarting a new session, because user added to docker group - enter password\n"
  su - ${USER}
fi
# ===============================
