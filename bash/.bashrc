# bash aliases
alias bgrep='grep -HIrin --color=always'
alias l='ls'
alias ls='l -hal'

# use VI-style keybindings on the command line
set -o vi

# comment if git isn't stowed
source ~/.git-completion.bash
