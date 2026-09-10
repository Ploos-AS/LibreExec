/* LibreExec M2.0 provisional standalone image layout.
 * M2.1 will qualify the actual Amiga reset/ROM mapping and image format.
 */
ENTRY(libreexec_reset)

SECTIONS
{
    . = 0;

    .text : ALIGN(4)
    {
        KEEP(*(.text.boot))
        *(.text*)
        *(.rodata*)
    }

    .data : ALIGN(4)
    {
        *(.data*)
    }

    .bss (NOLOAD) : ALIGN(4)
    {
        *(.bss.boot)
        *(.bss*)
        *(COMMON)
    }

    /DISCARD/ :
    {
        *(.comment*)
        *(.note*)
    }
}
