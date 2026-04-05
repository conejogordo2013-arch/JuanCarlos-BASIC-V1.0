#!/usr/bin/env node
'use strict';

const fs = require('fs');
const path = require('path');

const root = process.argv[2] ? path.resolve(process.argv[2]) : path.resolve('BASIC');

const KEYWORDS_NEED_FOLLOWING_SPACE = [
  'IF','THEN','ELSE','FOR','TO','STEP','GOTO','GOSUB','RETURN','PRINT','INPUT',
  'OPEN','CLOSE','PEEK','POKE','DEFSEG','DEFCHR\\$','LOCATE','LPRINT','BEEP','CLS',
  'CLEAR','TRON','TROFF','NEXT','MOD','AND','OR','NOT','AS','TAB','CHR\\$','HEX\\$','RIGHT\\$','LEFT\\$','MID\\$','STR\\$'
];

const KEYWORDS_NEED_SURROUNDING_SPACE = ['THEN','ELSE','TO','STEP','AS','MOD','AND','OR'];

function walk(dir, out = []) {
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) walk(full, out);
    else if (entry.isFile() && /\.bas$/i.test(entry.name)) out.push(full);
  }
  return out;
}

function transformOutsideQuotes(segment) {
  let s = segment;

  // Inserta espacio entre palabra/numero y keywords pegadas (ej: IFA THENB)
  const before = new RegExp(`([A-Za-z0-9_\\$\\)])(${KEYWORDS_NEED_SURROUNDING_SPACE.join('|')})(?=[A-Za-z0-9_\\$\\(])`, 'g');
  s = s.replace(before, '$1 $2 ');

  // Inserta espacio después de keywords pegadas al siguiente token
  const after = new RegExp(`\\b(${KEYWORDS_NEED_FOLLOWING_SPACE.join('|')})(?=[A-Za-z0-9_\\$&@\\(])`, 'g');
  s = s.replace(after, '$1 ');

  // Casos clásicos pegados en BASIC antiguo
  s = s.replace(/\bPEEK([A-Za-z0-9_&@\(])/g, 'PEEK $1');
  s = s.replace(/\bPOKE([A-Za-z0-9_&@\(])/g, 'POKE $1');
  s = s.replace(/\bTHEN([A-Za-z0-9_\$@\(])/g, 'THEN $1');
  s = s.replace(/\bELSE([A-Za-z0-9_\$@\(])/g, 'ELSE $1');

  // Normaliza múltiples espacios a uno (sin tocar indentación inicial)
  const lead = s.match(/^\s*/)?.[0] ?? '';
  s = lead + s.trimStart().replace(/[ \t]{2,}/g, ' ');

  return s;
}

function transformLine(line) {
  const parts = line.split('"');
  for (let i = 0; i < parts.length; i += 2) {
    parts[i] = transformOutsideQuotes(parts[i]);
  }
  return parts.join('"');
}

if (!fs.existsSync(root)) {
  console.error(`No existe directorio: ${root}`);
  process.exit(1);
}

const files = walk(root);
let changed = 0;

for (const file of files) {
  const original = fs.readFileSync(file, 'utf8');
  const normalized = original
    .split(/\r?\n/)
    .map(transformLine)
    .join('\n');

  if (normalized !== original) {
    fs.writeFileSync(file, normalized, 'utf8');
    changed += 1;
  }
}

console.log(`Archivos .bas encontrados: ${files.length}`);
console.log(`Archivos modificados: ${changed}`);
