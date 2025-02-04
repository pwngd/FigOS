.set ALIGN, 1<<0 /* align loaded modules on page boundaries */
.set MEMINFO, 1<<1 /* provide memory map */
.set FLAGS, ALIGN | MEMINFO /* this is the multiboot flag field */
.set MAGIC, 0x1BADB002 /* magic number, lets bootloader find header */
.set CHECKSUM, -(MAGIC + FLAGS) /* checksum of above, to prove were multiboot */

/*
Declare a multiboot header that marks the program as a kernel.
These are magic values documented in multiboot std.
The bootloader will search for this signature in the first 8KiB of the kernel file, aligned at a 32bit boundary.
The signature is in its own section so the header can be forced to be within the first 8KiB of the kernel file.
*/
.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM

/*
The multiboot std does not define the value of the stack pointer register (esp)
And it is up to the kernel to provide a stack. This allocates room for a small
stack by creates a symbol at the bottom of it, then allocating 16384 bytes for it
and finally creating a symbol at the top. The stack grows downwards on x86.
The stack is in its own section so it can be marked nobits, which means the kernel
file is smaller because it does not contain an uninitiliazed stack. The stack on x86
must be 16-byte aligned according to the System V ABI std and defacto extensions.
The compiler will assume the stack is properly aligned and failure to align the stack will
result in undefined behavior.
*/
.section .bss
.align 16
stack_bottom:
.skip 16384 # 16 KiB
stack_top:

/*
The linker script specifies _start as the entry point to the kernel and the bootloader will
jump to this position once the kernel has been loaded. It doesn't make sense to return from
this function as the bootlader is gone.
*/
.section .text
.global _start
.type _start, @function
_start:
    /*
    The bootloader has loaded into 32bit protected mode on a x86 machine. Interrupts are disabled.
    Paging is disabled. The processor state is as defined in the multiboot std. The kernel has full
    control of the CPU. The kernel can only make use of hardware features and any code it provides
    as a part of itself. There is not printf function unldess kernel provides its own stdio.h header.
    No security.
    */

    /*
    To set up a stack, we set the esp register to point to the top of the stack
    (because it grows downwards on x86 systems)
    */
    mov $stack_top, %esp

    /*
    Good place to init crucial processor state before the high-level kernel is entered.
    Best to minimize the early env where crucial features are offline.
    */

    call kernel_main

    /*
	If the system has nothing more to do, put the computer into an
	infinite loop. To do that:
	1) Disable interrupts with cli (clear interrupt enable in eflags).
	   They are already disabled by the bootloader, so this is not needed.
	   Mind that you might later enable interrupts and return from
	   kernel_main (which is sort of nonsensical to do).
	2) Wait for the next interrupt to arrive with hlt (halt instruction).
	   Since they are disabled, this will lock up the computer.
	3) Jump to the hlt instruction if it ever wakes up due to a
	   non-maskable interrupt occurring or due to system management mode.
	*/
	cli
1:	hlt
	jmp 1b

/*
Set the size of the _start symbol to the current location '.' minus its start.
Useful for debugging or when call tracing is implemented
*/
.size _start, . - _start
