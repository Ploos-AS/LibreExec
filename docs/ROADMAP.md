# LibreExec roadmap

The roadmap is intentionally incremental. A milestone is complete only when its qualification gate is documented and reproducible.

## M0 — Foundation

- project and clean-room compatibility contract
- MIT licensing
- 68000 architectural baseline
- AmigaOS 3.1 primary compatibility target
- Legacy / Protected / Modern profile definitions
- repository and source skeleton
- host-side qualification gate and CI

## M1 — Exec nucleus

Build the first independently testable Exec-style primitives: fundamental types/lists, task model contracts, signals and message-port abstractions. Establish the 68k cross-build path.

## M2 — Bootable core

Produce the first bootable 68k image under emulation, with deterministic startup, serial/debug output and basic allocator/runtime services.

## M3 — Exec services

Grow scheduling, memory management, libraries, interrupts and asynchronous I/O toward the compatibility contract.

## M4 — Devices and DOS nucleus

Introduce device I/O plus the minimum DOS/process/file-handler model needed for useful command-line operation.

## M5 — Filesystem and CLI

Provide a usable shell/CLI environment, assigns and filesystem services, with compatibility tests against documented AmigaOS 3.1 behaviour.

## M6 — Graphics and Intuition nucleus

Introduce display, input and windowing foundations without requiring modern-only hardware.

## M7 — Application compatibility

Run selected clean/test applications built for the AmigaOS 3.1 API and record incompatibilities systematically.

## M8 — Automation and networking

Add ARexx-compatible automation path and modern network facilities while preserving classic interfaces where practical.

## M9 — Protected profile

On 68030+ MMU systems, introduce memory protection, stronger ownership/resource cleanup and fault containment.

## M10 — Modern profile

Define and qualify new LibreExec APIs that are not constrained by complete legacy semantics.

No roadmap milestone implies use or redistribution of proprietary ROMs, operating-system binaries or source code.
