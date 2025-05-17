# vim:foldmethod=marker
# History {{{1
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=1000000
setopt inc_append_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_verify

# Options {{{1
setopt autocd
setopt correct
unsetopt beep
bindkey -v
bindkey "\e[3~" delete-char
bindkey -M vicmd "\e[3~" delete-char

export VISUAL=nvim
export PATH=$PATH:$HOME/.local/share/bin
export SUDO_PROMPT="$(tput setaf 1 bold)Password:$(tput sgr0) "
export BAT_THEME="Monokai Extended"

zstyle :compinstall filename '$HOME/.zshrc'
autoload -Uz compinit
compinit

if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#757575'
fi

# Aliases {{{1
alias rm='rm -i'
alias mv='mv -i'
alias ll="ls --color -lh"
alias la="ls --color -lah"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias cl="clear"
alias sudo='sudo '
alias sued='SUDO_EDITOR=nvim sudoedit'
alias hgr="history 0 | grep"
alias cat='bat -pp'
alias vi='nvim'
alias tree="tree -Ca"
alias mkd="mkdir -p"
alias du="du -sh"
alias gitq='git add .; git commit -m "Update $(date +%F)"; git push'
alias gits='git status'
alias gitl='git --no-pager log --oneline --graph'

# fzf {{{1
source <(fzf --zsh)


# Starship {{{1
eval "$(starship init zsh)"

# zoxide {{{1
eval "$(zoxide init --cmd cd zsh)"

# yazi {{{1
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}
# Environment varibles {{{1
if [ -d ~/.local-vars ]; then
    for f in ~/.local-vars/*; do
        set -a
        . "$f"
        set +a
    done
    unset f
fi
