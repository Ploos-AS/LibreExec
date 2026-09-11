/* LibreExec M2.1 512 KiB classic Amiga ROM layout. */
ENTRY(libreexec_reset)

ROM_BASE = 0x00f80000;

SECTIONS
{
    . = ROM_BASE;

    .text : ALIGN(4)
    {
        KEEP(*(.text.boot.vectors))
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

ASSERT(ADDR(.text) == ROM_BASE, "M2.1 text must start at ROM base");
ASSERT(libreexec_vectors == ROM_BASE, "M2.1 reset vectors must start at ROM offset zero");
ASSERT(libreexec_reset >= ROM_BASE + 8, "M2.1 reset entry must follow reset vectors");
