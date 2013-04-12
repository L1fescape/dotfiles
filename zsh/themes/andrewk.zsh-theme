#PROMPT='%(!.%{$fg_bold[red]%}.%{$fg_bold[green]%}%n@)%m %{$fg_bold[blue]%}%(!.%1~.%~) $(git_prompt_info)%{$reset_color%} '
PROMPT='  %{$fg_bold[cyan]%}%(!.%1~.%~)$(git_prompt_info) %{$reset_color%}%{$fg[cyan]%}→ %{$reset_color%}' 

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg_bold[blue]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*%{$fg[blue]%}"
