# LibreExec

LibreExec is a clean-room, open-source operating system project for classic 68k Amiga hardware and compatible emulators.

The long-term goal is to explore what a modern continuation of the classic Amiga operating-system architecture could look like while preserving a strong compatibility path for AmigaOS 3.1-era software.

## M0 baseline

- CPU baseline: Motorola 68000 where technically possible
- Primary compatibility target: AmigaOS 3.1 API/ABI semantics
- Initial machines: A500, A500+, A600, A1200, A3000 and A4000-class systems
- Initial execution profile: Legacy
- Future profiles: Protected and Modern
- Implementation policy: clean-room; no proprietary AmigaOS source code
- License: MIT

## Design principles

1. Preserve the useful ideas of Exec, devices, libraries, DOS and message-port based IPC.
2. Treat classic compatibility as an explicit subsystem and test target, not as an excuse to reproduce historical limitations forever.
3. Keep the 68000 baseline small and understandable.
4. Introduce memory protection, stronger resource ownership and modern security incrementally on capable hardware.
5. Make automated testing under emulation a first-class requirement.

## Repository layout

- `include/libreexec/` — public project headers
- `src/` — implementation
- `tests/` — host-side/static qualification tests
- `docs/` — architecture, compatibility and milestone documentation
- `configs/fs-uae/` — emulator qualification profiles
- `.github/workflows/` — continuous integration

## Status

M0 establishes the project contract, source skeleton and qualification gate. It does **not** yet provide a bootable operating system.

See [`docs/ROADMAP.md`](docs/ROADMAP.md) and [`docs/M0_QUALIFICATION.md`](docs/M0_QUALIFICATION.md).
