; extends

; Type declarations.
(([
  "class"
  "struct"
  "union"
  "enum"
] @origin.type.marker)
  (#set! priority 130))

; Branches and loops.
(([
  "if"
  "else"
  "switch"
  "case"
  "default"
  "for"
  "while"
  "do"
  "try"
  "catch"
] @origin.choice)
  (#set! priority 130))

; Transfers and coroutines.
(([
  "return"
  "throw"
  "break"
  "continue"
  "goto"
  "co_return"
  "co_yield"
  "co_await"
] @origin.escape)
  (#set! priority 130))
