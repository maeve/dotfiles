syntax keyword vimEndif endif

syntax match vimVarScope /\<[bwglstav]:\%(\h[a-zA-Z0-9#_]*\>\)\@=/ nextgroup=vimVarName
syntax match vimVarName /\%(\<[bwglstav]:\)\@<=\h[a-zA-Z0-9#_]*\>/
syntax match vimVarScope contained /\<[bwglstav]:\%(\h[a-zA-Z0-9#_]*\>\)\@=/ nextgroup=vimVarName
syntax match vimVarName contained /\%(\<[bwglstav]:\)\@<=\h[a-zA-Z0-9#_]*\>/

syntax keyword vimLet let unl[et] skipwhite nextgroup=vimVarScope,vimVar,vimFuncVar

hi def link vimEndif Keyword
hi def link vimVarScope Keyword
hi def link vimVarName Normal

hi link vimNotFunc        Keyword
hi link vimOper           Keyword
hi link vimLet            Keyword
hi link vimCommand        Constant
hi link vimNotation       Constant
hi link vimBracket        Constant
hi link vimVarScope       Keyword
hi link vimSynType        Constant
hi link vimSynOption      Constant
hi link vimSynKeyRegion   Keyword
hi link vimGroupList      String
hi link vimUserFunc       Function
