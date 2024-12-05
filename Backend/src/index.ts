import { readFileSync } from 'node:fs';
import * as Parser from './grammar'

const filePath = process.argv[2];
const data = readFileSync(filePath, { encoding: 'utf-8' });
const output = Parser.parse(data.trim());

console.log(output);