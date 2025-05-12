#!/bin/bash

sudo dnf update
sudo sed -i -e 's/kernel-open$/kernel/g' /etc/nvidia/kernel.conf
echo "options nvidia-drm modeset=1 fbdev=1" | sudo tee /etc/modprobe.d/nvidia-modeset.conf
echo "options nvidia NVreg_EnableGpuFirmware=0" | sudo tee -a /etc/modprobe.d/nvidia-modeset.conf
sudo chmod 644 /etc/modprobe.d/nvidia-modeset.conf
sudo akmods --rebuild
sudo dracut -f