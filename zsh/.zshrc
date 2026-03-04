# zmodload zsh/zprof
# 1. Zinit Setup
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# 2. Performance: Lazy Load NVM
# This replaces your manual NVM export. It only loads nvm when you actually use it.
zinit ice wait"1" lucid
zinit light lukechilds/zsh-nvm

# 3. Core Plugins
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# 4. Theme (Starship) - Load as a binary to be faster
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

# 5. Environment & History
TIMEFMT=$'\n================\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E'
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups hist_save_no_dups hist_ignore_dups hist_find_no_dups

# 6. Completions (The Speed Fix)
fpath=(~/.config/zsh/completions $fpath)

autoload -Uz compinit
# Enable extended globbing locally for the timestamp check
setopt localoptions extendedglob

# Define the location of the dump file explicitly
zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"

# Check if the dump file exists and is less than 20 hours old
if [[ -n "$zcompdump"(#qN.mh-20) ]]; then
  # Fast Path:
  # 1. Load completions without checking for new files (-C)
  # 2. Skip the slow security check (compaudit) is skipped by -C automatically
  compinit -C
else
  # Slow Path (Rebuild):
  # Runs once every 20 hours to find new installations
  compinit
  # Touch the file to ensure the timestamp is updated
  touch "$zcompdump"
fi

# Compile the dump file to bytecode for even faster loading (optional, but good)
if [[ ! "$zcompdump.zwc" -nt "$zcompdump" ]]; then
  zcompile "$zcompdump"
fi

# Completion Styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:*' fzf-preview '([[ -f $realpath ]] && batcat --style=numbers --color=always --line-range=:500 --pager=always $realpath || ([[ -d $realpath ]] && ls --color=always --group-directories-first -a $realpath) | less -R || echo $realpath)'

# 7. Bindings
function clearscreen() { 
    clear
    if [[ -n "$TMUX" ]]; then
        tmux clear-history
    fi
    zle redisplay
}
zle -N clearscreen
stty -ixon
bindkey '^R' history-incremental-search-backward
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[^L' clearscreen
bindkey '^Q' push-line
bindkey -M viins "^[[1;5D" backward-word
bindkey -M vicmd "^[[1;5D" backward-word
bindkey -M viins "^[[1;5C" forward-word
bindkey -M vicmd "^[[1;5C" forward-word
bindkey -M viins '\e.' insert-last-word
bindkey -M vicmd '\e.' insert-last-word
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^Xe" edit-command-line

# 8. Aliases & Env
alias ls='ls --color'
alias sn='shutdown now'
alias lg='lazygit'
alias py=python3
alias bat='batcat'
alias time='/usr/bin/time'
alias brm='java -jar ~/BRModelo/brModelo.jar'
alias brm2='wine ~/BRModelo/brModelo-2.0-win32.exe'
alias y=yazi
alias sqldeveloper="sh ~/Documents/sqldeveloper/sqldeveloper.sh &"
alias lsb='ls -lah --color=never | bat -p -l conf --pager never'
alias man='batman'
alias ssh='kitty +kitten ssh'

export EDITOR=nvim
export GPG_TTY=$(tty)
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$HOME/.dotnet:$HOME/.dotnet/tools
export PATH="/home/gabriel/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="/home/gabriel/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"

# pnpm
export PNPM_HOME="/home/gabriel/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Load User Scripts
. "$HOME/.local/bin/env"

# Zoxide (Fast Jump)
eval "$(zoxide init --cmd cd zsh)"
eval "$(uv generate-shell-completion zsh)"
# 9. Syntax Highlighting (Must be last)
zinit light zsh-users/zsh-syntax-highlighting
# zprof
