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
  	= "[" [^\]]* "]"
  
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