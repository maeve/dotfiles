# maeve's dotfiles

Managed with [yadm](https://thelocehiliosan.github.io/yadm/).

For more information, see the [vim config README](.config/nvim/README.md).

## Installation

1. Install Xcode command line tools:

```console
xcode-select --install
```

1. Install [homebrew](https://brew.sh/)

1. Install [yadm](https://yadm.io/):

```console
brew install yadm
```

1. Clone the repository locally:

```console
cd ~
yadm clone https://github.com/maeve/dotfiles.git
```

1. Bootstrap your environment:

```console
yadm bootstrap
```

1. Edit `~/.zshenv.local` to add environment variables with sensitive credentials.

1. Restart your shell.
