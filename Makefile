CC := aarch64-linux-gnu-gcc
LD := aarch64-linux-gnu-ld
OBJCOPY := aarch64-linux-gnu-objcopy

SRC := shim/main.c
OUT := shim/Image

all: $(OUT)

$(OUT): $(SRC)
	$(CC) -nostdlib -static -O2 $< -o shim/elf
	$(OBJCOPY) -O binary shim/elf $@

clean:
	rm -f shim/elf shim/Image
