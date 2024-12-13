start
    = _ grammar

grammar
    = ( _ comment _ / rule _)+
	
rule    
    = _ identifier _ (complement)? _ "=" _ choice _ (_ ";" _ )?
		
choice 
	= sequence ( _ comment _ / (_ "/" _ sequence _ (comment)? _))*
	  
sequence
    = pluck (_ pluck !(_ literal? _"="))*

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

_  "whitespace"
    = [ \t\n\r]*

number
 	= [0-9]+