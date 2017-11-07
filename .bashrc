# prompt
[ -z "$PS1" ] && return

liBlack="\[\033[0;30m\]"
boBlack="\[\033[1;30m\]"
liRed="\[\033[0;31m\]"
boRed="\[\033[1;31m\]"
liGreen="\[\033[0;32m\]"
boGreen="\[\033[1;32m\]"
liYellow="\[\033[0;33m\]"
boYellow="\[\033[1;33m\]"
liBlue="\[\033[0;34m\]"
boBlue="\[\033[1;34m\]"
liMagenta="\[\033[0;35m\]"
boMagenta="\[\033[1;35m\]"
liCyan="\[\033[0;36m\]"
boCyan="\[\033[1;36m\]"
liWhite="\[\033[0;37m\]"
boWhite="\[\033[1;37m\]"
D="\[\033[0;37m\]"

# PS1="\n$boGreen┌─ \u$liWhite at $boBlue\h$liWhite in $boRed\w $liYellow{\[\`let exitstatus=\$? ; if [[ \${exitstatus} != 0 ]] ; then echo \"\${exitstatus}\" ; else echo "0" ; fi\`\]} \n$boGreen└─$liRed ∞ $liWhite"
export PS1="\n${boRed}\u ${D}at ${boYellow}\h ${D}in ${boGreen}\w${D}\n$ "

# alias
alias ls='ls -F --color=auto'
alias ll='ls -lsh'
alias tmux='tmux -2'
alias py='python'
alias miv='vim -u NONE -N'

alias ..="cd .."
alias .2="cd ../.."
alias .3="cd ../../.."
alias .4="cd ../../../.."
alias .5="cd ../../../../.."
alias .6="cd ../../../../../.."

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# completion
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

if [ -d ~/.bash_completion.d ]; then
  for file in ~/.bash_completion.d/*; do
    . $file
  done
fi

# funcs
topten() {
  history | awk '{ print $2 }' | LC_ALL=C sort -i | LC_ALL=C uniq -c | LC_ALL=C sort -rn | head -n 20
}

proj() {
  cd $(find ~/repo -maxdepth 1 -type d | fzy)
}

v() {
  if [ $# -eq 0 ]; then
    vim $(rg --files | fzy)
  else
    vim $(rg --files | fzy -q "$@")
  fi
}

vrg() {
  $(rg --no-heading --vimgrep "$@" | fzy | awk -F ':' '{ print "vim "$1" +"$2 }')
}

vhst() {
  $(hg st "$@" | fzy | awk '{ print "vim "$2 }')
}

zfz() {
  $(z "$@" | fzy | awk '{ print "cd "$2 }')
}

# dir_colors
if [ -f ~/.dir_colors ]; then
  eval `dircolors ~/.dir_colors`
fi

# exports
export EDITOR='vim'
[ -z "$TMUX" ] && export TERM='xterm-256color'

# ~/.bashrc_top_secret can be used for settings that must not be shared.
if [ -r ~/.bashrc_top_secret ] && [ -f ~/.bashrc_top_secret ]; then
  source ~/.bashrc_top_secret
fi
