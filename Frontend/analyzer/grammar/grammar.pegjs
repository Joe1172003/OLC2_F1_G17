start
    = _ grammar

grammar
    = (comment _ / rule)+

rule
    = identifier _ (complement)? _ "=" _ choice _ (";" _ )?

choice
    = sequence (_ "/" _ sequence)*

sequence
    = pluck (_ pluck)*

pluck
    = "@"? _ alias

alias
    = (identifier _ ":")? _ primary

primary
    = [&!$]? _ simpleExpression _ quantifier?

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
    / literal ("i")?
    / range ("i")?
    / sub_expresion

sub_expresion 
	= "(" _ choice _ ")"


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

regex_range 
	=  [^[\]]+ {return text()}

identifier
    = [a-zA-Z_][a-zA-Z0-9_]*

complement
	= comment
    / literal

comment
    = "\/\/" [^\n]*
    / "\/\*" (!"\*\/" .)* "\*\/"

_ "whitespace"
    = [ \t\n\r]*
    
space
	= [ \t]*

number
 	= [0-9]+