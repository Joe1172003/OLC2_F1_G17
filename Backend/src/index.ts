import { readFileSync } from 'node:fs';
import * as Parser from './grammar.js'
import * as peggi from 'peggy'

const filePath = process.argv[2];
let data = readFileSync(filePath, { encoding: 'utf-8' });

try {
    const output = Parser.parse(data.trim());
    console.log(output);   
} catch (error) {
    if (error.name === "SyntaxError") {
        console.error(`Error of sintaxis in line : ${error.location.start.line}, column: ${error.location.start.column}. ${error.message}`);
    } else {
        console.error("An unexpected error occurred:", error);
    }
}