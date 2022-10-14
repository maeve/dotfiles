require("plugins")
require("mappings")

vim.cmd([[colorscheme tokyonight]])

vim.cmd([[
set nocompatible

" Plugins {{{

" Install vim-plug {{{
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" }}}

call plug#begin('~/.local/share/nvim/plugged')

" Install missing plugins on startup {{{
if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
  autocmd VimEnter * PlugInstall | q
endif
" }}}

" killring/yank history
Plug 'bfredl/nvim-miniyank'

" code comments
Plug 'tpope/vim-commentary'

" readline style insertion
Plug 'tpope/vim-rsi'

" paired mappings (e.g. cnext/cprevious)
Plug 'tpope/vim-unimpaired'

call plug#end()

" }}}

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

" leaders
let mapleader=","
let maplocalleader="\\"
"}}}

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

" Bindings {{{

" split window navigation
nnoremap <leader>h <c-w>h
nnoremap <leader>j <c-w>j
nnoremap <leader>k <c-w>k
nnoremap <leader>l <c-w>l

tnoremap <leader>h <c-\><c-n><c-w>h
tnoremap <leader>j <c-\><c-n><c-w>j
tnoremap <leader>k <c-\><c-n><c-w>k
tnoremap <leader>l <c-\><c-n><c-w>l

" Home row navigation in terminal mode
tnoremap <c-h> <left>
tnoremap <c-j> <down>
tnoremap <c-k> <up>
tnoremap <c-l> <down>

nnoremap <leader>x :sp<cr>
nnoremap <leader>v :vsp<cr>

" file explorer
noremap <leader>ff :e.<cr>
nmap <leader>fx <Plug>VinegarSplitUp
nmap <leader>fv <Plug>VinegarVerticalSplitUp

" remove trailing spaces
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<cr>

" linting
nnoremap <leader>p :T bundle exec pronto run -c origin/master<cr>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" killring/yank history

" ignore shared clipboard and only paste from history in vim
"map <leader>p <Plug>(miniyank-startput)
"map <leader>P <Plug>(miniyank-startPut)

" first paste from shared clipboard, and then you can cycle back
" into vim history
map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)

" cycle backwards through yank history
map <leader>n <Plug>(miniyank-cycle)

" Diff shortcuts
nnoremap <leader>dg :diffget<cr>
nnoremap <leader>dp :diffput<cr>

" shortcuts for :Gdiff 3-way merge
nnoremap <leader>d2 :diffget //2<cr>
nnoremap <leader>d3 :diffget //3<cr>

" list nav
nnoremap <leader>qq :cclose<cr>
nnoremap <leader>ql :lclose<cr>

" no arrow keys
noremap <left> <nop>
noremap <down> <nop>
noremap <up> <nop>
noremap <right> <nop>

" no home row navigation
" noremap h <nop>
" noremap j <nop>
" noremap k <nop>
" noremap l <nop>

" cycle to next/previous ALE warning/error
nnoremap ]r :ALENextWrap<CR>
nnoremap [r :ALEPreviousWrap<CR>

" pretty print json
nnoremap <leader>jq :%!jq .<cr>

" }}}

" file-specific fold options
" vim:foldmethod=marker:foldlevel=0
]])
