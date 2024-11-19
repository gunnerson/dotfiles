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

alias ll="ls -lh"
alias la="ls -lah"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias cat="bat"
alias cl="clear"
alias hgr="history 0 | grep"
alias v='nvim'
alias z='zellij'
alias tr="tree -Ca"
alias mkd="mkdir -p"
alias du="du -sh"
alias fh="feh -Fq --on-last-slide hold ."
alias Y='yazi'
alias wgup='nordvpn d && sudo wg-quick up wg0 && sudo mount -a'
alias wgdn='sudo wg-quick down wg0 && nordvpn c'
alias gitq='git add -u; git commit -m "Update $(date +%F)"; git push'
alias jscdn="rsync --archive -hh --partial --info=stats1,progress2 --delete /mnt/bnas/public/share/schnee/ ~/jsc"

# . /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

for f in ~/.local-vars/* ; do
  set -a
  . "$f"
  set +a
done
unset f

. <(fzf --zsh)

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

eval "$(starship init zsh)"

# if uwsm check may-start; then
#   exec uwsm start hyprland.desktop
# fi

# if [ "$(tty)" = "/dev/tty1" ];then
#   exec startx
# fi
