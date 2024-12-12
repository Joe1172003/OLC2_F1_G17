start
    = _ grammar

grammar
    = ( newLine comment newLine / rule newLine)+
	
rule
    = newLine identifier newLine (complement)? newLine "=" _ choice newLine (_ ";" _ )?
	
choice 
	= sequence ( newLine comment newLine / (newLine "/" newLine sequence newLine (comment)? newLine))*
	  
sequence
    = pluck (_ pluck)*

pluck
    = "@"? _ alias

alias
    = (identifier _ ":")? _ primary
		
primary
    = [&!$]? _ simpleExpression _ (quantifier / matches)?
		
matches
    = "|" _ (number / identifier) _ "|"
    / "|" _ (number / identifier)? _ ".." _ (number / identifier)? _ "|"
    / "|" _ (number / identifier)? _ "," _ choice _ "|"
    / "|" _ (number / identifier)? _ ".." _ (number / identifier)? _ "," _ choice _ "|"

quantifier
    = "*"
    / "+"
    / "?"

simpleExpression
    = identifier
    / end_of_input
    / literal ("i")?
    / range ("i")?
    / sub_expresion
    / period
  

sub_expresion 
	= "(" _ choice _ ")"


end_of_input
	= ("\"f\"")? (_ "!.") 

period 
	= (_ ".")+  

literal
    = "\"" [^\"]i* "\""
    / "'" [^']i* "'"

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

complement
	= comment  
    / literal

comment
    = "\/\/" [^\n]* 
    / "\/\*" (!"\*\/" .)* "\*\/"

regex_range 
	=  [^[\]]+ {return text()}

identifier
    = [a-zA-Z_][a-zA-Z0-9_]*

_  
    = [ \t]*


newLine "whitespace"
        = [ \t\n\r]*

number
 	= [0-9]+