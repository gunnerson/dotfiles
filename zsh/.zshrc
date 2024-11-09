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

zstyle :compinstall filename '/home/rumata/.zshrc'
autoload -Uz compinit
compinit

alias ll="ls -lh"
alias la="ls -lah"
alias gc="google-chrome-stable &"
alias v='nvim'

eval "$(starship init zsh)"

if [ "$(tty)" = "/dev/tty1" ];then
  exec startx
fi
