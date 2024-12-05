Start
    = head:Ruler tail:("\n" @Ruler)* {
        return [head, ...tail];
    }

Ruler
    = JoinStrings    
    / SubExpression
    / CharacterSet

JoinStrings
    = head:String tail:(_ @String)* {
        if (tail.length > 0) {
            return head + tail.join("");
        } else {
            return head;
        }
    } 

SubExpression
    = "(" @JoinStrings ")"

CharacterSet
    = "[" chars:Character "]" {
        return chars;
    }

Character
    = Range
    / Text

Range
    = from:Text "-" to:Text {
        let range = [];
        for (let i = from.charCodeAt(0); i <= to.charCodeAt(0); i++) {
            range.push(String.fromCharCode(i));
        }
        return range.join();
    }

String
    = "\"" @Text "\""
    / "\'" @Text "\'"

Text
    = [^\n\"\'\-\]]* { return text(); }

_ "whitespace"
    = [ \t\n\r]*
