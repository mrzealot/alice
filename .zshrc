autoload -U colors && colors
PS1=" %{$fg_bold[green]%}%~ %{$fg_bold[white]%}>%{$reset_color%} "

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

git config --global alias.pushall '!git remote | xargs -L1 git push --all'
alias settings='XDG_CURRENT_DESKTOP=GNOME gnome-control-center &'
alias alice='/usr/bin/git --git-dir=$HOME/.alice/ --work-tree=$HOME'