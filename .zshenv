system_type=$(uname -s)

if [ "$system_type" = "Darwin" ]; then
	# Prefer brew-installed openssl over OS X
	# openssl_dir="/opt/homebrew/opt/openssl@3"
	# export PATH="$openssl_dir/bin:$PATH"
	# export LIBRARY_PATH="$LIBRARY_PATH:$openssl_dir/lib"
	# export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$openssl_dir"
	# export LDFLAGS="-L/opt/homebrew/opt/libpq/lib"
	# export CPPFLAGS="-I/opt/homebrew/opt/libpq/include"
fi

export ASDF_BUILD_VERSION='master'
export ASDF_DATA_DIR="$HOME/.asdf"

export BUNDLER_PARALLELISM=10

. "$HOME/.cargo/env"
. "$ASDF_DATA_DIR/plugins/java/set-java-home.zsh"

# Local config
[[ -f "$HOME/.zshenv.local" ]] && source "$HOME/.zshenv.local"
