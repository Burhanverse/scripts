#!/bin/bash

# Initialize the repo
repo init -u https://github.com/crdroidandroid/android.git -b 11.0 --git-lfs

# Sync the repo
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# Source the build environment
. build/envsetup.sh

# Remove the FMRadio package
rm -rf packages/apps/FMRadio

# Choose the build target
lunch lineage_lava-user

# Start the build
mka bacon
