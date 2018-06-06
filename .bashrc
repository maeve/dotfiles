[ -f /usr/local/etc/bash_completion ] && source /usr/local/etc/bash_completion

alias ll='ls -lahG'
alias g='git'
alias load_cms='/usr/local/bin/heroku pg:pull DATABASE_URL orion-cms -a '

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if [ ! -d $XDG_RUNTIME_DIR ]; then
  mkdir -p $XDG_RUNTIME_DIR
fi

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

# k8s cheats
kr() { kubectl -it exec $1 -- rails c; }
alias k.='kubectl config current-context'
alias kc='kubectl config use-context '
alias kp='kubectl get pods '
alias kj='kubectl get jobs '
alias kd='kubectl describe '
alias kg='kubectl get '
alias k='kubectl'

# I stab at thee, heroku gem
alias heroku=/usr/local/bin/heroku

# go cheats
alias gocov='go test -coverprofile=c.out && go tool cover -html=c.out'

alias runjet='jet steps --key-path=ci/codeship.aes --debug --ci-branch=v-jet-test --ci-commit-id=$(git rev-parse HEAD) --ci-committer-username=`whoami` --ci-repo-name=${PWD##*/} -e CI_NAME=codeship'

# my fingers are stupid sometimes
alias huge='hugo'

eval "$(rbenv init -)"
eval "$(direnv hook bash)"
