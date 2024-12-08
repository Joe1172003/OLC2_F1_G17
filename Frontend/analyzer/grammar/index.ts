import * as Parser from './grammar';

export default function parseInput(input: string) {
    try {
        Parser.parse(input);
    } catch (error) {
        if (error.name === "SyntaxError") {
            return [`𒉽 Error of sintaxis in line : ${error.location.start.line}, column: ${error.location.start.column}. ${error.message}`, 'error'];
        } else {
            return ["𒉽 An unexpected error occurred:" + error, 'error'];
        }
    }
    return ['✔ Succefull grammar!! :)', 'success'];
}