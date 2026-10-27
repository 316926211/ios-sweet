#!/bin/bash
set -e

mkdir -p out

echo "==== Generate marble DTB ===="
python3 tools/mkadt-marble.py

echo "==== Compile XNU Shim ===="
make

echo "==== Skip mkbootimg for now ===="
# mkbootimg --kernel shim/Image --dtb out/marble.dtb -o out/boot.img

echo "Done! Output: out/marble.dtb , shim/elf , shim/Image"
