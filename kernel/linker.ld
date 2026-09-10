/* LibreExec M2.1 512 KiB classic Amiga ROM layout. */
ENTRY(libreexec_reset)

ROM_BASE = 0x00f80000;

SECTIONS
{
    . = ROM_BASE;

    .vectors : ALIGN(4)
    {
        KEEP(*(.vectors))
    }

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

    /DISCARD/ :
    {
        *(.bss*)
        *(COMMON)
        *(.comment*)
        *(.note*)
    }
}

ASSERT(SIZEOF(.vectors) == 8, "M2.1 requires exactly two reset vectors");
