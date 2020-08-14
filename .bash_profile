#!/bin/bash

export PATH=$PATH:'/usr/local/opt/go/libexec/bin':"$HOME/projects/github/rerun"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH="$HOME/.cargo/bin:$PATH"
export EDITOR='/usr/local/bin/nvim'
export OPENSSL_INCLUDE_DIR='/usr/local/opt/openssl/include'
export OPENSSL_LIBRARIES='/usr/local/opt/openssl/lib'
export XDG_RUNTIME_DIR=${TMPDIR}runtime-${USER}
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export SPRING_TMP_PATH='/tmp'
export KOPS_MFA_ARN='arn:aws:iam::459931222334:mfa/maeve.revels'

[ -f ~/.bash_secrets ] && source ~/.bash_secrets
[ -f ~/.bashrc ] && source ~/.bashrc

# Keep this at the end so that ./bin always takes precedence over anything
# .bashrc may have added to the PATH (e.g. rbenv shims)
export PATH='./bin':$PATH
