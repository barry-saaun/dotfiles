# ============================================
# Powerlevel10k instant prompt (MUST BE FIRST)
# ============================================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ============================================
# Oh-My-Zsh + Theme
# ============================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-autosuggestions web-search fzf)
source $ZSH/oh-my-zsh.sh

# Load p10k config
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# ============================================
# Environment Variables
# ============================================
[[ -f ~/.env ]] && source ~/.env
export EDITOR="nvim"
export BAT_THEME="Monokai Extended"
export PGDATA=/usr/local/var/postgres

# PATH setup (prepending safely)
for dir in \
  "$HOME/.jenv/bin" \
  "/opt/homebrew/bin" \
  "/opt/homebrew/lib/ruby/gems/3.3.0/bin" \
  "$(go env GOPATH)/bin" \
  "/opt/homebrew/opt/postgresql@17/bin" \
  "$HOME/.rvm/bin" \
  "$HOME/.modular/bin" \
  "$HOME/bin" \
  "$PNPM_HOME"
do
  [[ ":$PATH:" != *":$dir:"* ]] && PATH="$dir:$PATH"
done
export PATH

# ============================================
# Commands delayed until after prompt is ready
# ============================================
autoload -Uz add-zsh-hook
load_after_prompt() {
  emulate -L zsh
  
  # jenv (init prints stuff -> delay it)
  eval "$(jenv init -)"
  
  # set manpager (uses tput -> can trigger output)
  export COLUMNS
  export MANWIDTH=$COLUMNS
  export MANPAGER="sh -c 'col -bx | bat -l man --color=always -P --terminal-width $(tput cols)' | less -R"
}
add-zsh-hook precmd load_after_prompt

# ============================================
# Aliases
# ============================================
alias vim="nvim"
alias p3="python3"
alias ls="colorls"
alias ll="colorls -l"
alias gcm="git commit -m"
alias lstd="find . -mtime 0"
alias lzg="lazygit"
alias gd="git diff | bat --paging=never"
alias z="zoxide"

# ============================================
# Plugins that must load last
# ============================================
source $ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
