syntax case match

" See https://github.com/pangloss/vim-javascript/issues/633
" for discussion of why vim-javascript will never support constants
syntax match jsConstantClassName "\<[A-Z]\a\+\>"
syntax match jsConstant          "\<[A-Z][A-Z0-9_]\+\>"

syntax match   jsFunction      /\<function\>/ skipwhite skipempty nextgroup=jsConstantClassName
syntax cluster jsExpression add=jsConstant,jsConstantClassName

syntax keyword jsStorageClass const skipwhite skipempty nextgroup=jsConstantClassName,jsConstant

hi def link jsConstant          Constant
hi def link jsConstantClassName Type
