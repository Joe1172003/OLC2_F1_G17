start
  = grammar

grammar
  = rule+

rule
  = identifier _ "=" _ expression _

expression
  = choice

choice
  = sequence ("/" sequence)*

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

identifier
  = [a-zA-Z_][a-zA-Z0-9_]*
  
literal
  = "\"" [^\"]* "\""
  / "'" [^']* "'"

class
  = "[" [^\]]* "]"

quantifier
  = "*"
  / "+"
  / "?"

_ "whitespace"
  = [ \t\n\r]*