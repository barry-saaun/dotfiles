# Add fzf to PATH if missing
if [[ ":$PATH:" != *":/opt/homebrew/opt/fzf/bin:"* ]]; then
  PATH="/opt/homebrew/opt/fzf/bin${PATH:+":$PATH"}"
fi

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

