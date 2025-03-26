# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download zinit if not installed

if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"	
fi

#Change stupid time format
TIMEFMT=$'\n================\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E'

# Source/load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Initialize starship theme
eval "$(starship init zsh)"

# Add tree color
eval "$(dircolors -b)"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Bindings
function clearscreen() {
    clear
    zle redisplay
}
zle -N clearscreen

bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[^L' clearscreen

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Autoload completions
autoload -U compinit && compinit

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:*' fzf-preview '([[ -f $realpath ]] && batcat --style=numbers --color=always --line-range=:500 --pager=always $realpath || ([[ -d $realpath ]] && ls --color=always --group-directories-first -a $realpath) | less -R || echo $realpath)'
# Aliases
alias ls='ls --color'
alias sn='shutdown now'
alias lg='lazygit'
alias py=python3
alias bat='batcat'
alias time='/usr/bin/time'
alias brm='java -jar ~/BRModelo/brModelo.jar'
alias brm2='wine ~/BRModelo/brModelo-2.0-win32.exe'

# Shell integrations
export GPG_TTY=$(tty)
export GPG_TTY=$(tty)

eval "$(zoxide init --cmd cd zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# pnpm
export PNPM_HOME="/home/gabriel/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
