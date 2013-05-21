PROMPT='
%{$FG[155]%}%(!.%1~.%~)%{$FG[152]%}% $([ $VIRTUAL_ENV ] && echo " [" )%{$FG[141]%}% $(virtualenv_info)%{$FG[152]%}% $([ $VIRTUAL_ENV ] && echo ']' )$(git_prompt_info) %{$reset_color%}%{$fg_bold[blue]%}➞ %{$reset_color%}% ' 

ZSH_THEME_GIT_PROMPT_PREFIX="%{$FG[152]%} ± %{$FG[135]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$FG[161]%}*"
