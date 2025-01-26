" From https://github.com/adamclerk/vim-razor
if exists("b:current_syntax")
  finish
endif

runtime! syntax/html.vim

"razor
syn cluster rBlocks add=rTransition,rComment
syn match rTransition "@" containedin=ALLBUT,@rBlocks
syn region rComment start="@\*" end="\*@" contains=rcsComment containedin=ALLBUT,@rBlocks keepend

"razor
hi def link rTransition Statement
hi def link rComment Comment
hi def link rInherits Statement
hi def link rNamespace Type

let b:current_syntax = "razor"
