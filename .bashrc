alias ll='ls -lahG'

alias r='rails'
alias rs='bundle exec rspec'
alias be='bundle exec'

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

# my fingers are stupid sometimes
eval $(thefuck --alias)

eval "$(direnv hook bash)"

# Make shell prompt follow airline theme
source "$HOME/.promptline.sh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.bash.inc" ]; then . "$HOME/google-cloud-sdk/path.bash.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.bash.inc" ]; then . "$HOME/google-cloud-sdk/completion.bash.inc"; fi

# Use same pronto config as CI
alias ap='RUBOCOP_CONFIG=.rubocop_pronto.yml bundle exec pronto run -c origin/master --exit-code'

# Local integration webhook
alias ngrok-aha='ngrok http https://reallybigaha.ahalocalhost.com:3000 -subdomain maeve'

# Run unicorn for debugging
alias fm='bundle exec foreman start'
alias aha-web='OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES bundle exec unicorn -p 3000 -c ./config/unicorn_dev.rb'
alias aha-worker='OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES RESQUE_TERM_TIMEOUT=10 TERM_CHILD=1 VERBOSE=1 QUEUE=* bundle exec rake resque:work'
alias om='bundle exec overmind'
alias please='sudo'
alias thankyou='exit'
alias redshit='ops redshift'

# aws cheats
aws-mfa() { aws sts get-session-token --serial-number $AWS_MFA_ARN --token-code $1; }

# Set up asdf after everything else
. /usr/local/opt/asdf/asdf.sh
. /usr/local/opt/asdf/etc/bash_completion.d/asdf.bash

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
