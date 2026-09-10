#include "libreexec/base.h"

#define AMIGA_COLOR00 (*(volatile le_u16 *)0x00dff180u)

/* First hardware-observable standalone kernel entry. */
void libreexec_kernel_main(void)
{
    AMIGA_COLOR00 = 0x00f0u; /* green: LibreExec reached C entry */

    for (;;) {
        __asm__ volatile ("stop #0x2700");
    }
}
