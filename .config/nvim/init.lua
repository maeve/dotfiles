require('plugins')
require('mappings')

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

" git {{{

" local git goodness
Plug 'tpope/vim-fugitive'

" github support
Plug 'tpope/vim-rhubarb'

" show git diff +/- in the sign column
Plug 'airblade/vim-gitgutter'

"}}}

" linting {{{
Plug 'w0rp/ale'

" integrate it into the status bar
let g:airline#extensions#ale#enabled = 1

" autofix js and css
let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'css': ['prettier'],
\   'rust': ['rustfmt'],
\}
let g:ale_fix_on_save = 1

" use signs from neomake
let g:ale_sign_error="✖"
let g:ale_sign_warning="⚠"
let g:ale_sign_info="ℹ"
" }}}

" ruby/rails {{{
Plug 'tpope/vim-rails'

Plug 'vim-ruby/vim-ruby'
let g:ruby_operators = 1
" }}}

" terminal goodies {{{
Plug 'kassio/neoterm'
let g:neoterm_repl_ruby = 'pry'
let g:neoterm_default_mod = ':botright'
" }}}

" status line {{{
Plug 'vim-airline/vim-airline'
let g:airline_powerline_fonts=1

" display buffer number in status line
let g:airline_section_c =
      \"%{bufnr('%')}: ".
      \"%<%f%m %#__accent_red#".
      \"%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#"

Plug 'vim-airline/vim-airline-themes'
" let g:airline_theme='base16'

" for a shell prompt based on the vim airline theme
function! SetPromptlinePreset(info)
  " we have to define this via a function to ensure that it will only be
  " executed after the plugin has already been installed
endfunction

Plug 'edkolev/promptline.vim', { 'do': function('SetPromptlinePreset') }
let g:promptline_theme = 'airline'
let g:promptline_powerline_symbols = 1

" enable promptline extension for airline - this will automatically
" save a snapshot whenever the airline config changes
let g:airline#extensions#promptline#enabled = 1
let g:airline#extensions#promptline#snapshot_file = '~/.promptline.sh'
"}}}

" markdown formatting {{{
Plug 'moorereason/vim-markdownfmt'
" use mdfmt with support for front matter
let g:markdownfmt_command = 'mdfmt'
" }}}

" testing support {{{
Plug 'janko-m/vim-test'

function! DockerComposeStrategy(cmd)
  let docker_cmd = 'docker compose exec web ' . a:cmd
  call test#strategy#neovim(docker_cmd)
endfunction

let g:test#custom_strategies = {'docker-compose': function('DockerComposeStrategy')}

" hacky af but it'll do for now
if getcwd() == '/Users/maeve/projects/aha/aha-app'
  let test#strategy = 'docker-compose'
else
  let test#strategy = 'neovim'
endif
"}}}

" python {{{
" autocompletion
Plug 'davidhalter/jedi-vim'
let g:jedi#use_splits_not_buffers = 'left'
" }}}

" go {{{
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

" manage my imports for me
let g:go_fmt_command = 'goimports'
" }}}

" syntax highlighting {{{
" hilite all the languages automatically
Plug 'sheerun/vim-polyglot'

" trace hi links (used for debugging vim colorschemes)
Plug 'gerw/vim-HiLinkTrace'
" }}}

" terraform {{{
Plug 'hashivim/vim-terraform'
let g:terraform_fmt_on_save=1
let g:terraform_align=1
" }}}

" colors
" Plug 'maeve/base16-vim', { 'branch': 'prettylights' }

" auto-close code blocks
Plug 'tpope/vim-endwise'

" auto-close paired punctuation (brackets, parens, quotes)
Plug 'jiangmiao/auto-pairs'

" coffeescript support
Plug 'kchmck/vim-coffee-script'

" syntax highlighting for liquid templates
Plug 'tpope/vim-liquid'

" vertical alignment on things like = signs
Plug 'junegunn/vim-easy-align'

" buffer management
Plug 'jlanzarotta/bufexplorer'

" killring/yank history
Plug 'bfredl/nvim-miniyank'

" code comments
Plug 'tpope/vim-commentary'

" readline style insertion
Plug 'tpope/vim-rsi'

" base64 support
Plug 'christianrondeau/vim-base64'

" paired mappings (e.g. cnext/cprevious)
Plug 'tpope/vim-unimpaired'

" transform various constructs from one-line to multi-line
" in a variety of programming languages
Plug 'AndrewRadev/splitjoin.vim'

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

" promptline {{{
" must be set after plug#end() is called
let g:promptline_preset = {
  \'a' : [ promptline#slices#host({ 'only_if_ssh': 1 }), '\w' ],
  \'b' : [ promptline#slices#vcs_branch() ],
  \'c' : [ promptline#slices#git_status() ],
  \'warn' : [ promptline#slices#last_exit_code() ]}
" }}}

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

" terminal

" exit terminal mode
tnoremap <esc> <c-\><c-n>
" show/hide last open terminal
nnoremap <leader>ts :botright Ttoggle<cr>
" clear terminal
nnoremap <leader>tk :call neoterm#clear()<cr>
" kills the current job (send a <c-c>)
nnoremap <leader>tq :call neoterm#kill()<cr>
" repl support
nnoremap <leader>tE :TREPLSendFile<cr>
nnoremap <leader>te :TREPLSendLine<cr>
vnoremap <leader>te :TREPLSendSelection<cr>

" remove trailing spaces
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<cr>

" git status
nnoremap <leader>g :Git<cr>

" linting
nnoremap <leader>p :T bundle exec pronto run -c origin/master<cr>

" testing
nnoremap <leader>r :TestNearest<cr>
nnoremap <leader>R :TestFile<cr>

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

" coc
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
"inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" }}}

" file-specific fold options
" vim:foldmethod=marker:foldlevel=0
]])
