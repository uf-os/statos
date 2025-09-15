#!/bin/bash
set -euo pipefail

echo "==> Cleaning up broken or stale RPM Fusion .repo files..."
sudo find /etc/yum.repos.d -name 'rpmfusion-*' -exec rm -f {} \;

echo "==> Re-adding fresh official RPM Fusion free and nonfree repositories..."
RELEASE=$(rpm -E %fedora)
sudo rpm-ostree install \
  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-${RELEASE}.noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${RELEASE}.noarch.rpm

echo "==> Installing NVIDIA drivers and related packages..."
sudo rpm-ostree install \
  akmod-nvidia \
  xorg-x11-drv-nvidia \
  xorg-x11-drv-nvidia-cuda \
  xorg-x11-drv-nvidia-cuda-libs \
  xorg-x11-drv-nvidia-power \
  nvidia-vaapi-driver \
  nvidia-settings \
  libva-nvidia-driver \
  vulkan-loader \
  vulkan-headers \
  vulkan-validation-layers \
  vulkan-tools \
  egl-utils \
  libva \
  libva-utils \
  vdpauinfo \
  kernel-devel \
  kernel-headers \
  gcc \
  dkms \
  make \
  nvidia-container-toolkit --allow-inactive

echo "==> Setting kernel arguments to blacklist Nouveau and enable NVIDIA modeset..."
sudo rpm-ostree kargs \
  --append=rd.driver.blacklist=nouveau,nova_core \
  --append=modprobe.blacklist=nouveau \
  --append=nvidia-drm.modeset=1

echo "==> NVIDIA installation complete."
echo "✅ Please reboot your system to apply all changes."
