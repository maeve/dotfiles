# maeve's dotfiles

Managed with [yadm](https://thelocehiliosan.github.io/yadm/).

For more information, see the [vim config README](.config/nvim/README.md).

## Installation

To install yadm and bootstrap the dotfiles in one fell swoop:

```console
curl -fsSL 'https://github.com/TheLocehiliosan/yadm/raw/master/bootstrap' | bash -s -- https://github.com/maeve/dotfiles
```

You'll have to copy over your `~/.ssh` files separately, as well as creating a
`~/.bash_secrets` file that exports any environment variables containing
sensitive credentials.
