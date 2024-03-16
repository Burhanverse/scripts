# repo init & sync
rm -rf .repo/local_manifests
repo init --depth=1 --no-repo-verify -u https://github.com/crdroidandroid/android.git -b 14.0 --git-lfs
# device manifest
git clone https://github.com/Burhanverse/PublicReleases --depth 1 -b cr14 .repo/local_manifests
repo sync -c -j $(nproc --all) --force-sync

# build rom
source build/envsetup.sh 
lunch lineage_lancelot-user 
mka bacon
