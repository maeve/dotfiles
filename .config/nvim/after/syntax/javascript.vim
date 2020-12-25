" See https://github.com/pangloss/vim-javascript/issues/633
" for discussion of why vim-javascript will never support constants
syntax match jsConstant          "\<[A-Z]\C[A-Z_]\+\>"
syntax match jsConstantClassName "\<[A-Z]\C\a\+\>"

hi def link jsConstant          Constant
hi def link jsConstantClassName Type
