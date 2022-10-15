require("plugins")
require("mappings")

vim.cmd([[colorscheme tokyonight]])

vim.cmd([[
set nocompatible

" Global {{{
" abandoned buffers are hidden instead of unloaded
" coc.nvim TextEdit might faili if hidden is not set
set hidden

" some language servers have issues with backup files
set nobackup
set nowritebackup

" more space for displaying messages from commands
set cmdheight=2

" tell vim to look for file-specific settings in a special comment
" at the beginning or end of each file
set modelines=1

" autoread filesystem changes
" (sort of, see https://github.com/neovim/neovim/issues/1936)
set autoread
au FocusGained * :checktime

" autosave before make
" (I am specifically NOT setting autowriteall because sometimes
" I like to be able to quit a buffer without saving)
set autowrite

" line numbers
set number " display in the left gutter
set numberwidth=3 " width of line number gutter

" include additional context when scrolling
set scrolloff=1

" wrapping
set wrap
set textwidth=79
set formatoptions=qrn1

set visualbell " quiet please

" colors {{{
set background=dark

" load generated base16 colorscheme
" if filereadable(expand('~/.vimrc_background'))
"   let base16colorspace=256
"   source ~/.vimrc_background
" endif

" override default highlighting for spelling errors to be readable
hi SpellBad ctermfg=0

" We have to configure plugin-specific highlight groups after vim-plug has
" already finished initializing
hi link ALEErrorSign ErrorMsg
hi link ALEInfoSign Question
hi ALEError cterm=undercurl ctermfg=1 ctermbg=0
hi ALEWarning cterm=undercurl ctermfg=3 ctermbg=0
hi ALEInfo cterm=undercurl ctermfg=4 ctermbg=0
"}}}

" show tab chars and trailing spaces
set listchars=tab:▷⋅,trail:·
set list

" tabs/indents should be 2 spaces
set tabstop=2 " render tab chars as two spaces
set softtabstop=2 " number of spaces that pressing tab counts for
set expandtab " only insert spaces, never tab chars
set shiftwidth=2 " indents (e.g. with '>') are two spaces

" make plugins like vim-gitgutter snappy
set updatetime=250 " ms after typing stops before writing swap file

" split windows
set splitbelow " open horizontal split below current window
set splitright " open vertical split to right of current window
set diffopt+=vertical " default diff to vertical split

" allow mouse interaction in all modes
set mouse=a

" shared clipboard
if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard

  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif

" go {{{
augroup golangstyle
  autocmd!
  autocmd FileType go set tabstop=2 shiftwidth=2 noexpandtab

  " run :GoBuild or :GoTestCompile based on the go file
  " ripped right out of https://github.com/fatih/vim-go-tutorial
  function! s:build_go_files()
    let l:file = expand('%')
    if l:file =~# '^\f\+_test\.go$'
      call go#test#Test(0, 1)
    elseif l:file =~# '^\f\+\.go$'
      call go#cmd#Build(0)
    endif
  endfunction

  autocmd FileType go nmap <leader>gb :<C-u>call <SID>build_go_files()<CR>
  autocmd FileType go nmap <leader>gr <Plug>(go-run)
  autocmd FileType go nmap <leader>gT <Plug>(go-test)
  autocmd FileType go nmap <leader>gt <Plug>(go-test-func)
  autocmd FileType go nmap <leader>gc <Plug>(go-coverage-toggle)

  " rails.vim-inspired switch commands, stolen from vim-go docs
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
augroup END
" }}}

" markdown {{{
augroup mdstyle
  autocmd FileType markdown nmap <leader>s :<C-u>call markdownfmt#Format()<CR>
  autocmd FileType markdown setlocal spell
augroup END
" }}}

" file-specific fold options
" vim:foldmethod=marker:foldlevel=0
]])
