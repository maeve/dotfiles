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

Plugins are managed with [lazy.nvim](https://github.com/folke/lazy.nvim).
