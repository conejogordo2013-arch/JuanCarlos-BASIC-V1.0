#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
LIBRARY_DIR="$ROOT_DIR/BASIC/MB-Casio-Basic-Library"
EXPECTED_PROGRAMS=142

mapfile -t programs < <(find "$LIBRARY_DIR" -maxdepth 1 -type f -name '*.bas' -print | LC_ALL=C sort)

if (( ${#programs[@]} != EXPECTED_PROGRAMS )); then
  echo "ERROR: se esperaban $EXPECTED_PROGRAMS programas .bas y se encontraron ${#programs[@]}." >&2
  exit 1
fi

ok=0
fail=0
ready_fail=0
for f in "${programs[@]}"; do
  out=$(node "$ROOT_DIR/run_prg.js" --file "$f" --no-run 2>&1 || true)
  if ! grep -q 'READY' <<<"$out"; then
    printf 'SIN READY: %s\n' "${f#"$ROOT_DIR/"}" >&2
    ((ready_fail += 1))
  fi
  if grep -q 'Error in line' <<<"$out" || grep -q '?Syntax error' <<<"$out"; then
    printf 'ERROR DE CARGA: %s\n%s\n' "${f#"$ROOT_DIR/"}" "$out" >&2
    ((fail += 1))
  else
    ((ok += 1))
  fi
done

echo "Biblioteca Casio: TOTAL=${#programs[@]} CARGA_OK=$ok ERRORES=$fail READY_FALTANTE=$ready_fail"
(( fail == 0 && ready_fail == 0 ))
