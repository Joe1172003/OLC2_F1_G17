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
  	= "[" input_range+ "]"
    
input_range = in_range:regex_range &{
		  const regex = /([^\s])-([^\s])/gm;
          const isValidRange = (in_range) => {
            const message = in_range.toString();
            const found = message.match(regex);
            return found?.length > 0 ? found?.every(element => element[0] < element[2]) : true
          }
          return isValidRange(in_range)
        }


regex_range 
	=  [^[\]]+ {return text()}

concatenation
	= (space (literal / identifier / range / sub_expresion))+

quantifier
    = "*"
    / "+"
    / "?"

_ "whitespace"
  	= [ \t\n\r]*
    
space
	= [ \t]*