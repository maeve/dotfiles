#!/bin/bash

export PATH='./bin':$PATH:'/usr/local/opt/go/libexec/bin'
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export EDITOR='/usr/local/bin/nvim'
export OPENSSL_INCLUDE_DIR='/usr/local/opt/openssl/include'
export OPENSSL_LIBRARIES='/usr/local/opt/openssl/lib'
export XDG_RUNTIME_DIR=${TMPDIR}runtime-${USER}
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export SPRING_TMP_PATH='/tmp'

[ -f ~/.bash_secrets ] && source ~/.bash_secrets
[ -f ~/.bashrc ] && source ~/.bashrc
