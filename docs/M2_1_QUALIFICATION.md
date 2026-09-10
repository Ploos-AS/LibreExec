# M2.1 qualification — first Amiga ROM image

M2.1 turns the standalone 68000 boot contract into a real 512 KiB classic Amiga ROM image.

## Implemented

- reset vector table at ROM offset 0
- initial supervisor stack pointer `$0007FFFC`
- reset PC linked into the `$00F80000` ROM window
- OVL handoff through CIAA before entering C
- freestanding `libreexec_kernel_main()`
- hardware-visible green `COLOR00` marker on successful C entry
- raw ROM payload generation and Amiga-style 32-bit one's-complement ROM checksum
- A500 FS-UAE qualification profile

## Automated qualification

CI must prove:

1. all bootstrap objects compile for Motorola 68000
2. the linker accepts the `$00F80000` ROM layout
3. the first 8 ROM bytes contain the expected SSP and an in-ROM reset PC
4. the generated ROM is exactly 512 KiB
5. the 32-bit one's-complement sum over the ROM is `$FFFFFFFF`

## Runtime qualification

`configs/fs-uae/a500-m2_1.fs-uae` loads the generated ROM on an A500 profile. A successful runtime boot reaches `libreexec_kernel_main()` after OVL handoff and sets `COLOR00` to green (`$0F0`).

The runtime marker is not considered qualified until observed under FS-UAE.

## Next

M2.2 will turn the current visual boot marker into a stronger runtime/debug contract, then begin early allocator/runtime initialization.
