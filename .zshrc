HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

autoload -Uz compinit
compinit

. ~/.zaliases

autoload -U colors && colors
PS1="%{$fg_bold[green]%}%~ %{$fg_bold[white]%}>%{$reset_color%} "
RPS1="%(?..%{$fg_bold[red]%}[%?]%{$reset_color%})"