# Opening files from terminal
alias ko='kde-open'

# Easy access to python and friends
alias py3="python3 -u"
alias ipy3=ptipython3
alias py2="python2 -u"
alias ipy2=ptipython2

# Disable autocorrect for which
alias which='nocorrect which'

# Objdump will display assembly code in Intel sytax
alias objdump='objdump -M intel'

# Alias for youtube-dl
alias ydlbest="youtube-dl -t -c --console-title"
alias ydlnormal="youtube-dl -t -c --console-title -f 'best[width=640]'"
alias ydlpoor="youtube-dl -t -c --console-title -f 'best[width=320]'"

# Alias for opening certain files automatically in vi
alias -s c=vi
alias -s h=vi
alias -s md=vi

# Alias for ack-grep
alias ack="ack-grep --color-match=green"

# Alias to disable printing of prompt in gdb
alias gdb="gdb -q"

# Aliases for git
alias gsh="git show"

# Aliases for apt-*
alias acsh="apt-cache show"
alias agar="sudo apt-get autoremove"

# Alias for ls to enable natural sort of numbers in names
alias ls="ls --color=tty -v"
