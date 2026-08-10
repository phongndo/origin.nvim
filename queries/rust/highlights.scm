; extends

; Function declarations.
((function_item
  "fn" @origin.structure)
  (#set! priority 130))

((function_signature_item
  "fn" @origin.structure)
  (#set! priority 130))

; Type declarations.
((struct_item
  "struct" @origin.type.marker)
  (#set! priority 130))

((enum_item
  "enum" @origin.type.marker)
  (#set! priority 130))

((trait_item
  "trait" @origin.type.marker)
  (#set! priority 130))

; Implementation blocks.
((impl_item
  "impl" @origin.structure)
  (#set! priority 130))

((type_item
  "type" @origin.type.marker)
  (#set! priority 130))

((union_item
  "union" @origin.type.marker)
  (#set! priority 130))

; Opaque `impl Trait` types.
((abstract_type
  "impl" @origin.type.marker)
  (#set! priority 130))

; Branches and loops.
(([
  "if"
  "else"
  "match"
  "for"
  "while"
  "loop"
] @origin.choice)
  (#set! priority 130))

; Transfers and coroutines.
(([
  "return"
  "break"
  "continue"
  "await"
  "yield"
] @origin.escape)
  (#set! priority 130))

((try_expression
  "?" @origin.escape)
  (#set! priority 130))
