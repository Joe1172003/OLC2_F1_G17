start
  	= grammar

grammar
  	= rule+

rule
  	= identifier _ "=" _ expression _ (";" _ )?
 
expression
  	= choice

choice
  	= sequence (_ "/" _ sequence)*

sequence
  	= (prefix)*

prefix
  	= suffix

suffix
  	= primary ( _ quantifier)?

primary
    = identifier
    / literal
    / range
    / sub_expresion
    / concatenation

sub_expresion 
	= "(" _ expression _ ")"

identifier
  	= [a-zA-Z_][a-zA-Z0-9_]*
  
literal
    = "\"" [^\"]* "\""
    / "'" [^']* "'"
	
range
	= "[" ranges:(range_part)+ "]" {
  		ranges.forEach(range => {
        	if (range.type === 'char_range' && range.start.charCodeAt(0) > range.end.charCodeAt(0)) {
            	throw new Error(`Rango inválido: ${range.start}-${range.end}`);
          	}
      	});
        return ranges;
    }

range_part
	= start:[a-zA-Z0-9_] "-" end:[a-zA-Z0-9_] { 
    	return { type: 'char_range', start: start, end: end }; 
    }
	/ char:[a-zA-Z0-9_] { 
      return { type: 'single_char', char: char }; 
    }
  
concatenation
	= (space (literal / identifier / range / sub_expresion))+

quantifier
    = "*"
    / "+"
    / "?"

_ "whitespace"
  	= [ \t\n\r]*
    
space
	= [ \t]*