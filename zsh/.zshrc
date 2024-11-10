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

source <(fzf --zsh)

zstyle :compinstall filename '$HOME/.zshrc'
autoload -Uz compinit
compinit

alias ll="ls -lh"
alias la="ls -lah"
alias v='nvim'
alias tr="tree -Ca"
alias mkd="mkdir -p"
alias du="du -sh"

# source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

eval "$(starship init zsh)"

if [ "$(tty)" = "/dev/tty1" ];then
  exec startx
fi
