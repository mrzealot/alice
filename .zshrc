. ~/.zaliases

autoload -U colors && colors
PS1="%{$fg_bold[green]%}%~ %{$fg_bold[white]%}>%{$reset_color%} "
RPS1="%(?..%{$fg_bold[red]%}[%?]%{$reset_color%})"