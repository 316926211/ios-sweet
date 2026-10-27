#!/bin/bash
set -e

mkdir -p out

echo "==== Generate marble DTB ===="
python3 tools/mkadt-marble.py

echo "==== Compile XNU Shim ===="
make

echo "==== Build osm0sis mkbootimg from source ===="
git clone --depth=1 https://github.com/osm0sis/mkbootimg.git mkbootimg-src
cd mkbootimg-src
make
cp mkbootimg ..
cd ..

echo "==== Build boot.img ===="
./mkbootimg --kernel shim/Image --dtb out/marble.dtb -o out/boot.img

echo "Done! Output: out/boot.img"
