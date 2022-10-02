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

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'} }
    -- Optional requirements:
    -- ripgrep
  }

  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  }

  use {
    'nvim-telescope/telescope-file-browser.nvim',
    requires = { {'nvim-telescope/telescope.nvim'} },
    config = function()
      require('telescope').load_extension('file_browser')
    end
  }

  use {
    'kylechui/nvim-surround',
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require('nvim-surround').setup({})
    end
  }

  use {
    -- Install and configure these together so that we can ensure configuration
    -- load order
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup({
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
    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

