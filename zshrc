export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export ZSH=$HOME/.oh-my-zsh/
export ZSH_THEME="flazz"
export EDITOR=VIM
export XDG_CONFIG_HOME=~/.config
export ZSH_TMUX_AUTOSTART=true
fpath=(/usr/local/share/zsh/site-functions $fpath)

plugins=(git git-flow iTerm osx brew history-substring-search vi-mode bundler pow tmux tmuxinator bwana)
source $ZSH/oh-my-zsh.sh
#PROMPT=' %m%{${fg_bold[magenta]}%} :: %{$reset_color%}%{${fg[green]}%}%c $(git_prompt_info)%{${fg_bold[$CARETCOLOR]}%}%#%{${reset_color}%} '
export PATH="/usr/local/sbin:$PATH:$HOME/Library/Python/2.7/bin"
export ANSIBLE_COW_SELECTION=random
eval "$(rbenv init -)"
#. $HOME/Library/Python/2.7/lib/python/site-packages/powerline/bindings/zsh/powerline.zsh
alias ti=tmuxinator
function bundled_rubocop(){
  _run-with-bundler rubocop $@
}
alias rubocop=bundled_rubocop
alias evim='vim ~/.vimrc'

source /usr/local/bin/virtualenvwrapper.sh

export NVM_DIR="$HOME/.nvm"
 . "/usr/local/opt/nvm/nvm.sh"
