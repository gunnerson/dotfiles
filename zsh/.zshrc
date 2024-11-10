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

if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#757575'
fi

WORDCHARS=${WORDCHARS//\/}

alias ll="ls -lh"
alias la="ls -lah"
alias v='nvim'
alias tr="tree -Ca"
alias mkd="mkdir -p"
alias du="du -sh"

# source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

for f in ~/.local-vars/* ; do
  set -a
  . "$f"
  set +a
done
unset f


eval "$(starship init zsh)"

if [ "$(tty)" = "/dev/tty1" ];then
  exec startx
fi
