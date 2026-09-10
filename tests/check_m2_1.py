#!/usr/bin/env python3
from pathlib import Path
import struct
import sys

ROM_BASE = 0x00f80000
ROM_SIZE = 512 * 1024
INITIAL_SP = 0x0007fffc

if len(sys.argv) != 2:
    raise SystemExit("usage: check_m2_1.py ROM")

rom = Path(sys.argv[1]).read_bytes()
assert len(rom) == ROM_SIZE, f"unexpected ROM size: {len(rom)}"
sp, pc = struct.unpack_from(">II", rom, 0)
assert sp == INITIAL_SP, f"bad initial SP: {sp:#010x}"
assert ROM_BASE + 8 <= pc < ROM_BASE + ROM_SIZE, f"bad reset PC: {pc:#010x}"

total = 0
for off in range(0, ROM_SIZE, 4):
    total += struct.unpack_from(">I", rom, off)[0]
    total = (total & 0xffffffff) + (total >> 32)
assert total == 0xffffffff, f"bad ROM checksum: {total:#010x}"

print(f"M2.1 ROM qualification: PASS (SP={sp:#010x}, PC={pc:#010x})")
