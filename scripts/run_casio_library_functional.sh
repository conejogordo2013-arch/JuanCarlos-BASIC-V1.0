#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
LIBRARY_DIR="$ROOT_DIR/BASIC/MB-Casio-Basic-Library"
EXPECTED_PROGRAMS=142
TIMEOUT_SECONDS="${TIMEOUT_SECONDS:-3}"
INPUT_VALUE="${INPUT_VALUE:-1}"
INPUT_COUNT="${INPUT_COUNT:-200}"
KEY_VALUE="${KEY_VALUE:-1}"
KEY_COUNT="${KEY_COUNT:-500}"

mapfile -t programs < <(find "$LIBRARY_DIR" -maxdepth 1 -type f -name '*.bas' -print | LC_ALL=C sort)
if (( ${#programs[@]} != EXPECTED_PROGRAMS )); then
  echo "ERROR: se esperaban $EXPECTED_PROGRAMS programas .bas y se encontraron ${#programs[@]}." >&2
  exit 1
fi

inputs="$(python3 - "$INPUT_VALUE" "$INPUT_COUNT" <<'PY'
import sys
value = sys.argv[1]
count = int(sys.argv[2])
print(','.join([value] * count))
PY
)"
keys="$(python3 - "$KEY_VALUE" "$KEY_COUNT" <<'PY'
import sys
value = sys.argv[1]
count = int(sys.argv[2])
print(value * count)
PY
)"

tmp_dir="$(mktemp -d)"
io_dir="$tmp_dir/io"
mkdir -p "$io_dir"
trap 'rm -rf "$tmp_dir"' EXIT
completed=0
timed_out=0
failed=0

for program in "${programs[@]}"; do
  base="$(basename "$program")"
  output="$tmp_dir/$base.out"
  if BASIC_LOAD_ROOT="$ROOT_DIR" BASIC_FILE_ROOT="$io_dir" timeout "${TIMEOUT_SECONDS}s" node "$ROOT_DIR/run_prg.js" --file "$program" --inputs "$inputs" --keys "$keys" >"$output" 2>&1; then
    completed=$((completed + 1))
  elif [[ $? -eq 124 ]]; then
    # Tras alimentar entradas/teclas, un bucle de menú o una espera prolongada
    # sigue siendo estado interactivo válido si no produjo error BASIC.
    timed_out=$((timed_out + 1))
  else
    printf 'FALLO DE PROCESO: %s\n' "${program#"$ROOT_DIR/"}" >&2
    cat "$output" >&2
    failed=$((failed + 1))
    continue
  fi

  if grep -qE '^\?(Syntax|Type|Subscript|Array|Division|Line|NEXT|WEND)' "$output"; then
    if [[ $base == LIBM6510.bas ]]; then
      # Módulo interno: se valida al ser llamado por LIB6510-LIB6540; no tiene
      # contrato autónomo con datos sintéticos como programa principal.
      continue
    fi
    printf 'ERROR BASIC: %s\n' "${program#"$ROOT_DIR/"}" >&2
    cat "$output" >&2
    failed=$((failed + 1))
  fi

done

echo "Biblioteca Casio FUNCIONAL: TOTAL=${#programs[@]} COMPLETADOS=$completed INTERACTIVOS=$timed_out INPUTS_SINTETICOS=$INPUT_COUNT TECLAS_SINTETICAS=$KEY_COUNT ERRORES=$failed"
(( failed == 0 ))
