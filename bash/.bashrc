# bash aliases
alias bgrep='grep -HIrin --color=always'
alias ls='ls -hal'

# use VI-style keybindings on the command line
set -o vi

if [ -x /usr/local/bin/brew ]; then
    # homebrew prefers this order for PATH
    export PATH=/usr/local/bin:$PATH
    export PATH=/usr/local/sbin:$PATH

    # homebrew's bash_completion offers a lot of good stuff
    if [ -f `brew --prefix`/etc/bash_completion ]; then
        . `brew --prefix`/etc/bash_completion
    fi
fi
