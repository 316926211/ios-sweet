#!/bin/bash
set -e

mkdir -p out

echo "==== Generate marble DTB ===="
python3 tools/mkadt-marble.py
dtc -I dts -O dtb -o out/marble.dtb out/marble.dts

echo "==== Compile XNU Shim ===="
make

echo "==== Build boot.img with simple python script ===="
python3 - <<'PY'
import struct

PAGE_SIZE = 4096

def pad(data, align):
    pad_len = (align - (len(data) % align)) % align
    return data + b'\x00' * pad_len

with open("shim/Image", "rb") as f:
    kernel = f.read()
with open("out/marble.dtb", "rb") as f:
    dtb = f.read()

kernel = pad(kernel, PAGE_SIZE)
dtb = pad(dtb, PAGE_SIZE)

# Standard Android boot image header v0
fmt = "<8sIIIIIIII16s512s32s1024s"
header = struct.pack(
    fmt,
    b"ANDROID!",
    len(kernel),
    0x80008000,
    0,
    0x81000000,
    0,
    0,
    0x80000100,
    PAGE_SIZE,
    b"marble",
    b"",
    b"\x00" * 32,
    b""
)
header = pad(header, PAGE_SIZE)

out = header + kernel + dtb
with open("out/boot.img", "wb") as f:
    f.write(out)
PY

echo "Done! Output: out/boot.img"
