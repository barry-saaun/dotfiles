# Powerlevel10k instant prompt (must be first for snappy startup)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(git zsh-autosuggestions web-search fzf)
source $ZSH/oh-my-zsh.sh

# Load environment variables
[[ -f ~/.env ]] && source ~/.env

# Load p10k config
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# PATH setup (clean version)
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

# jenv init (only ONCE)
eval "$(jenv init -)"

# PostgreSQL
export PGDATA=/usr/local/var/postgres

# Editor
export EDITOR="nvim"

# bat cli theme
export BAT_THEME="Monokai Extended"

# manpages with bat
export COLUMNS
export MANWIDTH=$COLUMNS
export MANPAGER="sh -c 'col -bx | bat -l man --color=always -P --terminal-width $(tput cols)' | less -R"

# Aliases
alias vim="nvim"
alias p3="python3"
alias ls="colorls"
alias ll="colorls -l"
alias gcm="git commit -m"
alias lstd="find . -mtime 0"
alias lzg="lazygit"
alias gd="git diff | bat --paging=never"
alias z="zoxide"

# Load zsh-syntax-highlighting LAST
source $ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
