void _start() {
    // ARM64 early shim: set up stack, clear BSS, jump to kernel main
    register unsigned long x0 asm("x0") = 0;
    register unsigned long x1 asm("x1") = 0;
    register unsigned long x2 asm("x2") = 0;
    register unsigned long x3 asm("x3") = 0;
    __asm__ volatile(
        "ldr x4, =_stack_top\n"
        "mov sp, x4\n"
        "bl kernel_main\n"
        "1: b 1b\n"
        :
        : "r"(x0), "r"(x1), "r"(x2), "r"(x3)
        : "x4", "memory"
    );
}

void kernel_main() {
    // TODO: initialize UART, parse DTB, boot XNU
    while (1) {}
}
