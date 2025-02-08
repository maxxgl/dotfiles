# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
# shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
# shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
	else
		color_prompt=
	fi
fi

export PS1="\u@\h\w$ "

# if [ "$color_prompt" = yes ]; then
# 	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# else
# 	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
# fi
# unset color_prompt force_color_prompt
#
# # If this is an xterm set the title to user@host:dir
# case "$TERM" in
# xterm* | rxvt*)
# 	PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
# 	;;
# *) ;;
# esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	#alias dir='dir --color=auto'
	#alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
# if ! shopt -oq posix; then
# 	if [ -f /usr/share/bash-completion/bash_completion ]; then
# 		. /usr/share/bash-completion/bash_completion
# 	elif [ -f /etc/bash_completion ]; then
# 		. /etc/bash_completion
# 	fi
# fi

# My stuff
git_branch() {
	if git rev-parse --git-dir >/dev/null 2>&1; then
		printf " %s" "$(git branch 2>/dev/null | sed -n '/^\*/s/^\* //p')"
	else
		printf ""
	fi
}

git_color() {
	local STATUS=$(git status 2>&1)
	if [[ "$STATUS" == *'Not a git repository'* ]]; then
		printf '\001\033[0m\002' # reset color
	else
		if [[ "$STATUS" != *'working tree clean'* ]]; then
			printf '\001\033[0;31m\002' # red if need to commit
		else
			if [[ "$STATUS" == *'Your branch is ahead'* ]]; then
				printf '\001\033[0;33m\002' # yellow if need to push
			else
				printf '\001\033[0;32m\002' # else green
			fi
		fi
	fi
}

# export PS1='\[\033[0m\]\w\[\033[0m\]$(git_color)$(git_branch)\[\033[0;34m\] \$ \[\033[0m\]'
# Set the prompt
setopt PROMPT_SUBST
PROMPT='%F{white}%~$(git_color)$(git_branch)%F{blue} $ %f'

alias c='clear'
alias g='git status'
alias am='git commit -am'
alias p='git push'
alias l="git log --graph -5 --decorate --all --abbrev-commit --pretty=format:'%C(dim normal)%<(12)%an -%Creset %C(yellow)%h%Creset: %C(dim cyan)%<(14)<%cr> %Creset%s %Cred%d%Creset'"
alias log="git log --all --stat --oneline -3 --graph --abbrev-commit --pretty=format:'%C(dim normal)%<(12)%an -%Creset %C(yellow)%h%Creset: %C(dim cyan)%<(14)<%cr> %Creset%s %Cred%d%Creset%n'"
alias d='git diff'
alias amend='git commit --amend --no-edit'
alias serve='browser-sync start --server --files \"css/*.css, js/*.js, *.html\" --no-notify'

alias run='docker run --rm -it $(docker build -q .)'
alias prun='docker run --rm -it -p 8080:80 $(docker build -q .)'
alias h='nvim ~/Documents/history.md'
alias clip='xclip -selection clipboard'
alias python=python3
alias v=nvim
alias b="git branch -vv"
alias bb="git fetch -p && git branch -vv"
branch_prune() {
	git fetch -p
	for branch in $(git branch -vv | grep ': gone]' | awk '{print $1}'); do
		git branch -D $branch --verbose
	done
}
alias bp=branch_prune
alias mermaid="docker run --platform linux/amd64 --publish 8000:8080 ghcr.io/mermaid-js/mermaid-live-editor"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

PYTHON_BIN_PATH="$(python3 -m site --user-base)/bin"
PATH="$PATH:$PYTHON_BIN_PATH:/usr/local/bin/kustomize"

export PATH="$PATH:/opt/nvim-linux64/bin"
alias nv=nvim
export PATH="$HOME/.tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"

alias k="kubectl --kubeconfig ~/.kube/dev-kube-config.yaml"
alias prod="kubectl --kubeconfig ~/.kube/prod-kube-config.yaml"
alias dev="k exec -it deployment/maxx-debug-deployment -n argocd -- /bin/bash"
export KUBE_EDITOR=nvim

alias tab="echo -ne '\033]0;Remote\a'"

export PATH="$PATH:/opt/mssql-tools18/bin"
. "$HOME/.cargo/env"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/maxxlehmann/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/maxxlehmann/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/maxxlehmann/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/maxxlehmann/google-cloud-sdk/completion.zsh.inc'; fi
