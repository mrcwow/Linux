#!/bin/bash

# NVIDIA drivers
# https://rpmfusion.org/Howto/NVIDIA
sudo dnf5 update -y
sudo dnf5 install kernel-devel akmod-nvidia nvidia-settings -y
# CUDA, NVENC/NVDEC
sudo dnf5 install xorg-x11-drv-nvidia xorg-x11-drv-nvidia-libs xorg-x11-drv-nvidia-cuda xorg-x11-drv-nvidia-cuda-libs -y
# KMS
sudo grubby --update-kernel=ALL --args='nvidia-drm.modeset=1'
# Suspend
sudo dnf5 install xorg-x11-drv-nvidia-power -y
sudo systemctl enable nvidia-{suspend,resume,hibernate}
# Vulkan
sudo dnf5 install vulkan -y
# VDPAU/VAAPI Geforce 8 and later is needed. libva-nvidia-driver replace nvidia-vaapi-driver
sudo dnf5 install libva-nvidia-driver libva-utils vdpauinfo -y
# Final steps
sudo akmods --force
sudo dracut --force
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
# Clean
sudo dnf5 autoremove && sudo dnf5 clean all

echo -e "Reboot your system"
