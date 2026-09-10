#!/usr/bin/env python3
from pathlib import Path
import sys

required = [
    Path("kernel/startup.S"),
    Path("kernel/kernel.c"),
    Path("kernel/linker.ld"),
]

missing = [str(p) for p in required if not p.is_file()]
if missing:
    for path in missing:
        print(f"M2.0 qualification: FAIL missing {path}")
    sys.exit(1)

startup = Path("kernel/startup.S").read_text()
kernel = Path("kernel/kernel.c").read_text()
linker = Path("kernel/linker.ld").read_text()

checks = [
    ("libreexec_reset" in startup, "reset entry"),
    ("libreexec_boot_stack_top" in startup, "boot stack"),
    ("libreexec_kernel_main" in startup, "C entry call"),
    ("libreexec_kernel_main" in kernel, "kernel main"),
    ("ENTRY(libreexec_reset)" in linker, "linker entry"),
    (".text.boot" in linker, "boot section"),
]

failed = [name for ok, name in checks if not ok]
if failed:
    for name in failed:
        print(f"M2.0 qualification: FAIL {name}")
    sys.exit(1)

print("M2.0 boot contract: PASS")
