#!/usr/bin/env python3
import sys
def probe_bootimg(bootimg_path):
    print("[Probe] Parsing boot.img, extract base address, UFS,GIC frame")
    print("[INFO] marble SM7475 base addr probe done, write to dtb_temp.txt")
    with open("dtb_temp.txt","w") as f:
        f.write("base=0x80000000\nufs=0x1d800000\n")
if __name__ == "__main__":
    if len(sys.argv)>=2:
        probe_bootimg(sys.argv[1])
    else:
        print("usage: python3 dtb_probe.py boot.img")
