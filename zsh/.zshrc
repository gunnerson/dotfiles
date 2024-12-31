# vim:fileencoding=utf-8:foldmethod=marker

# : History {{{

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=100000
setopt inc_append_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_verify

# : }}}

# : Options {{{

setopt autocd
setopt correct
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

# : }}}

# : Aliases {{{

alias rm='rm -i'
alias mv='mv -i'
alias ll="ls --color -lh"
alias la="ls --color -lah"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias cl="clear"
alias susp="systemctl suspend"
alias sudo='sudo '
alias hgr="history 0 | grep"
alias bat='bat -p'
alias cat='bat --paging=never -p'
alias vi='nvim'
alias tree="tree -Ca"
alias mkd="mkdir -p"
alias du="du -sh"
alias fh="feh -Fq --on-last-slide hold ."
alias bm='bashmount'
alias scr='grim -g "$(slurp)"'
alias wgup='nordvpn d && sudo wg-quick up wg0'
alias wgdn='sudo wg-quick down wg0'
alias gitq='git add -u; git commit -m "Update $(date +%F)"; git push'
alias gits='git status'
alias hday='pkill "hyprsunset"'
alias hnight='nohup hyprsunset -t 2700 > /dev/null 2>&1 &'

# : }}}

# : fzf {{{

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

# : }}}

# : yazi {{{

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# : }}}

# : Starship {{{

eval "$(starship init zsh)"

# : }}}

# : bun {{{

[ -s "/home/rumata/.bun/_bun" ] && source "/home/rumata/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$PATH:$BUN_INSTALL/bin"

# : }}}

# : Environment varibles {{{

for f in ~/.local-vars/*; do
	set -a
	. "$f"
	set +a
done
unset f

# : }}}
