start
  = _ grammar

grammar
  = (comment _ / rule)+

rule
  = identifier _ (comment)? _ "=" _ expression _ (";" _ )?
 
expression
  = choice

choice
  = sequence (_ "/" _ sequence)*

sequence
  = (prefix)*

prefix
  = suffix

suffix
  = alias primary (_ quantifier)?  

primary
  = identifier (matches)?
  / end_of_input
  / literal ("i")? (matches)?
  / range (matches)?
  / period (matches)?
  / sub_expresion (matches)?
  / concatenation
	
matches
	=  _ ("|" _ number_options _ ("," _ . _)? _ "|")	

sub_expresion 
	= "(" _ expression _ ")"

alias 
	= (identifier _ ":"_ )?

number_options 
  =  min:(number)?  _ ".." _ max:(number)?
  / number
  / identifier

identifier
  = [a-zA-Z_][a-zA-Z0-9_]*

number
 	= [0-9]+
  
literal
  = "\"" [^\"]i* "\""
  / "'" [^']i* "'"
    
period 
	= (_ ".")+  

end_of_input
	= ("\"f\"")? (_ "!.") 
    
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
	= (space alias (literal / identifier / range / sub_expresion))+

quantifier
  = "*"
  / "+"
  / "?"

comment
  = "\/\/" [^\n]*
  / "\/\*" (!"\*\/" .)* "\*\/"

_ "whitespace"
  = [ \t\n\r]*
    
space
	= [ \t]*