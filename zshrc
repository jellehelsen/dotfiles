export ZSH=$HOME/.oh-my-zsh/
export ZSH_THEME="flazz"
export EDITOR=VIM
fpath=(/usr/local/share/zsh/site-functions $fpath)

plugins=(git git-flow iTerm osx brew history-substring-search vi-mode thefuck bundler pow tmuxinator)
source $ZSH/oh-my-zsh.sh
PROMPT=' %m%{${fg_bold[magenta]}%} :: %{$reset_color%}%{${fg[green]}%}%c $(git_prompt_info)%{${fg_bold[$CARETCOLOR]}%}%#%{${reset_color}%} '
eval "$(rbenv init -)"
export PATH="/usr/local/sbin:$PATH"
