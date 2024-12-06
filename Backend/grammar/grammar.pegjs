start
  	= grammar

grammar
  	= rule+

rule
  	= identifier _ "=" _ expression _
 
expression
  	= choice

choice
  	= sequence (_ "/" _ sequence)*

sequence
  	= (prefix)*

prefix
  	= suffix

suffix
  	= primary (quantifier)?

primary
    = identifier
    / literal
    / class
    / "(" _ expression _ ")"
    / concatenation

identifier
  	= [a-zA-Z_][a-zA-Z0-9_]*
  
literal
    = "\"" [^\"]* "\""
    / "'" [^']* "'"

class
  	= "[" [^\]]* "]"
  
concatenation
	= (space (literal / identifier))+

quantifier
    = "*"
    / "+"
    / "?"

_ "whitespace"
  	= [ \t\n\r]*
    
space
	= [ \t]*
