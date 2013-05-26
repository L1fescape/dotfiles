PROMPT='
%{$FG[153]%}%n%{$reset_color%} at %{$FG[175]%}%m% %{$reset_color%}%  in %{$FG[155]%}%(!.%1~.%~)%{$FG[152]%}% $(git_prompt_info)
%{$FG[141]%}% $(virtualenv_info)%{$FG[152]%}% %{$FG[111]%}⚡ %{$reset_color%}%' 

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%} on %{$FG[135]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="*"
