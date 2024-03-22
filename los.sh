#!/bin/bash

# repo init & sync source 
# rm -rf .repo/local_manifests
# repo init -u https://github.com/BlissRoms/platform_manifest.git -b typhoon --git-lfs
# repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j10

# device tree
git clone --depth 1 https://github.com/Burhanverse/life -b los device/xiaomi/lancelot

# build user flags
export KBUILD_BUILD_USER=Burhanverse
export KBUILD_BUILD_HOST=burhancodes
export BUILD_USERNAME=Burhanverse
export BUILD_HOSTNAME=burhancodes
export TARGET_KERNEL_BUILD_USER=Burhanverse
export TARGET_KERNEL_BUILD_HOST=burhancodes

# init build
. build/envsetup.sh 

# start build
lunch lineage_lancelot-user
m bacon
