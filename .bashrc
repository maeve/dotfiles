alias ll='ls -lahG'
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
kc() { kubectl -it exec $1 -- rails c; }
alias k.='kubectl config current-context'
alias ku='kubectl config use-context '
alias kp='kubectl get pods '
alias kd='kubectl describe '
alias k='kubectl'

# I stab at thee, heroku gem
alias heroku=/usr/local/bin/heroku

# go cheats
alias gocov='go test -coverprofile=c.out && go tool cover -html=c.out'
