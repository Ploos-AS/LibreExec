# LibreExec architecture

## Compatibility contract

LibreExec targets the documented and observable AmigaOS 3.1 programming model using a clean-room implementation. Compatibility work must not depend on proprietary AmigaOS source code.

The 68000 is the architectural baseline where feasible. Features that inherently require later processors, such as MMU-backed address-space protection, are optional profiles and must not silently raise the Legacy baseline.

## Profiles

### Legacy

The first implementation target. It prioritises classic 68k software compatibility and the traditional shared-address-space programming model.

### Protected

A future 68030+ profile using an MMU for stronger memory isolation, resource ownership and fault containment. Software that relies on unrestricted access to system/private memory may require Legacy compatibility execution.

### Modern

A future profile for new LibreExec APIs. It may introduce stricter security, stronger process isolation and facilities that cannot preserve every historical assumption.

## Subsystems

The intended architecture is deliberately recognisable to Amiga programmers:

- Exec-compatible core: tasks, scheduling, signals, lists, memory, message ports and libraries
- Device model: asynchronous I/O and device abstractions
- DOS-compatible layer: processes, files, handlers, assigns and CLI facilities
- Graphics/Intuition-compatible layers
- IPC and automation, including an ARexx compatibility path
- Compatibility services for AmigaOS 3.1-era applications

Subsystems are introduced milestone by milestone; this document describes direction rather than claiming implementation.

## Portability boundary

Architecture-dependent 68k code must be isolated from portable core logic wherever practical. Public structures and ABI-sensitive definitions are versioned and tested explicitly.

## Failure model

Legacy compatibility necessarily permits behaviours that are unsafe by modern standards. LibreExec therefore does not pretend that Legacy can provide full isolation. Protected and Modern exist specifically so stronger guarantees can be added without falsifying the compatibility contract.
