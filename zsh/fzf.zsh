# Add fzf to PATH if missing
if [[ ":$PATH:" != *":/opt/homebrew/opt/fzf/bin:"* ]]; then
  PATH="/opt/homebrew/opt/fzf/bin${PATH:+":$PATH"}"
fi

# Set fd as the default source for fzf to skip node_modules and .next
# Note: fd automatically respects .gitignore, so explicit excludes are extra safety
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --exclude .git --exclude node_modules --exclude .next'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Safe fzf default options
export FZF_DEFAULT_OPTS='
  --height 100%
  --layout=reverse
  --border
  --preview "fzf-preview.sh {} 2>/dev/null || cat {}"
'

# Load fzf integration after zsh starts (no instant prompt interference)
autoload -Uz add-zsh-hook
add-zsh-hook precmd __load_fzf
__load_fzf() {
  [[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]] && \
    source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
  [[ -f /opt/homebrew/opt/fzf/shell/completion.zsh ]] && \
    source /opt/homebrew/opt/fzf/shell/completion.zsh
  add-zsh-hook -d precmd __load_fzf
}
