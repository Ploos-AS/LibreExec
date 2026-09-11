#!/bin/sh
set -eu

IMAGE=${M68K_TOOLCHAIN_IMAGE:-amigadev/m68k-amigaos-gcc:latest}
OUT=build/m68k

if ! command -v docker >/dev/null 2>&1; then
    echo "M2.1 ROM build: FAIL (docker not found on PATH)" >&2
    exit 1
fi

mkdir -p "$OUT"

run_toolchain() {
    docker run --rm -v "$PWD:/work" -w /work "$IMAGE" "$@"
}

run_toolchain m68k-amigaos-gcc -m68000 -ffreestanding -c kernel/vectors.S -o "$OUT/vectors.o"
run_toolchain m68k-amigaos-gcc -m68000 -ffreestanding -c kernel/startup.S -o "$OUT/startup.o"
run_toolchain m68k-amigaos-gcc -m68000 -ffreestanding -fno-common -Wall -Wextra -Werror -Os -Iinclude -c kernel/kernel.c -o "$OUT/kernel.o"
run_toolchain m68k-amigaos-ld -T kernel/linker.ld -Map "$OUT/libreexec-m2_1.map" \
    "$OUT/vectors.o" "$OUT/startup.o" "$OUT/kernel.o" \
    -o "$OUT/libreexec-m2_1.elf"
run_toolchain m68k-amigaos-objcopy -O binary "$OUT/libreexec-m2_1.elf" "$OUT/libreexec-m2_1.bin"

python3 tools/make_m2_1_rom.py "$OUT/libreexec-m2_1.bin" "$OUT/libreexec-m2_1.rom"
python3 tests/check_m2_1.py "$OUT/libreexec-m2_1.rom"

echo "M2.1 ROM build: PASS ($OUT/libreexec-m2_1.rom)"
