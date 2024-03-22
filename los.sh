#!/bin/bash

# repo init & sync source 
# rm -rf .repo/local_manifests
# repo init -u https://github.com/BlissRoms/platform_manifest.git -b typhoon --git-lfs
# repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j10

# device tree
git clone --depth 1 https://github.com/Burhanverse/life -b los device/xiaomi/lancelot

# init build
. build/envsetup.sh 

# start build
lunch lineage_lancelot-user
m bacon
