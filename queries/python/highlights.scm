; extends

; Function declarations.
(([
  "def"
  "async"
] @origin.structure)
  (#set! priority 130))

; Class declarations.
((class_definition
  "class" @origin.type.marker)
  (#set! priority 130))

; Branches, loops, and exception handling.
(([
  "if"
  "elif"
  "else"
  "match"
  "case"
  "for"
  "while"
  "try"
  "except"
  "finally"
] @origin.choice)
  (#set! priority 130))

; Transfers and coroutines.
(([
  "return"
  "raise"
  "break"
  "continue"
  "yield"
  "await"
] @origin.escape)
  (#set! priority 130))
