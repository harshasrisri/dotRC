alias ls='ls --color=auto -CF'
alias ll='ls -lFht'
alias la='ls -a'
alias lla='ls -lFhta'
alias lr='ls -R'
alias l.='ls -d .*'
alias ll.='ls -lFhtd .*'

alias .v='vi ~/.vimrc'
alias .m='vi ~/.myshrc'
alias .z='vi ~/.zshrc'
alias .t='vi ~/.tmux.conf'
alias ..t='tmux source-file ~/.tmux.conf'
alias .rc='cd $(dirname $(readlink ~/.vimrc))/..'

alias x='exit'
alias wget='wget -c'
alias grep='grep --color=auto --exclude-dir=.cvs --exclude-dir=.git --exclude-dir=.hg --exclude-dir=.svn'
alias pgrep="ps aux | grep -v grep | grep -i -e VSZ -e"

alias scpnoverify="scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
alias sshnoverify="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"

alias gl='git log --oneline --decorate --date=short --graph'
alias gs='git status'
alias gd='git diff'
alias gdt='git difftool'
alias gdc='git diff --cached'