## re-bind zsh backwards search (gets unbound by vi-mode plugin)
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey '^[[3~' delete-char
bindkey '^R' history-incremental-search-backward
bindkey "^W" backward-kill-word    # vi-backward-kill-word
bindkey "^H" backward-delete-char  # vi-backward-delete-char
bindkey "^U" kill-line             # vi-kill-line
bindkey "^?" backward-delete-char  # vi-backward-delete-char
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

# use v to launch edit command
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line


