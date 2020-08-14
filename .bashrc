[ -f /usr/local/etc/bash_completion ] && source /usr/local/etc/bash_completion
source "$HOME/.git-completion.bash"

alias ll='ls -lahG'
alias g='git'
alias d='docker'

alias r='rails'
alias rs='bundle exec rspec'
alias be='bundle exec'

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
eval $(thefuck --alias)

# eval "$(rbenv init -)"
eval "$(direnv hook bash)"

# Make shell prompt follow airline theme
source "$HOME/.promptline.sh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.bash.inc" ]; then . "$HOME/google-cloud-sdk/path.bash.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.bash.inc" ]; then . "$HOME/google-cloud-sdk/completion.bash.inc"; fi

# Fast directory navigation - see https://github.com/wting/autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# export NVM_DIR="$HOME/.nvm"
# [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm

# Use same pronto config as CI
alias ap='RUBOCOP_CONFIG=.rubocop_pronto.yml bundle exec pronto run -c origin/master --exit-code'

# Local integration webhook
alias ngrok-http='ngrok http reallybigaha.lvh.me:3000 -subdomain maeve'
alias ngrok-ssl='ngrok tls -region=us -hostname reallybigaha.betteroff.dev -key /etc/letsencrypt/live/betteroff.dev/privkey.pem -crt /etc/letsencrypt/live/betteroff.dev/fullchain.pem reallybigaha.lvh.me:3000'

# Run unicorn for debugging
alias fm='bundle exec foreman start'
alias aha-web='OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES bundle exec unicorn -p 3000 -c ./config/unicorn_dev.rb'
alias aha-worker='OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES RESQUE_TERM_TIMEOUT=10 TERM_CHILD=1 VERBOSE=1 QUEUE=* bundle exec rake resque:work'
alias om='bundle exec overmind start'
alias please='sudo'
alias thankyou='exit'
alias redshit='ops redshift'

# Set up asdf after everything else
. /usr/local/opt/asdf/asdf.sh
. /usr/local/opt/asdf/etc/bash_completion.d/asdf.bash
