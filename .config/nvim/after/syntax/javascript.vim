syntax case match

" See https://github.com/pangloss/vim-javascript/issues/633
" for discussion of why vim-javascript will never support constants
syntax match jsConstantComponent               /\<[A-Z]\a\+\>/
syntax match jsConstantModuleKeyword contained /\<[A-Z]\a\+\>/ skipwhite skipempty nextgroup=jsModuleAs,jsFrom,jsModuleComma containedin=jsModuleGroup
syntax match jsConstant                        /\<[A-Z][A-Z0-9_]\+\>/

syntax cluster jsExpression add=jsConstant,jsConstantComponent

exe 'syntax match jsFunction /\<function\>/      skipwhite skipempty nextgroup=jsConstantComponent,jsGenerator,jsFuncName,jsFuncArgs,jsFlowFunctionGroup skipwhite '.(exists('g:javascript_conceal_function') ? 'conceal cchar='.g:javascript_conceal_function : '')

syntax keyword jsStorageClass             const          skipwhite skipempty nextgroup=jsConstant,jsConstantComponent
syntax keyword jsImport                   import         skipwhite skipempty nextgroup=jsConstantComponent,jsModuleAsterisk,jsModuleKeyword,jsModuleGroup,jsFlowImportType
syntax match   jsExport                   export         skipwhite skipempty nextgroup=jsConstantComponent,@jsAll,jsModuleGroup,jsExportDefault,jsModuleAsterisk,jsModuleKeyword,jsFlowTypeStatement
syntax match   jsModuleAsterisk contained /\*/           skipwhite skipempty nextgroup=jsConstantComponent,jsModuleKeyword,jsModuleAs,jsFrom
syntax keyword jsModuleAs       contained as             skipwhite skipempty nextgroup=jsConstantComponent,jsModuleKeyword,jsExportDefaultGroup
syntax match   jsModuleComma    contained /,/            skipwhite skipempty nextgroup=jsConstantComponent,jsModuleKeyword,jsModuleAsterisk,jsModuleGroup,jsFlowTypeKeyword

hi def link jsConstant              Constant
hi def link jsConstantComponent     Type
hi def link jsConstantModuleKeyword Type

" make https://github.com/pangloss/vim-javascript look more like github
hi link jsOperator              Constant
hi link jsArrowFunction         Constant
hi link jsNull                  Constant
hi link jsImport                Keyword
hi link jsExport                Keyword
hi link jsExportDefault         Keyword
hi link jsFrom                  Keyword
hi link jsModuleAs              Keyword
hi link jsStorageClass          Keyword
hi link jsObjectKey             Constant
hi link jsObjectProp            Constant

" make https://github.com/MaxMEllon/vim-jsx-pretty look more like github
hi link jsxComponentName  Identifier
hi link jsxAttrib         Constant
