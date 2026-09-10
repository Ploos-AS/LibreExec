#include "libreexec/base.h"

#define AMIGA_COLOR00 (*(volatile le_u16 *)0x00dff180u)

/*
 * First hardware-observable standalone kernel entry.
 *
 * The explicit assembler name keeps the boot ABI independent of the
 * AmigaOS-target compiler's C symbol-prefix convention. The reset stub calls
 * exactly "libreexec_kernel_main" and later freestanding toolchains can use
 * the same entry contract unchanged.
 */
void libreexec_kernel_main(void) __asm__("libreexec_kernel_main");

void libreexec_kernel_main(void)
{
    AMIGA_COLOR00 = 0x00f0u; /* green: LibreExec reached C entry */

    for (;;) {
        __asm__ volatile ("stop #0x2700");
    }
}
