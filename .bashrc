[ -f /usr/local/etc/bash_completion ] && source /usr/local/etc/bash_completion
source "$HOME/.git-completion.bash"

alias ll='ls -lahG'
alias g='git'
alias d='docker'
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
kb() { kubectl -it exec $1 -- /bin/bash; }
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

# TODO remove this when we're done with codeship
alias runjet='jet steps --key-path=ci/codeship.aes --debug --ci-branch=v-jet-test --ci-commit-id=$(git rev-parse HEAD) --ci-committer-username=`whoami` --ci-repo-name=${PWD##*/} -e CI_NAME=codeship'
alias cf='codefresh'

# my fingers are stupid sometimes
alias huge='hugo'

eval "$(rbenv init -)"
eval "$(direnv hook bash)"

# Make shell prompt follow airline theme
source "$HOME/.promptline.sh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.bash.inc" ]; then . "$HOME/google-cloud-sdk/path.bash.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.bash.inc" ]; then . "$HOME/google-cloud-sdk/completion.bash.inc"; fi

# Fast directory navigation - see https://github.com/wting/autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm

# Use same pronto config as CI
alias ap='RUBOCOP_CONFIG=.rubocop_pronto.yml bundle exec pronto run -c origin/master'
