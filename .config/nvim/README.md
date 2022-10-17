Dotvim
======

This is my (neo)vim configuration. Insert obligatory Rifleman's Creed reference.

Installation
------------

**Note**: all of these steps will be automatically performed by `yadm bootstrap`.

For OS X using [homebrew](https://brew.sh/).

### Prerequisites

1.	Install [neovim](https://github.com/neovim/neovim):

	```bash
	brew install neovim
	```

2.	Install [ripgrep](https://github.com/BurntSushi/ripgrep):

	```bash
	brew install ripgrep
	```

5.	Install [iterm2](https://www.iterm2.com):

	```bash
	brew cask install iterm2
	```

6.	Install [highlight](http://www.andre-simon.de/doku/highlight/en/highlight.php):

	```bash
	brew install highlight
	```

7.	Install [terraform-ls](https://github.com/hashicorp/terraform-ls):

	```bash
	brew install hashicorp/tap/terraform-ls
	```

8.	There are a number of gems that are handy to have installed in every ruby version you are using. For [rbenv](https://github.com/rbenv/rbenv), add these to your `~/.rbenv/default-gems` file:

	```text
	bundler
	neovim
	pry
	rubocop
	```

9.	Open `nvim` and run `:CheckHealth`. Do whatever it tells you to do. (mostly installing the neovim plugin into various runtimes)

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

1.	Copy the contents of this directory into `~/config/nvim`
2.	Open `nvim` and run `:PackerInstall`

Plugins
-------

- Fuzzy finding: [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) backed by [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim), extended with [telescope-file-browser.nvim](https://github.com/nvim-telescope/telescope-file-browser.nvim).
- Tree-based file browsing (convenient for exploring unfamiliar repos): [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)
