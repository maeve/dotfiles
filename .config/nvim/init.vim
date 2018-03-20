"
" Plugins (via vim-plug)
"
call plug#begin('~/.local/share/nvim/plugged')

" fuzzy find
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" :Rg - Start fzf with hidden preview window that can be enabled with ? key
" :Rg! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --ignore-case --no-ignore
  \     --hidden --follow --glob "!.git/*" --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" file explorer
Plug 'tpope/vim-vinegar'
let g:netrw_liststyle=0 " thin

" git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

Plug 'airblade/vim-gitgutter'

" linting
Plug 'neomake/neomake'
autocmd! BufWritePost * Neomake " run on every save

" ruby/rails development
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'

" colors
Plug 'chriskempson/base16-vim'

" terminal goodies
Plug 'kassio/neoterm'
let g:neoterm_repl_ruby = 'pry'

" change surroundings (brackets, parens, quotes, etc)
Plug 'tpope/vim-surround'

" toggle between different styles of ruby blocks ({} vs do/end)
Plug 'jgdavey/vim-blockle'

" auto-close code blocks
Plug 'tpope/vim-endwise'

" auto-close paired punctuation (brackets, parens, quotes)
Plug 'jiangmiao/auto-pairs'

" status line
Plug 'vim-airline/vim-airline'
let g:airline_powerline_fonts=1

" display buffer number in status line
let g:airline_section_c =
      \"%{bufnr('%')}: ".
      \"%<%f%m %#__accent_red#".
      \"%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#"

Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='base16'

" markdown live preview
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    !cargo build --release
  endif
endfunction

Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }

" coffeescript support
Plug 'kchmck/vim-coffee-script'

" testing support
Plug 'janko-m/vim-test'
let test#strategy = "neoterm" " execute test commands with neoterm

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

" python autocompletion
Plug 'davidhalter/jedi-vim'
let g:jedi#use_splits_not_buffers = 'left'

" base64 support
Plug 'christianrondeau/vim-base64'

" go
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
let g:go_fmt_command = 'goimports'

" paired mappings (e.g. cnext/cprevious)
Plug 'tpope/vim-unimpaired'

call plug#end()

"
" Global
"

" autoread filesystem changes
" (sort of, see https://github.com/neovim/neovim/issues/1936)
set autoread
au FocusGained * :checktime

" line numbers
set number " display in the left gutter
set numberwidth=3 " width of line number gutter

" include additional context when scrolling
set scrolloff=1

" wrapping
set textwidth=0 " disable automatic wrapping in insert mode
set nowrap " disable automatic wrapping in view mode

set visualbell " quiet please

" colors
set background=dark
if filereadable(expand('~/.vimrc_background'))
  let base16colorspace=256
  source ~/.vimrc_background
endif

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

" go
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
  autocmd FileType go nmap <leader>gt <Plug>(go-test)
  autocmd FileType go nmap <leader>gT <Plug>(go-test-func)
  autocmd FileType go nmap <leader>gc <Plug>(go-coverage-toggle)

  " rails.vim-inspired switch commands, stolen from vim-go docs
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
augroup END

"
" Bindings
"

" fuzzy find
noremap <leader><leader> :Files<cr>
noremap <leader>bb :Buffers<cr>
noremap <leader>cc :Commits<cr>

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
nnoremap <leader>ts :Ttoggle<cr>
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
nnoremap <leader>g :Gstatus<cr>

" testing
nnoremap <leader>r :TestNearest<cr>
nnoremap <leader>R :TestFile<cr>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" killring/yank history

" ignore shared clipboard and only paste from history in vim
map <leader>p <Plug>(miniyank-startput)
map <leader>P <Plug>(miniyank-startPut)

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
