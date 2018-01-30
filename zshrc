export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export ZSH=$HOME/.oh-my-zsh/
export ZSH_THEME="flazz"
export EDITOR=VIM
export XDG_CONFIG_HOME=~/.config
export VAGRANT_PREFER_SYSTEM_BIN=1
export ZSH_TMUX_AUTOSTART=true
fpath=(/usr/local/share/zsh/site-functions $fpath)

if [ `uname` = 'CYGWIN_NT-6.1' ]; then
  plugins=(git git-flow history-substring-search vi-mode bundler ssh-agent tmux)
else
  plugins=(git git-flow iTerm osx brew history-substring-search vi-mode bundler ssh-agent pow tmux tmuxinator bwana)
  source /usr/local/bin/virtualenvwrapper.sh
fi

source $ZSH/oh-my-zsh.sh
export PATH="/usr/local/sbin:$PATH"
alias ti=tmuxinator
function bundled_rubocop(){
  _run-with-bundler rubocop $@
}
alias rubocop=bundled_rubocop
alias evim='vim ~/.vimrc'

if [ `uname` = 'Darwin' ]; then
  export NVM_DIR="$HOME/.nvm"
  source /usr/local/opt/nvm/nvm.sh
  export PATH=$PATH:$HOME/Library/Python/2.7/bin
  eval "$(rbenv init -)"
  . /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
fi
