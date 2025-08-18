compdef g="git"
setopt complete_aliases

alias bgl="ops breakglass staging"
alias bgl-prod="ops breakglass production --role=Elevated-EngineeringRO"

alias dcattach="docker compose attach"
alias dcbash="docker compose exec web bash"
alias dcbundle="docker compose exec web bundle"
alias dclogin="ops docker login staging"
alias dcrails="docker compose exec web rails"
alias dcrake="docker compose exec web rake"
alias dcrubocop="docker compose exec web rubocop"
alias dcrspec="docker compose exec web rspec"

alias ll="ls -lah"
alias mitm="mitmweb --mode regular@8082 --ssl-insecure --quiet"
alias tp="terraform plan -lock=false"

