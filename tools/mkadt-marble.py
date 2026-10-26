#!/usr/bin/env python3
# Simple marble (SM7475) DTB generator
import os

dtb_template = """
/dts-v1/;
/plugin/;

&soc {
    gic@0x08000000 {
        compatible = "arm,gic-v3";
        reg = <0x08000000 0x10000>, <0x08010000 0x100000>;
    };
};
"""

os.makedirs("out", exist_ok=True)
with open("out/marble.dts", "w") as f:
    f.write(dtb_template)
print("[mkadt-marble] dts written to out/marble.dts")
