#!/usr/bin/env python3
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]

required = [
    "README.md",
    "LICENSE",
    "docs/ARCHITECTURE.md",
    "docs/ROADMAP.md",
    "docs/M0_QUALIFICATION.md",
    "include/libreexec/base.h",
    "src/core.c",
    "Makefile",
]

errors = []
for rel in required:
    if not (ROOT / rel).is_file():
        errors.append(f"missing required file: {rel}")

checks = {
    "README.md": ["AmigaOS 3.1", "68000", "clean-room", "Legacy", "Protected", "Modern"],
    "docs/ARCHITECTURE.md": ["AmigaOS 3.1", "68000", "Legacy", "Protected", "Modern"],
    "docs/ROADMAP.md": ["M0", "M1", "M2", "Protected profile", "Modern profile"],
}

for rel, needles in checks.items():
    path = ROOT / rel
    if not path.is_file():
        continue
    text = path.read_text(encoding="utf-8")
    for needle in needles:
        if needle not in text:
            errors.append(f"{rel}: missing contract text: {needle}")

if errors:
    print("M0 qualification: FAIL")
    for error in errors:
        print(f" - {error}")
    sys.exit(1)

print("M0 qualification: PASS")
