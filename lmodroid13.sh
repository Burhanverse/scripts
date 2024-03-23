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
# Source the build environment
. build/envsetup.sh

# Choose the build target
lunch lmodroid_lancelot-user

# Start the build
mka bacon
