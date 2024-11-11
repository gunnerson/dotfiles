HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000

setopt autocd
setopt correct
setopt inc_append_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_verify
unsetopt beep
bindkey -v

WORDCHARS=${WORDCHARS//\/}

zstyle :compinstall filename '$HOME/.zshrc'
autoload -Uz compinit
compinit

if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#757575'
fi

alias ll="ls -lh"
alias la="ls -lah"
alias hgr="history 0 | grep"
alias v='nvim'
alias z='zellij'
alias tr="tree -Ca"
alias mkd="mkdir -p"
alias du="du -sh"
alias wgup='nordvpn d && sudo wg-quick up wg0'
alias wgdn='sudo wg-quick down wg0 && nordvpn c'

# . /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

for f in ~/.local-vars/* ; do
  set -a
  . "$f"
  set +a
done
unset f

. <(fzf --zsh)

eval "$(starship init zsh)"

# if [ "$(tty)" = "/dev/tty1" ];then
#   exec startx
# fi
