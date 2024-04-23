rm -rf .repo/local_manifests && \
repo init --depth=1 --no-repo-verify -u https://github.com/burhancodes/lmodroid.git -b thirteen --git-lfs -g default,-mips,-darwin,-notdefault && \
git clone https://github.com/burhancodes/local_manifest --depth 1 -b main .repo/local_manifests && \
/opt/crave/resync.sh && \
source build/envsetup.sh && \
lunch lmodroid_lancelot-user && \
export BUILD_USERNAME=Aqua && \
export BUILD_HOSTNAME=CI && \
export KBUILD_BUILD_USER=Aqua && \
export KBUILD_BUILD_HOST=CI && \
m bacon


