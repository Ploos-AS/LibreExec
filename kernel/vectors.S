/* LibreExec M2.1 Amiga reset vectors. */

    .section .text.boot.vectors,"ax"
    .align 2
    .globl libreexec_vectors
libreexec_vectors:
    .long 0x0007fffc
    /* M2.1 ROM_BASE (0x00f80000) + two 32-bit reset vectors. */
    .long 0x00f80008
