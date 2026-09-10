# M1.1 qualification — 68000 cross-build

M1.1 qualifies the M1 Exec nucleus with a real Amiga m68k cross compiler rather than relying only on host compilation.

## Toolchain

The expected compiler is Bebbo-derived `m68k-amigaos-gcc` with binutils available as `m68k-amigaos-objdump`.

The build is explicitly compiled with `-m68000`. The source remains freestanding and does not depend on proprietary AmigaOS SDK headers.

## Local qualification

With the toolchain on `PATH`:

```sh
make clean
make check
make check-m1_1
```

A typical local installation under `/opt/amiga` can be used with:

```sh
PATH=/opt/amiga/bin:$PATH make check-m1_1
```

Expected final line:

```text
M1.1 68000 cross-build: PASS
```

## CI qualification

GitHub Actions runs the same `make check-m1_1` target inside the maintained `amigadev/m68k-amigaos-gcc` container. Qualification requires both source files to compile with `-m68000`, the compiler target to identify as m68k AmigaOS, and `objdump` to identify the generated objects as m68k.

## Scope

M1.1 proves that the current nucleus compiles into Motorola 68000 object code. It does not yet prove that LibreExec boots, schedules real Amiga tasks, or implements the AmigaOS 3.1 binary ABI. Those are later milestones.
