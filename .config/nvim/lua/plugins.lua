vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- fuzzy find in various contexts, including file browsing
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
      },
      { 'nvim-telescope/telescope-file-browser.nvim' }
    },
    config = function()
      local telescope = require('telescope')
      local telescopeConfig = require('telescope.config')

      -- Clone the default Telescope configuration
      local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

      -- I want to search in hidden/dot files.
      table.insert(vimgrep_arguments, '--hidden')
      -- I don't want to search in the `.git` directory.
      table.insert(vimgrep_arguments, '--glob')
      table.insert(vimgrep_arguments, '!.git/*')

      telescope.setup({
        defaults = {
          vimgrep_arguments = vimgrep_arguments
        },
        extensions = {
          file_browser = {
            cwd_to_path = true
          }
        },
        pickers = {
          find_files = {
            find_command = { 'rg', '--files', '--hidden', '--glob', '!.git/*' }
          }
        }
      })
      telescope.load_extension('file_browser')
    end
  }

  -- change surrounding delimiters (e.g. changing "" to '')
  use {
    'kylechui/nvim-surround',
    tag = 'v1.0.0',
    config = function()
      require('nvim-surround').setup()
    end
  }

  use {
    branch = 'coq',
    requires = {
      { 'ms-jpq/coq.artifacts', branch = 'artifacts' },
      { 'ms-jpq/coq.thirdparty', branch = '3p' }
    },
    config = function()
      require('coq')
    end
  }

  -- autocompletion and snippets
  use {
    'williamboman/mason-lspconfig.nvim',
    requires = {
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
      { 'ms-jpq/coq_nvim', branch = 'coq' },
      { 'ms-jpq/coq.artifacts', branch = 'artifacts' },
      { 'ms-jpq/coq.thirdparty', branch = '3p' }
    },
    config = function()
      vim.g.coq_settings = { auto_start = 'shut-up' }
      local coq = require('coq')

      require('mason').setup()
      require('mason-lspconfig').setup(
        coq.lsp_ensure_capabilities({
          ensure_installed = {
            'bashls',
            'clangd',
            'cssls',
            'dockerls',
            'gopls',
            'graphql',
            'html',
            'jsonls',
            'jdtls',
            'tsserver',
            'sumneko_lua',
            'marksman',
            'solargraph',
            'rust_analyzer',
            'sqlls',
            'terraformls',
            'vimls',
            'yamlls'
          },
          automatic_installation = true
        })
      )
    end
  }

  -- git client
  use {
    'TimUntersberger/neogit',
    requires = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim'
    },
    config = function()
      require('neogit').setup({
        kind = 'split',
        integrations = {
          diffview = true
        },
      })
    end
  }

  -- git blame
  use {
    'f-person/git-blame.nvim',
    config = function()
      vim.g.gitblame_enabled = 0
      require('gitblame')
    end
  }

  -- git gutter signs (also inline blame but seems slower than git-blame)
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        yadm = {
          enable = true
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, {expr=true})

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, {expr=true})

          -- Actions
          map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
          map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
          map('n', '<leader>hS', gs.stage_buffer)
          map('n', '<leader>hu', gs.undo_stage_hunk)
          map('n', '<leader>hR', gs.reset_buffer)
          map('n', '<leader>hp', gs.preview_hunk)
          map('n', '<leader>hb', function() gs.blame_line{full=true} end)
          map('n', '<leader>tb', gs.toggle_current_line_blame)
          map('n', '<leader>hd', gs.diffthis)
          map('n', '<leader>hD', function() gs.diffthis('~') end)
          map('n', '<leader>td', gs.toggle_deleted)

          -- Text object
          map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
      })
    end
  }

  -- Colors
  use {
    'folke/tokyonight.nvim',
    config = function()
      require('tokyonight').setup({
        style = 'storm'
      })
    end
  }

  -- viml plugins where I couldn't find a lua alternative

  -- transform various constructs from one-line to multi-line
  -- in a variety of programming languages
  use { 'AndrewRadev/splitjoin.vim' }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

