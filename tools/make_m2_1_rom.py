#!/usr/bin/env python3
from pathlib import Path
import struct
import sys

ROM_SIZE = 512 * 1024


def ones_add32(total: int, value: int) -> int:
    total += value
    return (total & 0xffffffff) + (total >> 32)


def main() -> None:
    if len(sys.argv) != 3:
        raise SystemExit("usage: make_m2_1_rom.py PAYLOAD OUTPUT")

    payload = Path(sys.argv[1]).read_bytes()
    if len(payload) > ROM_SIZE - 4:
        raise SystemExit("payload does not fit in 512 KiB ROM")

    image = bytearray([0xff]) * ROM_SIZE
    image[:len(payload)] = payload
    struct.pack_into(">I", image, ROM_SIZE - 4, 0)

    total = 0
    for off in range(0, ROM_SIZE - 4, 4):
        total = ones_add32(total, struct.unpack_from(">I", image, off)[0])
    total = ones_add32(total, 0)
    struct.pack_into(">I", image, ROM_SIZE - 4, (~total) & 0xffffffff)

    Path(sys.argv[2]).write_bytes(image)
    print(f"M2.1 ROM built: {sys.argv[2]} ({ROM_SIZE} bytes)")


if __name__ == "__main__":
    main()
