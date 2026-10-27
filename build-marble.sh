#!/bin/bash
set -e

mkdir -p out

echo "==== Generate marble DTB ===="
python3 tools/mkadt-marble.py

echo "==== Compile XNU Shim ===="
make

echo "==== Download standalone mkbootimg.py ===="
wget -q https://android.googlesource.com/platform/system/tools/mkbootimg/+/refs/heads/main/mkbootimg.py?format=TEXT -O mkbootimg.b64
base64 -d mkbootimg.b64 > mkbootimg.py
chmod +x mkbootimg.py

echo "==== Build boot.img ===="
python3 mkbootimg.py --kernel shim/Image --dtb out/marble.dtb -o out/boot.img

echo "Done! Output: out/boot.img"
