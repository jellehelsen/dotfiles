. ~/.zshenv
export ZSH=$HOME/.oh-my-zsh/
export ZSH_THEME="flazz"
export EDITOR=vim
export VAGRANT_PREFER_SYSTEM_BIN=1
export ANSIBLE_COW_SELECTION=random
export EMAIL=jelle@hcode.be
fpath=(/usr/local/share/zsh/site-functions $fpath)

zstyle :omz:plugins:ssh-agent agent-forwarding on

case "$(uname)" in
  Linux)
    plugins=(tmux git git-flow history-substring-search vi-mode bundler ssh-agent docker docker-compose)
    export ZSH_TMUX_AUTOSTART=false
    ;;

  Darwin)
    plugins=(git git-flow iterm2 osx brew history-substring-search vi-mode bundler ssh-agent pow tmux tmuxinator bwana docker docker-compose go nvm)
    source /usr/local/bin/virtualenvwrapper.sh
    export ZSH_TMUX_AUTOSTART=false
    ;;

  CYGWIN*)
    plugins=(git git-flow history-substring-search vi-mode bundler ssh-agent tmux)
    ;;
  *)
    echo "$(uname) Didn't match anything"
esac

source $ZSH/oh-my-zsh.sh
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
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    export PATH="/home/jelle/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    eval "$(rbenv init -)"
    stty -ixon
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
