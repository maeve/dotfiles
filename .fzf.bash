# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/maeve/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/Users/maeve/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/maeve/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/Users/maeve/.fzf/shell/key-bindings.bash"
