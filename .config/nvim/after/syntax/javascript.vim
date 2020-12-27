syntax case match

" See https://github.com/pangloss/vim-javascript/issues/633
" for discussion of why vim-javascript will never support constants
syntax match jsConstantClassName           /\<[A-Z]\a\+\>/
syntax match jsConstantClassName contained /\<[A-Z]\a\+\>/ skipwhite skipempty nextgroup=jsModuleAs,jsFrom,jsModuleComma containedin=jsModuleGroup
syntax match jsConstant                    /\<[A-Z][A-Z0-9_]\+\>/

syntax cluster jsExpression add=jsConstant,jsConstantClassName

syntax match   jsFunction                 /\<function\>/ skipwhite skipempty nextgroup=jsConstantClassName
syntax keyword jsStorageClass             const          skipwhite skipempty nextgroup=jsConstant,jsConstantClassName
syntax keyword jsImport                   import         skipwhite skipempty nextgroup=jsConstantClassName,jsModuleAsterisk,jsModuleKeyword,jsModuleGroup,jsFlowImportType
syntax match   jsExport                   export         skipwhite skipempty nextgroup=jsConstantClassName,@jsAll,jsModuleGroup,jsExportDefault,jsModuleAsterisk,jsModuleKeyword,jsFlowTypeStatement
syntax match   jsModuleAsterisk contained /\*/           skipwhite skipempty nextgroup=jsConstantClassName,jsModuleKeyword,jsModuleAs,jsFrom
syntax keyword jsModuleAs       contained as             skipwhite skipempty nextgroup=jsConstantClassName,jsModuleKeyword,jsExportDefaultGroup
syntax match   jsModuleComma    contained /,/            skipwhite skipempty nextgroup=jsConstantClassName,jsModuleKeyword,jsModuleAsterisk,jsModuleGroup,jsFlowTypeKeyword

hi def link jsConstant          Constant
hi def link jsConstantClassName Type
