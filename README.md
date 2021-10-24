# maeve's dotfiles

Managed with [yadm](https://thelocehiliosan.github.io/yadm/).

For more information, see the [vim config README](.config/nvim/README.md).

## Installation

1. Install Xcode command lint tools:

```console
xcode-select --install
```

2. Install [homebrew](https://brew.sh/):

```console
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

3. Install [yadm](https://yadm.io/):

```console
brew install yadm
```

4. Clone the repository locally:

```console
yadm clone https://github.com/maeve/dotfiles.git
```

5. Bootstrap your environment:

```console
yadm bootstrap
```

6. Edit `~/.zshenv.local` to add environment variables with sensitive credentials.

7. Restart your shell.
