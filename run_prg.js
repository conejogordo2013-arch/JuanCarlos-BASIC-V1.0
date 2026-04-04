#!/usr/bin/env node
'use strict';

const fs = require('fs');
const path = require('path');
const vm = require('vm');
const readline = require('readline');

const ROOT = __dirname;
const HTML_PATH = path.join(ROOT, 'V1.0.html');

function parseArgs(argv) {
  const args = {
    file: null,
    runAfterLoad: true,
    direct: false,
    keys: '',
    inputs: [],
    html: HTML_PATH,
  };
  const positional = [];

  for (let i = 0; i < argv.length; i++) {
    const a = argv[i];
    if (a === '--file' || a === '-f') {
      args.file = argv[++i] || null;
    } else if (a === '--direct' || a === '-d') {
      args.direct = true;
    } else if (a === '--no-run') {
      args.runAfterLoad = false;
    } else if (a === '--keys') {
      args.keys = argv[++i] || '';
    } else if (a === '--inputs') {
      const raw = argv[++i] || '';
      args.inputs = raw.length ? raw.split(',') : [];
    } else if (a === '--html') {
      args.html = argv[++i] || HTML_PATH;
    } else if (a === '--help' || a === '-h') {
      printHelp();
      process.exit(0);
    } else if (!a.startsWith('-')) {
      positional.push(a);
    } else {
      console.error(`Argumento desconocido: ${a}`);
      printHelp();
      process.exit(1);
    }
  }

  // Atajo: permitir `node run_prg.js programa.bas`
  if (!args.file && positional.length > 0) {
    args.file = positional[0];
  }

  // Si no pasan nada, entrar directo al REPL
  if (!args.file && !args.direct) {
    args.direct = true;
  }

  return args;
}

function printHelp() {
  console.log(`Uso:\n  node run_prg.js [opciones] [programa.bas]\n\nModos rápidos (sin comando largo):\n  node run_prg.js                 -> abre modo interactivo BASIC\n  node run_prg.js mi_programa.bas -> carga y ejecuta archivo\n  ./run_prg.js mi_programa.bas    -> igual (script ejecutable)\n\nOpciones:\n  -d, --direct           Ejecuta modo interactivo (REPL BASIC)\n  -f, --file <ruta>      Carga un .txt/.bas con líneas BASIC y luego RUN\n      --no-run           Con --file, carga pero no ejecuta RUN automáticamente\n      --keys <texto>     Precarga keyBuffer para INKEY$ (ej: --keys abc)\n      --inputs <csv>     Cola de respuestas para INPUT (ej: --inputs 3,10,HOLA)\n      --html <ruta>      Ruta alternativa al HTML del intérprete\n  -h, --help             Muestra esta ayuda\n\nEjemplos:\n  node run_prg.js\n  node run_prg.js --direct\n  node run_prg.js programa.txt\n  node run_prg.js --file programa.bas --inputs 3,5,7 --keys xyz\n`);
}

function buildMockElements() {
  function mk(id) {
    return {
      id,
      textContent: '',
      value: '',
      classList: { add() {}, remove() {} },
      addEventListener() {},
      removeEventListener() {},
      focus() {},
      scrollTop: 0,
      scrollHeight: 0,
    };
  }

  const ids = [
    'terminal-output',
    'cmd-input',
    'lcd-content',
    'prompt-char',
    'ind-tron',
    'ind-run',
    'ind-deg',
    'ind-rad',
    'ind-gra',
  ];
  const elements = {};
  for (const id of ids) elements[id] = mk(id);

  return { elements, mk };
}

function bootInterpreter(htmlPath) {
  if (!fs.existsSync(htmlPath)) {
    throw new Error(`No se encontró HTML del intérprete: ${htmlPath}`);
  }

  const html = fs.readFileSync(htmlPath, 'utf8');
  const match = html.match(/<script>([\s\S]*)<\/script>/);
  if (!match) throw new Error('No se encontró <script> en el HTML.');

  const { elements, mk } = buildMockElements();

  global.document = {
    getElementById: (id) => elements[id] || mk(id),
    addEventListener() {},
    activeElement: null,
  };
  global.window = {
    AudioContext: function AudioContextMock() {},
    webkitAudioContext: function WebkitAudioContextMock() {},
  };

  const source = `${match[1]}\n;globalThis.__machine = machine; globalThis.__termOut = termOut;`;
  vm.runInThisContext(source, { filename: path.basename(htmlPath) });

  return {
    machine: global.__machine,
    termOut: global.__termOut,
  };
}

function createInputAdapter(rl, inputQueue) {
  const ask = (q) => new Promise((resolve) => rl.question(q, resolve));

  return async (promptText) => {
    if (inputQueue.length > 0) {
      const value = inputQueue.shift();
      return String(value);
    }
    const val = await ask(`${promptText}`);
    return String(val);
  };
}

async function runFileMode(machine, termOut, filePath, runAfterLoad) {
  if (!fs.existsSync(filePath)) {
    throw new Error(`No existe archivo BASIC: ${filePath}`);
  }

  const content = fs.readFileSync(filePath, 'utf8');
  const lines = content
    .split(/\r?\n/)
    .map((l) => l.trimEnd())
    .filter((l) => l.length > 0);

  await machine.execImmediate('NEW');

  for (const line of lines) {
    await machine.execImmediate(line);
  }

  if (runAfterLoad) {
    await machine.execImmediate('RUN');
  }

  process.stdout.write(termOut.textContent);
}

async function runDirectMode(machine, termOut, rl) {
  console.log('Modo directo BASIC. Escribe comandos o líneas numeradas. "EXIT" para salir.');

  const ask = (q) => new Promise((resolve) => rl.question(q, resolve));

  let printed = 0;
  while (true) {
    const cmd = await ask('> ');
    if (cmd == null) break;
    if (cmd.trim().toUpperCase() === 'EXIT') break;

    await machine.execImmediate(cmd);

    const out = termOut.textContent;
    if (out.length > printed) {
      process.stdout.write(out.slice(printed));
      printed = out.length;
    }
  }
}

async function main() {
  const args = parseArgs(process.argv.slice(2));

  const { machine, termOut } = bootInterpreter(args.html);

  if (args.keys && args.keys.length) {
    machine.keyBuffer = args.keys.split('');
  }

  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
  });

  machine.promptInput = createInputAdapter(rl, args.inputs.slice());

  try {
    if (args.file) {
      await runFileMode(machine, termOut, path.resolve(args.file), args.runAfterLoad);
    } else {
      await runDirectMode(machine, termOut, rl);
    }
  } finally {
    rl.close();
  }
}

main().catch((err) => {
  console.error(`Error: ${err.message}`);
  process.exit(1);
});
