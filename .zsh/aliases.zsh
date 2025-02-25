compdef g="git"
setopt complete_aliases

alias bgl="ops breakglass staging"
alias bgl-prod="ops breakglass production --role=Elevated-EngineeringRO"
alias ll="ls -lah"
alias tp="terraform plan -lock=false"

alias dcrails="docker compose exec web rails"
alias dcrubocop="docker compose exec web rubocop"
alias dcrspec="docker compose exec web rspec"
alias dcbundle="docker compose exec web bundle"
alias dcbash="docker compose exec web bash"
alias dcrake="docker compose exec web rake"
alias dclogin="ops docker login staging"
