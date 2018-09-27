export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export ZSH=$HOME/.oh-my-zsh/
export ZSH_THEME="flazz"
export EDITOR=vim
export XDG_CONFIG_HOME=~/.config
export VAGRANT_PREFER_SYSTEM_BIN=1
export ANSIBLE_COW_SELECTION=random
fpath=(/usr/local/share/zsh/site-functions $fpath)

zstyle :omz:plugins:ssh-agent agent-forwarding on

case "$(uname)" in
  Linux)
    plugins=(tmux git git-flow history-substring-search vi-mode bundler ssh-agent docker docker-compose)
    export ZSH_TMUX_AUTOSTART=true
    ;;

  Darwin)
    plugins=(git git-flow iTerm osx brew history-substring-search vi-mode bundler ssh-agent pow tmux tmuxinator bwana docker docker-compose go)
    source /usr/local/bin/virtualenvwrapper.sh
    export ZSH_TMUX_AUTOSTART=true
    ;;

  CYGWIN*)
    plugins=(git git-flow history-substring-search vi-mode bundler ssh-agent tmux)
    ;;
  *)
    echo "$(uname) Didn't match anything"
esac

source $ZSH/oh-my-zsh.sh
export GOPATH=$HOME/go
export PATH="/usr/local/sbin:$PATH:$GOPATH/bin"
alias ti=tmuxinator
function bundled_rubocop(){
  _run-with-bundler rubocop $@
}
alias rubocop=bundled_rubocop
alias evim='vim ~/.vimrc'

if [ `uname` = 'Darwin' ]; then
fi
case "$(uname)" in
  Linux)
    . /usr/local/lib/python2.7/dist-packages/powerline/bindings/zsh/powerline.zsh
    ;;

  Darwin)
    export NVM_DIR="$HOME/.nvm"
    source /usr/local/opt/nvm/nvm.sh
    export PATH=$PATH:$HOME/Library/Python/2.7/bin:$HOME/go/bin
    eval "$(rbenv init -)"
    . /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
    ;;

  CYGWIN*)
    ;;
  *)
    echo "$(uname) Didn't match anything"
esac
