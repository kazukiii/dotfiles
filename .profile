PS1="\[\033[31m\]\h:\W \u\[\033[0m\]$ "
export ROOTSYS=/usr/local/root
export PATH=${ROOTSYS}/bin:${PATH}
export DYLD_LIBRARY_PATH=${ROOTSYS}/lib:${DYLD_LIBRARY_PATH}
export PYTHONPATH=${ROOTSYS}/lib:${PYTHONPATH}
GREP_OPTIONS="--color=always";export GREP_OPTIONS
alias e='emacs -nw'
alias ls='ls -F'
alias la='ls -a'
alias ll='ls -l'
alias mkdir='mkdir -p'
alias a='atom'
alias find='find . -iname'
alias py='python'
eval "$(hub alias -s)"
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
shopt -s cdspell
shopt -s histappend
HISTSIZE=1000000
HISTFILESIZE=1000000
export PGDATA=/usr/local/var/postgres

# added by Anaconda3 4.4.0 installer
export PATH="/Users/kazuki/anaconda/bin:$PATH"
