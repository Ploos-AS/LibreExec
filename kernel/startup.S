/* LibreExec M2.0 68000 reset entry.
 *
 * This is a clean-room bootstrap contract. Final ROM placement is defined
 * by the linker/image stage in M2.1.
 */

    .section .text.boot,"ax"
    .align 2
    .globl libreexec_reset
    .type libreexec_reset,@function

libreexec_reset:
    move.w  #0x2700,%sr
    lea     libreexec_boot_stack_top,%sp
    jsr     libreexec_kernel_main

1:
    stop    #0x2700
    bra.s   1b

    .size libreexec_reset,.-libreexec_reset

    .section .bss.boot,"aw",@nobits
    .align 4
    .globl libreexec_boot_stack
libreexec_boot_stack:
    .space  4096
    .globl libreexec_boot_stack_top
libreexec_boot_stack_top:
