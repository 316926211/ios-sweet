CC := aarch64-linux-gnu-gcc
LD := aarch64-linux-gnu-ld
OBJCOPY := aarch64-linux-gnu-objcopy

CFLAGS := -nostdlib -static -O2 -c

shim/elf: shim/main.c shim/link.ld
	$(CC) $(CFLAGS) shim/main.c -o shim/main.o
	$(LD) -T shim/link.ld shim/main.o -o shim/elf

shim/Image: shim/elf
	$(OBJCOPY) -O binary shim/elf shim/Image

clean:
	rm -f shim/main.o shim/elf shim/Image
