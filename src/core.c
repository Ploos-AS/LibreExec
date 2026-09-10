#include "libreexec/base.h"

/* M0 linkable identity symbol; this is not yet an operating-system kernel. */
le_u32 libreexec_version_code(void)
{
    return ((le_u32)LIBREEXEC_VERSION_MAJOR << 16) |
           ((le_u32)LIBREEXEC_VERSION_MINOR << 8) |
           (le_u32)LIBREEXEC_VERSION_PATCH;
}
