Dotvim
======

This is my (neo)vim configuration. Insert obligatory Rifleman's Creed reference. Yadda yadda.

Primarily for Ruby and Go development.

Installation
------------

**Note**: all of these steps will be automatically performed by `yadm bootstrap`.

For OS X using [homebrew](https://brew.sh/).

### Prerequisites

1.	Install [neovim](https://github.com/neovim/neovim):

	```bash
	brew install neovim
	```

2.	Open `nvim` and run `:CheckHealth`. Do whatever it tells you to do. (mostly installing the neovim plugin into various runtimes)

3.	Install [vim-plug](https://github.com/junegunn/vim-plug):

	```bash
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	```

4.	Install [ripgrep](https://github.com/BurntSushi/ripgrep):

	```bash
	brew install ripgrep
	```

5.	Add the following to your .bashrc:

	```bash
	export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
	```

6.	Install [rust](https://rust-lang.org):

	```bash
	brew install rust
	```

7.	Install [iterm2](https://www.iterm2.com):

	```bash
	brew cask install iterm2
	```

8.	Install [highlight](http://www.andre-simon.de/doku/highlight/en/highlight.php):

	```bash
	brew install highlight
	```

9.	There are a number of gems that are handy to have installed in every ruby version you are using. For [rbenv](https://github.com/rbenv/rbenv), add these to your `~/.rbenv/default-gems` file:

	```text
	bundler
	neovim
	pry
	rubocop
	```

### Fonts

1.	Use one of the [nerd-fonts](https://github.com/ryanoasis/nerd-fonts) to get the powerline symbols:

	```bash
	brew tap caskroom/fonts
	brew cask install font-hack-nerd-font
	```

  To see the full list of patched fonts available:

	```bash
	brew cask search nerd-font
	```

2.	Set the font in iterm2:

	1.	Go to Preferences > Profiles > Text
	2.	Click on Change Font and select the nerd-font you installed (e.g. hack)

### Colors

1.	Clone the [base16-iterm2](https://github.com/chriskempson/base16-iterm2) color presets and [base16-shell](https://github.com/chriskempson/base16-shell) for 256 color support:

	```bash
	git clone https://github.com/chriskempson/base16-iterm2.git ~/.config/base16-iterm2
	git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
	```

2.	Set the colors in iterm2:

	1.	Go to Preferences > Profiles > Colors
	2.	Click on Color Presets > Import and import your theme
	3.	Click on Load Presets and select your theme

3.	To enable base16 color schemes in the 256 colorspace, add the following to your `.bashrc`:

```bash
  BASE16_SHELL=$HOME/.config/base16-shell/
  [ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
```

then start a new shell and run the script for your chosen scheme, for example:

```bash
  base16_tomorrow-night
```

### Vim Configuration

1.	Clone this repo into your neovim config location:

	```bash
	git clone git@github.com:maeve/dotvim.git ~/.config/nvim
	```

2.	Open `nvim` and run `:PlugInstall`

Plugins
-------

-	Fuzzy find: [fzf](https://github.com/junegunn/fzf) with [fzf.vim](https://github.com/junegunn/fzf.vim)
-	File explorer: [netrw](http://www.vim.org/scripts/script.php?script_id=1075) with [vim-vinegar](https://github.com/tpope/vim-vinegar)
-	Git: [vim-fugitive](https://github.com/tpope/vim-fugitive) with [vim-rhubarb](https://github.com/tpope/vim-rhubarb)
-	Rails: [vim-rails](https://github.com/tpope/vim-rails)
-	Color schemes: [base16-vim](https://github.com/chriskempson/base16-vim)
-	Linting: [ale](https://github.com/w0rp/ale)
-	Terminal goodies: [neoterm](https://github.com/kassio/neoterm)
-	Surroundings (quotes, parens, and more): [vim-surround](https://github.com/tpope/vim-surround)
-	Auto-close programming constructs: [vim-endwise](https://github.com/tpope/vim/endwise)
-	Auto-close paired punctuation: [auto-pairs](https://github.com/jiangmiao/auto-pairs)
-	Status line: [vim-airline](https://github.com/vim-airline/vim-airline) with [vim-airline-themes](https://github.com/vim-airline/vim-airline-themes)
-	Display git diff in gutter: [vim-gitgutter](https://github.com/airblade/vim-gitgutter)
-	Live markdown preview: [vim-markdown-composer](https://github.com/euclio/vim-markdown-composer)
-	Coffeescript: [vim-coffee-script](https://github.com/kchmck/vim-coffee-script)
-	Test support: [vim-test](https://github.com/janko-m/vim-test)
-	Liquid support: [vim-liquid](https://github.com/tpope/vim-liquid)
-	Vertically align code: [vim-easy-align](https://github.com/junegunn/vim-easy-align)
-	Buffer management: [bufexplorer](https://github.com/jlanzarotta/bufexplorer)
-	Killring/yank history: [nvim-miniyank](https://github.com/bfredl/nvim-miniyank)
-	Code comments: [vim-commentary](https://github.com/tpope/vim-commentary)
-	Readline syntax: [vim-rsi](https://github.com/tpope/vim-rsi)
-	Toggle between single/multi-line constructs: [splitjoin.vim](https://github.com/AndrewRadev/splitjoin.vim)
-	Python autocompletion: [jedi-vim](https://github.com/davidhalter/jedi-vim)
-	Base64 support: [vim-base64](https://github.com/christianrondeau/vim-base64)
-	Go: [vim-go](https://github.com/fatih/vim-go)
-	Paired mappings: [vim-unimpaired](https://github.com/tpope/vim-unimpaired)
-	Markdown formatter: [vim-markdownfmt](https://github.com/moorereason/vim-markdownfmt)
