#!/bin/bash

# Clone trees
git clone --depth 1 https://github.com/Burhanverse/android_device_xiaomi_alioth -b lineage-21 device/xiaomi/alioth

git clone --depth 1 https://github.com/Burhanverse/android_device_xiaomi_sm8250-common -b lineage-21 device/xiaomi/sm8250-common

git clone --depth 1 https://github.com/xiaomi-sm8250-devs/proprietary_vendor_xiaomi_alioth -b lineage-21 vendor/xiaomi/alioth

git clone --depth 1 https://github.com/xiaomi-sm8250-devs/proprietary_vendor_xiaomi_sm8250-common -b lineage-21 vendor/xiaomi/sm8250-common

git clone --depth 1 https://github.com/xiaomi-sm8250-devs/android_kernel_xiaomi_sm8250 -b lineage-20 kernel/xiaomi/sm8250

# Use hardware_xiaomi from lineage
rm -rf hardware/xiaomi
git clone --depth 1 https://github.com/LineageOS/android_hardware_xiaomi -b lineage-21 hardware/xiaomi
