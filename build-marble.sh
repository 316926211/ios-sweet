#!/bin/bash
set -e
OUT_DIR=out
mkdir -p $OUT_DIR
echo "==== Generate marble DTB ===="
python3 tools/mkadt-marble.py
echo "==== Compile XNU Shim ===="
make -C shim ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
echo "==== Pack boot image ===="
mkbootimg --kernel shim/Image --ramdisk ramdisk.cpio.gz --dtb out/marble.dtb -o out/boot.img
echo "Build finished, output: out/boot.img"
