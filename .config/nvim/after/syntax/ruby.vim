" make https://github.com/vim-ruby/vim-ruby look like github
syntax case match

syntax match rubyNonClassNameConstant  /\%(\%(^\|[^.]\)\.\s*\)\@<!\<[[A-Z][A-Z0-9_]*\>\%(\s*(\)\@!/
syntax match rubyDotOperator           /\.\|&\./ nextgroup=rubyMethodName

hi link rubyNonClassNameConstant  Constant
hi link rubyException             Function
hi link rubyMacro                 Function
hi link rubyAccess                Keyword
hi link rubyControl               Keyword
hi link rubyIdentifier            Constant
