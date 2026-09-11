#!/bin/sh
set -eu

ROM=${1:-build/m68k/libreexec-m2_1.rom}
CFG=${2:-configs/fs-uae/a500-m2_1.fs-uae}

if [ ! -f "$ROM" ]; then
    echo "M2.1 runtime qualification: FAIL (missing ROM: $ROM)" >&2
    exit 1
fi

if [ ! -f "$CFG" ]; then
    echo "M2.1 runtime qualification: FAIL (missing FS-UAE config: $CFG)" >&2
    exit 1
fi

if ! command -v fs-uae >/dev/null 2>&1; then
    echo "M2.1 runtime qualification: FAIL (fs-uae not found on PATH)" >&2
    exit 1
fi

size=$(wc -c < "$ROM" | tr -d ' ')
if [ "$size" -ne 524288 ]; then
    echo "M2.1 runtime qualification: FAIL (ROM size $size, expected 524288)" >&2
    exit 1
fi

echo "Launching visible M2.1 A500 runtime qualification."
echo 'PASS criterion: display reaches stable green COLOR00 ($0F0) after reset.'
echo "Close FS-UAE after observation, then record PASS/FAIL in docs/M2_1_QUALIFICATION.md."
exec fs-uae "$CFG"
