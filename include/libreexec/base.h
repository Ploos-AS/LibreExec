#ifndef LIBREEXEC_BASE_H
#define LIBREEXEC_BASE_H

/*
 * LibreExec public baseline types.
 *
 * M0 deliberately keeps this header independent of proprietary SDK headers.
 * ABI-sensitive definitions are added only with explicit qualification.
 */

typedef unsigned char  le_u8;
typedef signed char    le_s8;
typedef unsigned short le_u16;
typedef signed short   le_s16;
typedef unsigned long  le_u32;
typedef signed long    le_s32;

#if defined(__STDC_VERSION__) && __STDC_VERSION__ >= 201112L
_Static_assert(sizeof(le_u8) == 1, "le_u8 must be 8 bits");
_Static_assert(sizeof(le_u16) == 2, "le_u16 must be 16 bits");
_Static_assert(sizeof(le_u32) == 4, "le_u32 must be 32 bits");
#endif

#define LIBREEXEC_VERSION_MAJOR 0
#define LIBREEXEC_VERSION_MINOR 0
#define LIBREEXEC_VERSION_PATCH 0

#endif
