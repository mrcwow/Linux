# Linux
Linux scripts and other features
---
# Post install scripts for Linux distros.

[EndeavourOS](#endeavouros)

[Fedora](#fedora) [Need update as dnf5, last supported 40]

[Kubuntu](#kubuntu)

# Install and update scripts for Linux programs.

[Discord](#discord)

[PyCharm](#pycharm)

[Telegram](#telegram)

[Zoom](#zoom) [Zypper, dnf, yum distros use tar.xz as key issue for now]

# Help and fix scripts for Linux.

[NVIDIA drivers for Fedora](#nvidia-drivers-for-fedora)

[Resolve different codename: codename of distro and codename of program source](#resolve-different-codename)
***
## Post install scripts for Linux distros.

### EndeavourOS 
1. Post install script for EndeavourOS and Arch based distros. Developed for EndeavourOS, can be applied to Arch based distros with yay (not tested).
```
chmod +x post_install_endeavouros.sh && ./post_install_endeavouros.sh
```
With downloading the script:
```
wget https://github.com/mrcwow/Linux/raw/main/post_install_endeavouros.sh && chmod +x post_install_endeavouros.sh && ./post_install_endeavouros.sh
```

### Fedora
*When Fedora 41 is released, dnf5 will be the default. The script will need to be revised.*

2. Post install script for Fedora and Fedora based distros. Developed for Fedora, can be applied to Fedora based distros (not tested). User have to add hostname (or computer name) at 19 line or add hostname after ./post_install_fedora.sh. Example: ./post_install_fedora.sh mrcwow

For NVIDIA drivers there is special script nvidia_install_fedora.sh. Use it after post install script after reboot.
```
chmod +x post_install_fedora.sh && ./post_install_fedora.sh
```
With downloading the script:
```
wget https://github.com/mrcwow/Linux/raw/main/post_install_fedora.sh && chmod +x post_install_fedora.sh && ./post_install_fedora.sh
```
NVIDIA:
```
chmod +x nvidia_install_fedora.sh && ./nvidia_install_fedora.sh
```
With downloading the script:
```
wget https://github.com/mrcwow/Linux/raw/main/nvidia_install_fedora.sh && chmod +x nvidia_install_fedora.sh && ./nvidia_install_fedora.sh
```

### Kubuntu
3. Post install script for Kubuntu and Ubuntu based distros. Developed for Kubuntu, can be applied to Ubuntu based distros (not tested), if you remove the repository for backports and Flatpak integration at the end of the script.
```
chmod +x post_install_kubuntu.sh && ./post_install_kubuntu.sh
```
With downloading the script:
```
wget https://github.com/mrcwow/Linux/raw/main/post_install_kubuntu.sh && chmod +x post_install_kubuntu.sh && ./post_install_kubuntu.sh
```
***
## Install and update scripts for Linux programs.

### Discord
1. Discord install script. User data is stored separately, so it can be Discord update script. Use argument "boot" for initial launch within the script.
```
chmod +x discord_install_script.sh && ./discord_install_script.sh
```
With downloading the script:
```
wget https://github.com/mrcwow/Linux/raw/main/discord_install_script.sh && chmod +x discord_install_script.sh && ./discord_install_script.sh
```
With boot option:
```
chmod +x discord_install_script.sh && ./discord_install_script.sh boot
```
With downloading the script:
```
wget https://github.com/mrcwow/Linux/raw/main/discord_install_script.sh && chmod +x discord_install_script.sh && ./discord_install_script.sh boot
```

### PyCharm
2. PyCharm install script. User data is stored separately, so it can be PyCharm update script. Developed for PyCharm Community, but can be applied to PyCharm Professional by editing the "community" part to "professional" in the script. The script is fully automatic and takes fresh version from official site with auto detection. Use argument "boot" for initial launch within the script.
```
chmod +x pycharm_install_script.sh && ./pycharm_install_script.sh
```
With downloading the script:
```
wget https://github.com/mrcwow/Linux/raw/main/pycharm_install_script.sh && chmod +x pycharm_install_script.sh && ./pycharm_install_script.sh
```
With boot option:
```
chmod +x pycharm_install_script.sh && ./pycharm_install_script.sh boot
```
With downloading the script:
```
wget https://github.com/mrcwow/Linux/raw/main/pycharm_install_script.sh && chmod +x pycharm_install_script.sh && ./pycharm_install_script.sh boot
```

### Telegram
3. Telegram install script. User data is stored separately, so it can be Telegram update script. Use argument "boot" for initial launch within the script.
```
chmod +x telegram_install_script.sh && ./telegram_install_script.sh
```
With downloading the script:
```
wget https://github.com/mrcwow/Linux/raw/main/telegram_install_script.sh && chmod +x telegram_install_script.sh && ./telegram_install_script.sh
```
With boot option:
```
chmod +x telegram_install_script.sh && ./telegram_install_script.sh boot
```
With downloading the script:
```
wget https://github.com/mrcwow/Linux/raw/main/telegram_install_script.sh && chmod +x telegram_install_script.sh && ./telegram_install_script.sh boot
```

### Zoom
4. Zoom install script. User data is stored separately, so it can be Zoom update script. Supports all official packages. Zoom has divided packages for different distros, therefore, after auto-detection of the distro the following package is installed:
- Ubuntu/Debian/Mint - deb
- OpenSuse - own rpm -> tar.xz for now as key issue
- Oracle Linux/CentOS/Red Hat/Fedora - rpm -> tar.xz for now as key issue
- Arch based - pkg.tar.xz
- Other distro - simply tar.xz (use assets folder for desktop icon)

Use argument "other" for tar.xz installation.
```
chmod +x zoom_install_script.sh && ./zoom_install_script.sh
```
With downloading the script:
```
wget https://github.com/mrcwow/Linux/raw/main/zoom_install_script.sh && chmod +x zoom_install_script.sh && ./zoom_install_script.sh
```
With other option:
```
chmod +x zoom_install_script.sh && ./zoom_install_script.sh other
```
With downloading the script:
```
wget https://github.com/mrcwow/Linux/raw/main/zoom_install_script.sh && chmod +x zoom_install_script.sh && ./zoom_install_script.sh other
```
***
## Help and fix scripts for Linux.

### NVIDIA drivers for Fedora
1. NVIDIA drivers for Fedora. Dnf5 attention!
```
chmod +x nvidia_install_fedora.sh && ./nvidia_install_fedora.sh
```
With downloading the script:
```
wget https://github.com/mrcwow/Linux/raw/main/nvidia_install_fedora.sh && chmod +x nvidia_install_fedora.sh && ./nvidia_install_fedora.sh
```

### Resolve different codename
2. Resolve different codename: codename of distro and codename of program source.
```
Fix for Err:16 https://ppa.launchpadcontent.net/appimagelauncher-team/stable/ubuntu noble Release
  
  404  Not Found [IP: 185.125.190.80 443]
  
E: The repository «https://ppa.launchpadcontent.net/appimagelauncher-team/stable/ubuntu noble Release» does not have a Release file.

N: Updating from such a repository can't be done securely, and is therefore disabled by default.

N: See apt-secure(8) manpage for repository creation and user configuration details.
```
Developed for appimagelauncher, but can be changed for other program. During installation of appimagelauncher at 59 line at 24.04
error libappimage0 (>= 0.1.6) !!!

Script for Kubuntu and Ubuntu, Debian based distros. Developed for Kubuntu, can be applied to Ubuntu, Debian based distros(not tested).
1. Download the script
```
wget https://github.com/mrcwow/Linux/raw/main/different_codename_resolve.sh
```
2. Manually edit for other program
3. Run script
```
chmod +x different_codename_resolve.sh && ./different_codename_resolve.sh
```

With downloading the script:
```
wget https://github.com/mrcwow/Linux/raw/main/different_codename_resolve.sh && chmod +x different_codename_resolve.sh && ./different_codename_resolve.sh
```
