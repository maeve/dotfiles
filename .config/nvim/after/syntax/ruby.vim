syntax case match

syntax match rubyNonIdentifierConstant  /\%(\%(^\|[^.]\)\.\s*\)\@<!\<[[A-Z][A-Z0-9_]*\>\%(\s*(\)\@!/

hi def link rubyNonIdentifierConstant Constant

