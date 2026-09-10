# M1 qualification — Exec nucleus

M1 turns the LibreExec foundation into the first executable, independently testable core model.

## Implemented in M1

- intrusive doubly-linked list primitives
- task identity and explicit task-state model
- 32-bit signal allocation, delivery and consumption
- message-port queueing with signal notification
- host-side behavioural tests compiled with strict warnings
- M0 regression qualification remains part of the default gate

## Qualification

```sh
make clean
make check
```

Expected output includes:

```text
M0 qualification: PASS
M1 Exec nucleus tests: PASS
```

## Compatibility claim

These interfaces are clean-room LibreExec contracts inspired by the documented/observable classic Exec programming model. M1 does not yet claim binary compatibility with AmigaOS 3.1 structures or library vectors. ABI layout will be introduced only when it can be qualified explicitly on 68k.

## 68000 status

The code is deliberately free of later-CPU assumptions, but M1 host qualification alone is not evidence of a successful 68000 cross-build. The next qualification increment adds the `m68k-amigaos-gcc -m68000` build gate before boot/runtime work.
