require("plugins")
require("mappings")

-- Abandoned buffers are hidden instead of unloaded
vim.o.hidden = true

-- some language servers have issues with backup files
vim.o.backup = false
vim.o.writebackup = false

-- more space for displaying messages from commands
vim.o.cmdheight = 2

-- tell vim to look for file-specific settings in a special comment
-- at the beginning or end of each file
vim.o.modelines = 1

-- auto-reload files when modified externally
-- https://unix.stackexchange.com/a/383044
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
	command = "if mode() != 'c' | checktime | endif",
	pattern = { "*" },
})

-- autosave before make
vim.o.autowrite = true
-- do not autosave before quit
vim.o.autowriteall = true

-- line numbers
vim.o.number = true
vim.o.numberwidth = 3

-- include additional context when scrolling
vim.o.scrolloff = 1

-- wrapping
vim.o.wrap = true
vim.o.textwidth = 79
vim.opt.formatoptions:append("qrn1")

-- quiet please
vim.o.visuabell = true

-- dark mode
vim.o.background = "dark"

-- There's no good lua equivalent for this
vim.cmd([[colorscheme tokyonight]])

-- show tab chars and trailing spaces
vim.opt.listchars.tab = "▷⋅"
vim.opt.listchars.trail = "·"
vim.opt.list = true

-- tabs/indents should be 2 spaces
vim.o.tabstop = 2 -- render tab chars as two spaces
vim.o.softtabstop = 2 -- number of spaces that pressing tab counts for
vim.o.expandtab = ture -- only insert spaces, never tab chars
vim.o.shiftwidth = 2 -- indents (e.g. with '>') are two spaces

-- ms after typing stops before writing swap file
vim.o.updatetime = 250

-- split window behavior
vim.opt.splitbelow = true -- open horizontal split below current window
vim.opt.splitright = true -- open vertical split to right of current window
vim.opt.diffopt:append("vertical") -- default diff to vertical split

-- allow mouse interaction in all modes
vim.o.mouse = "a"

vim.cmd([[
" Global {{{

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
