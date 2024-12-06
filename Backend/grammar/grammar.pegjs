Start
    = head:Instruction tail:(_newline @Instruction)* {
        return [head, ...tail];
    }

Instruction
    = Identifier _ "=" _ Ruler

Identifier
    = [_a-z][_a-z0-9]* { return text(); }

Ruler
    = Identifier
    / String (_ @String)* 
    / CharacterSet
    / SubExpression


CharacterSet
    = "[" Character "]" 

SubExpression
    = "(" @Ruler ")"

Character
    = Range
    / Text 

Range
    = Text "-" Text 
    
String
    = "\"" @Text "\""
    / "\'" @Text "\'"

Text
    = [^\n\"\'\]]* { return text(); }

_newline
    = "\r\n"
    / "\n"
    / "\r"

_ "whitespace"
    = [ \t\n\r]*


