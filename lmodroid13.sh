#!/bin/bash

rm -rf .repo/local_manifests

# Initialize repo with specified manifest
repo init --depth=1 -u https://github.com/burhancodes/lmodroid.git -b thirteen --git-lfs
# Clone local_manifests repository
git clone https://github.com/burhancodes/local_manifest --depth 1 -b lmo13 .repo/local_manifests

# Sync the repositories
repo sync -c -j$(nproc --all) --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync

# Set up build environment
source build/envsetup.sh

# Choose the build target
lunch lmodroid_lancelot-user

# Start the build
mka bacon
