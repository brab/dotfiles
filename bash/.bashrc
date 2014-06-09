# bash aliases
alias bgrep='grep -HIrin --color=always'
alias l='ls'
alias ls='l -hal'

# use VI-style keybindings on the command line
set -o vi

# homebrew prefers this order for PATH
export PATH=/usr/local/bin:$PATH

# homebrew's bash_completion offers a lot of good stuff
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi
