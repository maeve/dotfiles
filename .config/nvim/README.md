# Dotvim

This is my (neo)vim configuration. Insert obligatory Rifleman's Creed reference.

## Installation

**Note**: all of these steps will be automatically performed by `yadm bootstrap`.

For OS X using [homebrew](https://brew.sh/).

### Prerequisites

1. Install [neovim](https://github.com/neovim/neovim):

   ```bash
   brew install neovim
   ```

2. Install [ripgrep](https://github.com/BurntSushi/ripgrep):

   ```bash
   brew install ripgrep
   ```

3. Install [iterm2](https://www.iterm2.com):

   ```bash
   brew cask install iterm2
   ```

4. Install [highlight](http://www.andre-simon.de/doku/highlight/en/highlight.php):

   ```bash
   brew install highlight
   ```

5. Install [terraform-ls](https://github.com/hashicorp/terraform-ls):

   ```bash
   brew install hashicorp/tap/terraform-ls
   ```

6. There are a number of gems that are handy to have installed in every ruby
   version you are using. For [rbenv](https://github.com/rbenv/rbenv),
   add these to your `~/.rbenv/default-gems` file:

   ```text
   bundler
   neovim
   pry
   rubocop
   ```

7. Open `nvim` and run `:CheckHealth`. Do whatever it tells you to do. (mostly
   installing the neovim plugin into various runtimes)

### Fonts

1. Use one of the [nerd-fonts](https://github.com/ryanoasis/nerd-fonts) to get
   the powerline symbols:

   ```bash
   brew tap caskroom/fonts
   brew cask install font-hack-nerd-font
   ```

   To see the full list of patched fonts available:

   ```bash
   brew cask search nerd-font
   ```

2. Set the font in iterm2:

   1. Go to Preferences > Profiles > Text
   2. Click on Change Font and select the nerd-font you installed (e.g. hack)

### Colors

Set the colors in iterm2:

1. Go to Preferences > Profiles > Colors
2. Click on Color Presets > Import and import your theme
3. Click on Load Presets and select your theme

### Vim Configuration

1. Copy the contents of this directory into `~/config/nvim`
2. Open `nvim` and run `:PackerInstall`

## Plugins

In no particular order:

- General-purpose utility functions: [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
- Fuzzy finding: [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
  backed by [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim),
  extended with [telescope-file-browser.nvim](https://github.com/nvim-telescope/telescope-file-browser.nvim).
- Tree-based file browsing (convenient for exploring unfamiliar repos): [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)
- Change surrounding delimiters: [nvim-surround](https://github.com/kylechui/nvim-surround)
- Package manager for downloading third-party tooling: [mason.nvim](https://github.com/williamboman/mason.nvim)
  - Manage LSP servers: [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
  - Manage null-ls linters/formatters: [mason-null-ls.nvim](https://github.com/jayp0521/mason-null-ls.nvim)
  - Manage DAP servers: [mason-nvim-dap.nvim](https://github.com/jayp0521/mason-nvim-dap.nvim)
- Autocompletion: [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- Linting/formatting: [null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim)
- Debugging: [nvim-dap](https://github.com/mfussenegger/nvim-dap)
  - with a slick UI: [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)
  - and ruby/rspec support: [nvim-dap-ruby](https://github.com/suketa/nvim-dap-ruby)
- Pretty diagnostics and lists: [trouble.nvim](https://github.com/folke/trouble.nvim)
- Git:
  - [neogit](https://github.com/TimUntersberger/neogit)
  - [diffview.nvim](https://github.com/sindrets/diffview.nvim)
  - [git-blame.nvim](https://github.com/f-person/git-blame.nvim)
  - [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- Colors: [tokyonight.nvim](https://github.com/folke/tokyonight.nvim)
- Status line: [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
- Syntax highlighting: [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) extended with [nvim-treesitter-endwise](https://github.com/RRethy/nvim-treesitter-endwise) for automatically closing blocks
- Test management: [neotest](https://github.com/nvim-neotest/neotest)
  with:
  - [neotest-go](https://github.com/nvim-neotest/neotest-go)
  - [neotest-jest](https://github.com/haydenmeade/neotest-jest)
  - [neotest-rspec](https://github.com/olimorris/neotest-rspec)
  - [neotest-rust](https://github.com/rouge8/neotest-rust)
- Terminal manager:
  [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)
