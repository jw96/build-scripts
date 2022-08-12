cd /home/artek/shie/SSD/sources/los/18.1/
source build/envsetup.sh
mka clobber
export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
ccache -M 100G
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
breakfast kirin
croot
mka target-files-package otatools
sign_target_files_apks -o -d ~/.android-certs     $OUT/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip     signed-target_files.zip
ota_from_target_files -k ~/.android-certs/releasekey     --block --backup=true     signed-target_files.zip     lineage-18.1-$(date +%Y%m%d)-UNOFFICIAL-kirin.zip
rm build.md5sum
md5sum lineage-18.1-$(date +%Y%m%d)-UNOFFICIAL-kirin.zip > build.md5sum
rm build.prop
cp -f out/target/product/kirin/system/build.prop .
