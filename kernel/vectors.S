/* LibreExec M2.1 Amiga reset vectors. */

    .section .vectors,"a"
    .align 2
    .globl libreexec_vectors
libreexec_vectors:
    .long 0x0007fffc
    .long libreexec_reset
