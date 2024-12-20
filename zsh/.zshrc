HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=100000

setopt autocd
setopt correct
setopt inc_append_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_verify
unsetopt beep
bindkey -v
bindkey -a '^[[3~' delete-char

export VISUAL=nvim
export XCURSOR_PATH=${XCURSOR_PATH}:~/.local/share/icons
export PATH=$PATH:$HOME/.local/share/bin

zstyle :compinstall filename '$HOME/.zshrc'
autoload -Uz compinit
compinit

if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#757575'
fi

alias rm='rm -i'
alias mv='mv -i'
alias ll="ls --color -lh"
alias la="ls --color -lah"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias cl="clear"
alias hgr="history 0 | grep"
alias bat='bat -p'
alias cat='bat --paging=never -p'
alias vi='nvim'
alias z='zellij'
alias zl="zellij --layout"
alias za="zellij attach"
alias tree="tree -Ca"
alias mkd="mkdir -p"
alias du="du -sh"
alias fh="feh -Fq --on-last-slide hold ."
alias Y='yazi'
alias bm='bashmount'
alias wgup='nordvpn d && sudo wg-quick up wg0'
alias wgdn='sudo wg-quick down wg0'
alias gitq='git add -u; git commit -m "Update $(date +%F)"; git push'
alias gits='git status'

# Set environment varibles
for f in /home/rumata/.local-vars/* ; do
  set -a
  . "$f"
  set +a
done
unset f

# fzf
. <(fzf --zsh)

# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
	builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Starship
eval "$(starship init zsh)"

# X11 autostart
# if [ "$(tty)" = "/dev/tty1" ];then
#   exec startx
# fi

# bun 
[ -s "/home/rumata/.bun/_bun" ] && source "/home/rumata/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$PATH:$BUN_INSTALL/bin"
