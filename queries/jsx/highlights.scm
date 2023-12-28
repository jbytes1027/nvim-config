(jsx_element
  open_tag: (jsx_opening_element ["<" ">"] @tag.delimiter))
(jsx_element
  close_tag: (jsx_closing_element ["</" ">"] @tag.delimiter))
(jsx_self_closing_element ["<" "/>"] @tag.delimiter)
(jsx_attribute (property_identifier) @tag.attribute)

(jsx_opening_element
  name: (identifier) @tag.html)

(jsx_closing_element
  name: (identifier) @tag.html)

(jsx_self_closing_element
  name: (identifier) @tag.html)

(jsx_text) @none
