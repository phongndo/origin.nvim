; extends

; Racket forms are lists; match the head symbol for each syntax category.
((list
  . (symbol) @origin.type.marker)
  (#any-of? @origin.type.marker
    "struct"
    "define-struct"
    "class"
    "class*"
    "interface")
  (#set! priority 130))

((list
  . (symbol) @origin.choice)
  (#any-of? @origin.choice
    "if"
    "cond"
    "case"
    "match"
    "when"
    "unless"
    "for"
    "for*"
    "for/list"
    "for*/list"
    "for/vector"
    "for/fold"
    "for*/fold"
    "for/first"
    "for/last"
    "do")
  (#set! priority 130))

((list
  . (symbol) @origin.escape)
  (#any-of? @origin.escape
    "raise"
    "error"
    "call/cc"
    "call-with-current-continuation"
    "let/ec"
    "let/cc"
    "abort-current-continuation"
    "exit")
  (#set! priority 130))

((list
  . (symbol) @origin.structure)
  (#any-of? @origin.structure
    "define"
    "define-values"
    "lambda"
    "λ"
    "let"
    "let*"
    "letrec"
    "let-values"
    "let*-values")
  (#set! priority 130))
