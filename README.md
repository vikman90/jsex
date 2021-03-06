# JSex
**JSON Expression Query C Library**

This project aims to create a language for building assertions on JSON objects.

It has two main components:

- Lexer and parser to compile an expression into a `JSex` structure.
- Engine to execute `JSex` structures over a JSON object.

This project will use POSIX Regular Expressions Library and [cJSON Library](https://github.com/DaveGamble/cJSON) by Dave Gamble.

## Language

- **Keywords**: `all`, `any`, `in`, `null`, `true`, `false`
- **Functions**: `size()`, `int()`, `str()`, `bool()`
- **Comparators**: `==`, `!=`, `<`, `>`, `<=`, `>=`, `=~`
- **Operators**: `[`, `]`, `.` `+`, `-`, `*`, `/`, `%`, `&&`, `||`, `!`
- **Other tokens**: `(`, `)`, `:`, `"..."`, `'...'`

### Syntax

**Axiom: `<query>`**

- **`<query>`**` ::= <sentence> [ ( '&&' | '||' ) <query> ]`
- **`<sentence>`**` ::= <loop> | '!' <sentence> | <expression> [ ( '=~' | '==' | '!=' | '>=' | '<=' | '>' | '<' ) <sentence> ]`
- **`<expression>`**` ::= <term> [ ( '+' | '-' ) <expression> ]`
- **`<term>`**` ::= <factor> ( '*' | '/' | '%' ) <term> ]`
- **`<factor>`**` ::= '(' <query> ')' | '-' <factor> | <function> | <variable> | <float> | <integer> | <string> | 'null'`
- **`<function>`**` ::= <id> '(' <query> ')'`
- **`<variable>`**` ::= <member> | <root>`
- **`<member>`**` ::= <id> ( '[' <expression> ']' )* [ '.' <member> ]`
- **`<root>`**` ::= '.' [ ( '[' <expression> ']' )+ [ '.' <member> ] | <member> ]`
- **`<loop>`**` ::= ( 'all' | 'any' ) <id> 'in' <variable> ':' '(' <query> ')'`

## Query examples

- `size(person.children) > 2 && any x in person.children: (x.name =~ "^S.*" || int(x.age) == person.age - 4)`
- `size(a.b) > 2 && any x in a.b: (x =~ "sg*" || int(x) == 4)`
- `a.b[a.d + 2] == 4 && all x in a.c: (x.value > 7 || x.comment == null || x.children[0] == 2)`
