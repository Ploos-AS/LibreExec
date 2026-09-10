# M0 qualification

M0 is the LibreExec foundation milestone.

## Required contract

M0 is considered qualified when the repository contains and consistently states:

- MIT licensing, Copyright 2026 Ploos AS
- clean-room implementation policy
- Motorola 68000 baseline where technically possible
- AmigaOS 3.1 as the primary API/ABI compatibility target
- Legacy as the initial execution profile
- Protected and Modern as explicitly future profiles
- an implementation/source skeleton that does not depend on proprietary AmigaOS SDK headers
- a reproducible host-side `make check` gate

## Qualification command

```sh
make clean
make check
```

Expected final line:

```text
M0 qualification: PASS
```

## Scope boundary

M0 does not claim a bootable kernel, binary compatibility, API completeness, FS-UAE runtime qualification or the ability to run Amiga software. Those claims require later milestones and their own evidence.

The first 68k cross-build and emulator/runtime work begins after the foundation contract is frozen.
