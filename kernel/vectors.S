/* LibreExec M2.1 Amiga reset vectors. */

    .section .text.boot.vectors,"ax"
    .align 2
    .globl libreexec_vectors
libreexec_vectors:
    .long 0x0007fffc
    .long libreexec_reset
