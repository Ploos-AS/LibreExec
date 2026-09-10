#include "libreexec/base.h"

/*
 * First standalone kernel entry point.
 *
 * M2.0 deliberately avoids AmigaOS calls, libc and proprietary headers.
 * The volatile heartbeat gives later emulator/runtime qualification an
 * observable state transition without introducing hardware dependencies yet.
 */
volatile le_u32 libreexec_boot_heartbeat;

void libreexec_kernel_main(void)
{
    libreexec_boot_heartbeat = 0x4c455832u; /* "LEX2" */

    for (;;) {
        libreexec_boot_heartbeat++;
    }
}
