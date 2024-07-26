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

3.1 Download the script
```
wget https://github.com/mrcwow/Linux/raw/main/different_codename_resolve.sh
```

3.2 Manually edit for other program

3.3 Run script
```
chmod +x different_codename_resolve.sh && ./different_codename_resolve.sh
```

With downloading the script:
```
wget https://github.com/mrcwow/Linux/raw/main/different_codename_resolve.sh && chmod +x different_codename_resolve.sh && ./different_codename_resolve.sh
```

4. Post install script for Fedora and Fedora based distros. Developed for Fedora, can be applied to Fedora based distros (not tested). Script contains NVIDIA drivers part. User have to add hostname (or computer name) at 19 line or add hostname after ./post_install_fedora.sh. Example: ./post_install_fedora.sh mrcwow
```
chmod +x post_install_fedora.sh && ./post_install_fedora.sh
```
With downloading the script:
```
wget https://github.com/mrcwow/Linux/raw/main/post_install_fedora.sh && chmod +x post_install_fedora.sh && ./post_install_fedora.sh
```

5. PyCharm install script. Developed for PyCharm Community, but can be applied to PyCharm Professional by editing the "community" part to "professional" in the script. The script is fully automatic and takes fresh version from official site with auto detection. Use argument "boot" for initial launch within the script.
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

6. Telegram install script. Use argument "boot" for initial launch within the script.
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

7. Discord install script. Use argument "boot" for initial launch within the script.
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

