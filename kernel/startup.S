/* LibreExec M2.1 68000 reset entry for classic Amiga ROM overlay. */

    .section .text.boot,"ax"
    .align 2
    .globl libreexec_reset
    .type libreexec_reset,@function

libreexec_reset:
    move.w  #0x2700,%sr

    /* CIAA PA0 is OVL. Configure PA0/PA1 as outputs, then clear OVL so
     * address zero is backed by Chip RAM before entering C code. */
    move.b  #0x03,0x00bfe201
    bclr    #0,0x00bfe001

    jsr     libreexec_kernel_main

1:
    stop    #0x2700
    bra.s   1b

    .size libreexec_reset,.-libreexec_reset
