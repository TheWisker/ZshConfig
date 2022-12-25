#-------------------
# Autoload stuff
#-------------------

autoload -Uz compinit promptinit up-line-or-beginning-search down-line-or-beginning-search add-zsh-hook
compinit
promptinit

#-------------------
# Source plugins
#-------------------

# plugins should be installed using pacman

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

#-------------------
# History search
#-------------------

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

#-------------------
# Keybindings
#-------------------

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}" up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[[3~" delete-char

#------------------
# History stuff
#------------------

HISTFILE=~/.zhist
HISTSIZE=5000
SAVEHIST=5000

#-------------------
# Environment Stuff
#-------------------

export BROWSER="firefox"
export EDITOR="nano"

#--------------------
# Dircolors
#--------------------

LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32';
export LS_COLORS

#---------------------
# Alias stuff
#---------------------

alias ls="ls --color -F"
alias lso="ls --color -Fa"
alias spm="sudo pacman"

#---------------------
# Completion stuff
#---------------------

zstyle ':completion:*' menu select
zstyle ':completion:*:pacman:*' force-list always
zstyle ':completion:*:*:pacman:*' menu yes select
 
#---------------------
# Dirstack history
#---------------------

eval "$(zoxide init zsh)"

#---------------------
# Autorehash stuff
#---------------------

zshcache_time="$(date +%s%N)"

rehash_precmd() {
	if [[ -a /var/cache/zsh/pacman ]]; then
		local paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
		if (( zshcache_time < paccache_time )); then
			rehash
			zshcache_time="$paccache_time"
		fi
	fi
}

add-zsh-hook -Uz precmd rehash_precmd

#--------------------
# Theme stuff
#--------------------

prompt fade cyan grey blue