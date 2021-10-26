# Prefer brew-installed openssl over OS X
openssl_dir="/usr/local/opt/openssl@1.1"
#export PATH="$openssl_dir/bin:$PATH"
#export LIBRARY_PATH="$LIBRARY_PATH:$openssl_dir/lib"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$openssl_dir"
export ASDF_BUILD_VERSION='master'

# Local config
[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local

# Always prefer local binstubs over global command
export PATH=./bin:$PATH
