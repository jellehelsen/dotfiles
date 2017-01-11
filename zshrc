export ZSH=$HOME/.oh-my-zsh/
export ZSH_THEME="flazz"
export EDITOR=VIM

plugins=(git git-flow iTerm osx brew history-substring-search vi-mode thefuck bundler pow)
source $ZSH/oh-my-zsh.sh
PROMPT=' %m%{${fg_bold[magenta]}%} :: %{$reset_color%}%{${fg[green]}%}%c $(git_prompt_info)%{${fg_bold[$CARETCOLOR]}%}%#%{${reset_color}%} '
eval "$(rbenv init -)"
