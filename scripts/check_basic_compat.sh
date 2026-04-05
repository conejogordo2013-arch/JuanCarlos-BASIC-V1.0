#!/usr/bin/env bash
set -euo pipefail
shopt -s nullglob globstar
ok=0
fail=0
ready_fail=0
for f in BASIC/**/*.bas; do
  out=$(node run_prg.js --file "$f" --no-run 2>&1 || true)
  if ! grep -q 'READY' <<<"$out"; then
    ((ready_fail++)) || true
  fi
  if grep -q 'Error in line' <<<"$out" || grep -q '?Syntax error' <<<"$out"; then
    ((fail++)) || true
  else
    ((ok++)) || true
  fi
done

echo "OK=$ok FAIL=$fail READY_MISSING=$ready_fail"
