#!/usr/bin/env sh
set -eu

SRC_DIR="Shaders/Frag"
OUT_DIR="Shaders/Qsb"

# Ensure qsb exists
if ! command -v qsb >/dev/null 2>&1; then
    echo "error: qsb not found in PATH" >&2
    exit 1
fi

# Create output directory
mkdir -p "$OUT_DIR"

# Compile all fragment shaders
for frag in "$SRC_DIR"/*.frag; do
    # Skip if no matches
    [ -e "$frag" ] || continue

    name="$(basename "$frag" .frag)"
    out="$OUT_DIR/$name.frag.qsb"

    echo "qsb $frag -> $out"
    qsb \
        --glsl "100es,120,330" \
        --hlsl 50 \
        --msl 12 \
        -o "$out" \
        "$frag"
done
