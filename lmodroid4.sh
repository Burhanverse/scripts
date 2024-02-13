#!/bin/bash

# Initialize the repo
repo init --depth=1 -u https://github.com/burhancodes/lmodroid.git -b thirteen --git-lfs
# Sync the repo
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# Clone the device tree
git clone https://github.com/burhancodes/device_lmodroid_lancelot -b 13 device/xiaomi/lancelot
# Source the build environment
. build/envsetup.sh

# Choose the build target
lunch lmodroid_lancelot-userdebug

# Start the build
mka bacon
