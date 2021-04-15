export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export XDG_CONFIG_HOME=~/.config
export GOPATH=$HOME/go
if [ -x /usr/libexec/path_helper ]; then
    eval `/usr/libexec/path_helper -s`
fi
export PATH="/usr/local/bin:/usr/local/sbin:$PATH:$GOPATH/bin"
export PATH=$PATH:$HOME/Library/Python/2.7/bin:$HOME/go/bin
