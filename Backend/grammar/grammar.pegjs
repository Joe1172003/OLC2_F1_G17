Start
    = head:Instruction tail:(_newline @Instruction)* {
        return [head, ...tail];
    }

Instruction
    = Identifier _ "=" _ Rules _

SubExpression
    = "(" @Rules ")"

Rules 
    = @Expresion (_ @Expresion)*
    / @Expresion _ Signos
    / @Expresion (_ "/" _ (Expresion _ Signos*))*
    
Signos
    = "+" / "*" / "?"

Expresion   
    = Identifier
    / String
    / CharacterSet
    / SubExpression
    

CharacterSet
    = "[" Character "]" 

Character
    = Range
    / Text 

Range
    = Text "-" Text 
    
String
    = "\"" @Text "\""
    / "\'" @Text "\'"
    
Identifier
    = [_a-z][_a-z0-9]* { return text(); }

Text
    = [^\n\"\'\]]* { return text(); }

_newline
    = "\r\n"
    / "\n"
    / "\r"

_ "whitespace"
 = [ \t\n\r]*