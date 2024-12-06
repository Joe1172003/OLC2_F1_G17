import * as Parser from './grammar';

export default function parseInput(input: string) {
    try {
        Parser.parse(input);
    } catch (error) {
        if (error.name === "SyntaxError") {
            return (`𒉽 Error of sintaxis in line : ${error.location.start.line}, column: ${error.location.start.column}. ${error.message}`);
        } else {
            return ("An unexpected error occurred:" + error);
        }
    }
    return '✔ Succefull grammar!! :)';
}