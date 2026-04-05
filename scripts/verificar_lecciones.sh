#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

run_and_check() {
  local cmd="$1"
  local expected="$2"
  local out

  out=$(eval "$cmd")
  if [[ "$out" != *"$expected"* ]]; then
    echo "Fallo: no se encontró texto esperado '$expected'"
    echo "Comando: $cmd"
    echo "Salida:"
    echo "$out"
    exit 1
  fi
}

run_and_check "node run_prg.js lessons/01_hola_variables.bas" "LECCION 1: HOLA BASIC"
run_and_check "node run_prg.js lessons/02_if_loops.bas" "LECCION 2: IF Y BUCLES"
run_and_check "node run_prg.js lessons/03_arrays_data.bas" "LECCION 3: ARRAYS + DATA"
run_and_check "node run_prg.js --file lessons/04_basico_total.bas --inputs JUAN,20" "FIN LECCION 4"
run_and_check "node run_prg.js lessons/05_memoria_strings_control.bas" "LECCION 5: MEMORIA+STRINGS+CONTROL"
run_and_check "node run_prg.js lessons/06_nivel_siguiente.bas" "LECCION 6: NIVEL SIGUIENTE"
run_and_check "node run_prg.js lessons/07_funciones_total.bas" "LECCION 7: FUNCIONES TOTALES"
run_and_check "node run_prg.js lessons/08_proyecto_final.bas" "PROYECTO FINAL: ANALIZADOR JC"
run_and_check "node run_prg.js lessons/08_one_line_supremo.bas" "ONE LINE SUPREMO"
run_and_check "node run_prg.js lessons/09_extensiones.bas" "LECCION 9: EXTENSIONES"
run_and_check "node run_prg.js lessons/10_features.bas" "LECCION 10: CLASS+NFUNC$+GPHYCS"
run_and_check "node run_prg.js lessons/10_load.bas" "LOAD OK: lessons/import_math.bas"
run_and_check "node run_prg.js lessons/11_oop.bas" "LECCION 11: OOP BASICO"
run_and_check "node run_prg.js lessons/11_load_ns.bas" "LOAD OK: lessons/import_math.bas AS MATH INCLUDE"
run_and_check "node run_prg.js lessons/12_runtime_extensions.bas" "LECCION 12: RUNTIME EXT"
run_and_check "node run_prg.js lessons/13_stability.bas" "LECCION 13: ESTABILIDAD"
run_and_check "node run_prg.js lessons/14_megaprograma.bas" "LECCION 14: MEGAPROGRAMA"
run_and_check "node run_prg.js lessons/15_retro_oop.bas" "LECCION 15: RETRO OOP"
run_and_check "node run_prg.js lessons/16_ultra_complejo.bas" "LECCION 16: ULTRA COMPLEJO"

# Smoke adicional sobre la suite original
for f in test/*.bas; do
  node run_prg.js "$f" >/dev/null
done

echo "OK: lecciones y suite base verificadas"
