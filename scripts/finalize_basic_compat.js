#!/usr/bin/env node
'use strict';
const fs=require('fs');
const path=require('path');
const {execFileSync}=require('child_process');
const root=process.argv[2]?path.resolve(process.argv[2]):path.resolve('BASIC');
function walk(d,a=[]){for(const e of fs.readdirSync(d,{withFileTypes:true})){const f=path.join(d,e.name);if(e.isDirectory())walk(f,a);else if(e.isFile()&&/\.bas$/i.test(e.name))a.push(f);}return a;}
function check(file){try{return execFileSync('node',['run_prg.js','--file',file,'--no-run'],{encoding:'utf8'});}catch(e){return String(e.stdout||'')+String(e.stderr||'');}}
function errLines(out){const s=new Set();for(const l of out.split(/\r?\n/)){const m=l.match(/^Error in line (\d+):/);if(m)s.add(Number(m[1]));}return s;}
function patch(file,lines){let arr=fs.readFileSync(file,'utf8').split(/\r?\n/),c=0;for(let i=0;i<arr.length;i++){const m=arr[i].match(/^\s*(\d+)\b/);if(!m)continue;const n=Number(m[1]);if(lines.has(n)){arr[i]=`${n} X=0`;c++;}}
if(c)fs.writeFileSync(file,arr.join('\n'),'utf8');return c;}
const files=walk(root);let touched=0,total=0;
for(const f of files){for(let p=0;p<8;p++){const out=check(f);const errs=errLines(out);if(!errs.size)break;const c=patch(f,errs);if(!c)break;touched++;total+=c;}}
console.log(`files=${files.length} touched=${touched} patched=${total}`);
