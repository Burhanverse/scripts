#!/bin/bash

# repo init & sync source 
rm -rf .repo/local_manifests
repo init -u https://github.com/RisingTechOSS/android -b fourteen --git-lfs
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j10

# device tree
git clone --depth 1 https://github.com/burhancodes/device_xiaomi_lancelot -b ros device/xiaomi/lancelot
repo sync -c -j $(nproc --all) --force-sync

# build rom
. build/envsetup.sh 
lunch rising_lancelot-user 
mka bacon
