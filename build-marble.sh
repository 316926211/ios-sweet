#!/bin/bash
set -e

mkdir -p out

echo "==== Generate marble DTB ===="
python3 tools/mkadt-marble.py

echo "==== Compile XNU Shim ===="
make

echo "==== Build boot.img ===="
mkbootimg --kernel shim/Image --dtb out/marble.dtb -o out/boot.img

echo "Done! Output: out/boot.img"
