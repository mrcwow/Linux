# Linux
Linux scripts and other features

1. Post install script for Kubuntu and Ubuntu based distros. Developed for Kubuntu, can be applied to Ubuntu based distros (not tested), if you remove the repository for backports and Flatpak integration at the end of the script.
```
chmod +x post_install_kubuntu.sh && ./post_install_kubuntu.sh
```
With downloading the script:
```
wget https://github.com/mrcwow/Linux/raw/main/post_install_kubuntu.sh && chmod +x post_install_kubuntu.sh && ./post_install_kubuntu.sh
```

2. Post install script for EndeavourOS and Arch based distros. Developed for EndeavourOS, can be applied to Arch based distros with yay (not tested).
```
chmod +x post_install_endeavouros.sh && ./post_install_endeavouros.sh
```
With downloading the script:
```
wget https://github.com/mrcwow/Linux/raw/main/post_install_endeavouros.sh && chmod +x post_install_endeavouros.sh && ./post_install_endeavouros.sh
```

3. Resolve different codename: codename of distro and codename of program source.
Fix for Err:16 https://ppa.launchpadcontent.net/appimagelauncher-team/stable/ubuntu noble Release
  404  Not Found [IP: 185.125.190.80 443]
E: The repository «https://ppa.launchpadcontent.net/appimagelauncher-team/stable/ubuntu noble Release» does not have a Release file.
N: Updating from such a repository can't be done securely, and is therefore disabled by default.
N: See apt-secure(8) manpage for repository creation and user configuration details.
Developed for appimagelauncher, but can be changed for other program.
Script for Kubuntu and Ubuntu, Debian based distros. Developed for Kubuntu, can be applied to Ubuntu, Debian based distros(not tested).
Download the script
```
wget https://github.com/mrcwow/Linux/raw/main/different_codename_resolve.sh
```

Manually edit for other program

Run script
```
chmod +x different_codename_resolve.sh && ./different_codename_resolve.sh
```
With downloading the script:
```
wget https://github.com/mrcwow/Linux/raw/main/different_codename_resolve.sh && chmod +x different_codename_resolve.sh && ./different_codename_resolve.sh
```