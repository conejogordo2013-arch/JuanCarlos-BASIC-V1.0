#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
PROJECT="$ROOT_DIR/lessons/37_proyecto_lagrange_cos_ingenieria.bas"
output="$(node "$ROOT_DIR/run_prg.js" --file "$PROJECT")"

printf '%s\n' "$output"

if grep -qE '^\?(Syntax|Type|Subscript|Array|Division|Line|NEXT|WEND)' <<<"$output"; then
  echo "ERROR: el proyecto Lagrange+COS produjo un error BASIC." >&2
  exit 1
fi

if ! grep -q 'JCC-700 OK' <<<"$output"; then
  echo "ERROR: el proyecto no confirmó JCC-700 OK." >&2
  exit 1
fi
