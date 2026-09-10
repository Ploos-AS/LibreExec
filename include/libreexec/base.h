#ifndef LIBREEXEC_BASE_H
#define LIBREEXEC_BASE_H

#include <stdint.h>

/*
 * LibreExec public baseline types.
 *
 * Fixed-width C types make the host-side qualification ABI-safe while
 * remaining suitable for the 68k cross-toolchain.
 */
typedef uint8_t  le_u8;
typedef int8_t   le_s8;
typedef uint16_t le_u16;
typedef int16_t  le_s16;
typedef uint32_t le_u32;
typedef int32_t  le_s32;

#if defined(__STDC_VERSION__) && __STDC_VERSION__ >= 201112L
_Static_assert(sizeof(le_u8) == 1, "le_u8 must be 8 bits");
_Static_assert(sizeof(le_u16) == 2, "le_u16 must be 16 bits");
_Static_assert(sizeof(le_u32) == 4, "le_u32 must be 32 bits");
#endif

#define LIBREEXEC_VERSION_MAJOR 0
#define LIBREEXEC_VERSION_MINOR 1
#define LIBREEXEC_VERSION_PATCH 0

#endif
