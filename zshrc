if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"



plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search git fzf)

source $ZSH/oh-my-zsh.sh

if [ -f ~/.env ]; then
  source ~/.env
fi


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# add brew to PATH
export PATH=/opt/homebrew/bin:$PATH

alias vim="nvim"
alias p3="python3"
alias ls="colorls"
alias ll="colorls -l"
alias gcm="git commit -m"
# ls the file that is added or modified wihtin the last 24 hours
alias lstd="find . -mtime 0"
alias lzg="lazygit"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Add ruby to PATH
export PATH="/opt/homebrew/lib/ruby/gems/3.3.0/bin:$PATH"
export PATH=$(go env GOPATH)/bin:$PATH

# Add relevant postgresql path
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"
export PGDATA=/usr/local/var/postgres

# pnpm
export PNPM_HOME="/Users/barry/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export EDITOR="nvim"

# bat cli ZSH_THEME
export BAT_THEME="Monokai Extended"

# manual page config
export COLUMNS
export MANWIDTH=$COLUMNS
export MANPAGER="sh -c 'col -bx | bat -l man --color=always -P --terminal-width $(tput cols)' | less -R"

alias gd="git diff | bat --paging=never"

export PATH="$PATH:/Users/barry/.modular/bin"
