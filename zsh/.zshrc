#
# History {{{1
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
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
export XCURSOR_PATH=${XCURSOR_PATH}:~/.local/share/icons
export PATH=$PATH:$HOME/.local/share/bin
export SUDO_PROMPT="$(tput setaf 1 bold)Password:$(tput sgr0) "

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
alias open="xdg-open"
alias susp="swaylock -f -c 000000 && systemctl suspend"
alias sudo='sudo '
alias sued='SUDO_EDITOR=nvim sudoedit'
alias cat='bat -pp'
alias tree="tree -Ca"
alias mkd="mkdir -p"
alias du="du -sh"
alias fh="feh -Fq --on-last-slide hold ."
alias scr='grim -g "$(slurp)"'
alias gitq='git add .; git commit -m "Update $(date +%F)"; git push'
alias gits='git status'
alias gitl='git --no-pager log --oneline --graph'
alias hday='pkill "hyprsunset"'
alias hnight='nohup hyprsunset -t 2700 > /dev/null 2>&1 &'

# fzf {{{1
source <(fzf --zsh)
export FZF_COMPLETION_OPTS='--border --info=inline'
export FZF_COMPLETION_PATH_OPTS='--walker file,dir,follow,hidden'
export FZF_COMPLETION_DIR_OPTS='--walker dir,follow'
_fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
}
_fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
}
_fzf_comprun() {
    local command=$1
    shift

    case "$command" in
    cd) fzf --preview 'tree -C {} | head -200' "$@" ;;
    export | unset) fzf --preview "eval 'echo \$'{}" "$@" ;;
    ssh) fzf --preview 'dig {}' "$@" ;;
    *) fzf --preview 'bat -n --color=always {}' "$@" ;;
    esac
}

# yazi {{{1
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# Starship {{{1
eval "$(starship init zsh)"

# zoxide {{{1
eval "$(zoxide init --cmd cd zsh)"

# bun {{{1
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$PATH:$BUN_INSTALL/bin"

# Environment varibles {{{1
if [ -d ~/.local-vars ]; then
    for f in ~/.local-vars/*; do
        set -a
        . "$f"
        set +a
    done
    unset f
fi
