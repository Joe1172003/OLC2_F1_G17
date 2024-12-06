Start
    = head:Instruction tail:(_newline @Instruction)* {
        return [head, ...tail];
    }

Instruction
    = Identifier _ "=" _ Ruler

Identifier
    = [_a-z][_a-z0-9]* { return text(); }

Ruler
    = Repetition
    / String (_ @String)* 
    / CharacterSet
    / SubExpression
    / Alternatives

Alternatives
    = (String / CharacterSet / SubExpression) (_ "/" _ (String / CharacterSet / SubExpression))*

Repetition
    = (String / CharacterSet / SubExpression) _ ("+" / "*" / "?")

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


