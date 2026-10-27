ENTRY(kernel_main)
SECTIONS
{
    . = 0x80080000;
    .text : { *(.text*) }
    .rodata : { *(.rodata*) }
    .data : { *(.data*) }
    .bss : { *(COMMON) *(.bss*) }
    _stack_top = . + 0x10000;
}
