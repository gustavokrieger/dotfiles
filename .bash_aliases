stty -ixon

bin="$HOME/.local/bin"
dotfiles="$HOME/.dotfiles"
git_interface='lazygit'
xdg_data_home="$HOME/.local/share"

export APPLICATIONS="$xdg_data_home/applications"
export BIN=$bin
export EDITOR="$bin/hx"
export FONTS="$xdg_data_home/fonts"
export ICONS="$xdg_data_home/icons"
export VISUAL=$EDITOR

alias cb='xclip -selection clipboard'
alias dcd='docker compose down'
alias dcu='docker compose up --build --detach'
alias df="git --git-dir=$dotfiles --work-tree=$HOME"
alias dfi="$git_interface --git-dir=$dotfiles --work-tree=$HOME"
alias gacp='git add --all && git commit --allow-empty-message -m "" && git push'
alias gi=$git_interface
alias op='xdg-open' && complete -F _minimal op
alias srd='systemctl --user restart docker-desktop'
alias wr=$EDITOR

sva() { source "$(cat .sva)/bin/activate"; }
cec() {
	[ ! -d "$1" ] && echo "Invalid directory" && return 1
	mkdir "$1/.helix"
	cp "$HOME/.config/helix/languages.toml" $_
}
tmp() {
	set -e
	[ ! -d "$1" ] && echo "Invalid directory" && return 1
	d="/tmp/$(date +%m%d%y%H%M%S%N)"
	mkdir $d
	f="$d/main.go"
	echo -e 'package main\n\nfunc main() {\n\t\n}' >$f
	mkdir "$1/.tmp"
	ln -s $f "$1/.tmp/main.go"
	$EDITOR $_
}
