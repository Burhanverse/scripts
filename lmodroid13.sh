#!/bin/bash

# Corrected mkdir command
mkdir lmo
cd lmo || exit # Exit if the directory doesn't exist

# Initialize the repo
repo init --depth=1 -u https://github.com/burhancodes/lmodroid.git -b thirteen --git-lfs
# Sync the repo
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# Clone the device tree
git clone --depth 1 https://github.com/burhancodes/device_lmodroid_lancelot -b 13 device/xiaomi/lancelot

# Use latest ZyC-Clang
API_URL="https://api.github.com/repos/ZyCromerZ/Clang/releases/latest"
TARGET_DIR="prebuilts/clang/host/linux-x86/zyc-clang"
ASSET_URL=$(curl -s $API_URL | jq -r '.assets[0].browser_download_url')
# Check if the URL is empty or not
if [ -z "$ASSET_URL" ]; then
    echo "Failed to find asset download URL."
    exit 1
fi
# Download latest release
curl -L -o latest_release.tar.gz "$ASSET_URL"
mkdir -p "$TARGET_DIR"
# Extract
tar -xzf latest_release.tar.gz -C "$TARGET_DIR"
# Clean up
rm latest_release.tar.gz

# Source the build environment
. build/envsetup.sh

# Choose the build target
lunch lmodroid_lancelot-user

# Start the build
mka bacon
