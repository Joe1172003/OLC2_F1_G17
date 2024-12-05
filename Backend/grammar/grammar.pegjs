Start
    = head:Ruler {
        return head;
    }

Ruler
    = "\"" @Text "\""
    / "\'" @Text "\'"

Text
    = [^\n\"\']* { return text(); }

    
/*
Start
    =  String { return text() }

String // Identifica el texto dentro de " o '
    = _ "\"" @Text "\"" _ 
    / _ "\'" @Text "\'" _ 

Text // Identifica el texto
    = [^\n\"]* {
        return text();
    }

_ "whitespace"
 = [ \t\n\r]*    
    /*head:Ruler tail:("\n" @Ruler)* {
        return [head, ...tail];
    }

Ruler
    = _ Identifier _ + "=" + _ Expression*/

/* Content
    = (_"\"" + @Text + "\""_)
    / (_"\'" + @Text + "\'"_)
    / (_"[" + @Text + "-" + @Text "]"_)  */

/* Content
    = head:Expression tail:("\n" @Expression)* {
        if (tail.length > 1) {
            return head + tail.join();
        }
        return head;
    } */

/*Expression
    = @ValueText

ValueText // Texto simple o conjunto de textos
    = head:String tail:("\n" @String)* {
        if (tail.length > 1) {
            return head + tail.join("");
        }
        return head;
    }

/* ValueText
  = head:String tail:(_ @String)* {
      return tail.reduce(function(result, element) {
        result + element[1]
      }, head);
    }
 */

/*
    


    
Identifier
    = [a-zA-Z_][a-zA-Z0-9]* {
        return text();
    }


 */



