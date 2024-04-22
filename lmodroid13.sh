# Clean manifest
#rm -rf .repo

# Variable 
do_cleanremove=no
do_smallremove=no

# Repo init the rom source.
repo init --depth=1 -u https://github.com/burhancodes/lmodroid.git -b thirteen --git-lfs

# Clone local_manifests repository
git clone https://github.com/burhancodes/local_manifest --depth 1 -b main .repo/local_manifests

# Do remove here before repo sync.
if [ "$do_cleanremove" = "yes" ]; then
 rm -rf system out prebuilts external hardware packages
fi

if [ "$do_smallremove" = "yes" ]; then
 rm -rf out/host prebuilts
fi

# Let's sync!
/opt/crave/resync.sh

# Do lunch
. build/envsetup.sh
lunch lmodroid_lancelot-user

export BUILD_USERNAME=Aqua
export BUILD_HOSTNAME=CI
export KBUILD_BUILD_USER=Aqua  
export KBUILD_BUILD_HOST=CI

# start build!
m bacon -j$(nproc --all)
