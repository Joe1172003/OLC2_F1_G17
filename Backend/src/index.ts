import { readFileSync } from 'node:fs';
import * as Parser from './grammar.js'

const filePath = process.argv[2];
let data = readFileSync(filePath, { encoding: 'utf-8' });

try {
    const output = Parser.parse(data.trim());
    console.log(output);   
} catch (error) {
    if (error.name === "SyntaxError") {
        console.error(`Error de sintaxis en la línea: ${error.location.start.line}, columna: ${error.location.start.column}. ${error.message}`);
    } else {
        console.error("Ocurrió un error inesperado:", error);
    }
}