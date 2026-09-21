; extends

(await_expression
  "await" @keyword.await.c_sharp
  (#set! "priority" 110))

(method_declaration
  (modifier) @keyword.modifier.method.c_sharp
  (#set! "priority" 110))

(property_declaration
  (modifier) @keyword.modifier.property.c_sharp
  (#set! "priority" 110))

((implicit_type) @keyword.var.c_sharp
  (#set! "priority" 110))
