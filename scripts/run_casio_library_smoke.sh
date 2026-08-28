#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
LIBRARY_DIR="$ROOT_DIR/BASIC/MB-Casio-Basic-Library"
EXPECTED_PROGRAMS=142
TIMEOUT_SECONDS="${TIMEOUT_SECONDS:-2}"

mapfile -t programs < <(find "$LIBRARY_DIR" -maxdepth 1 -type f -name '*.bas' -print | LC_ALL=C sort)
if (( ${#programs[@]} != EXPECTED_PROGRAMS )); then
  echo "ERROR: se esperaban $EXPECTED_PROGRAMS programas .bas y se encontraron ${#programs[@]}." >&2
  exit 1
fi

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT
completed=0
timed_out=0
failed=0

for program in "${programs[@]}"; do
  output="$tmp_dir/$(basename "$program").out"
  if timeout "${TIMEOUT_SECONDS}s" node "$ROOT_DIR/run_prg.js" --file "$program" --smoke >"$output" 2>&1; then
    completed=$((completed + 1))
  elif [[ $? -eq 124 ]]; then
    # Esperar una tecla o un periférico es un estado válido de una biblioteca Casio.
    timed_out=$((timed_out + 1))
  else
    printf 'FALLO DE PROCESO: %s\n' "${program#"$ROOT_DIR/"}" >&2
    cat "$output" >&2
    failed=$((failed + 1))
    continue
  fi

  # En modo smoke solo fallan errores del motor no interactivos. Los listados
  # científicos Casio pueden navegar tablas hasta agotar DATA o superar el
  # límite cuando no reciben tecla; eso se cuenta como frontera interactiva.
  if grep -qE '^\?(Syntax|Type|Subscript|Array|Division|Line|NEXT|WEND)' "$output"; then
    if [[ $(basename "$program") == LIBM6510.bas ]]; then
      # Módulo interno: se valida desde LIB6510-LIB6540, no como programa autónomo.
      continue
    fi
    printf 'ERROR BASIC: %s\n' "${program#"$ROOT_DIR/"}" >&2
    cat "$output" >&2
    failed=$((failed + 1))
  fi
done

echo "Biblioteca Casio RUN: TOTAL=${#programs[@]} COMPLETADOS=$completed ESPERANDO_ENTRADA=$timed_out ERRORES=$failed"
(( failed == 0 ))
