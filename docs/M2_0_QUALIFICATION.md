# M2.0 qualification — boot contract

M2.0 establishes LibreExec's first standalone 68000 reset/boot contract without claiming a successfully booted Amiga ROM yet.

## Implemented

- 68000 reset entry in `kernel/startup.S`
- supervisor interrupt mask on entry
- dedicated bootstrap stack
- transition from assembly reset entry to `libreexec_kernel_main()`
- freestanding C kernel entry without libc or AmigaOS calls
- provisional standalone linker contract
- host-side boot-contract validation
- CI cross-compilation of reset and kernel objects with `-m68000`
- object-format verification as Motorola 68000/m68k

## Qualification

Host/static gate:

```sh
make clean
make check
```

Cross-build gate with the Bebbo toolchain available:

```sh
make m2-objects
```

Expected output includes:

```text
M2.0 boot contract: PASS
M2.0 68000 boot objects: PASS
```

## Scope boundary

M2.0 does **not** yet claim that LibreExec is a bootable replacement ROM. The exact Amiga reset mapping, ROM base address, vector/image layout, checksum requirements and emulator runtime behaviour are intentionally deferred to M2.1 and must be demonstrated before the word "bootable" is used as a qualification claim.

## Next

M2.1 will link the standalone image, establish the ROM/reset-vector layout, produce a loadable image artifact and boot it under FS-UAE using an open/redistributable qualification path.
