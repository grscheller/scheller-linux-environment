#
#  ~/.bashrc
#
#  Configure what stays consistent across all my 
#  interctive shells.
#

## If not running interactively, don't configure anything.
if [[ $- != *i* ]]
then
  # Reverse engineering
  # Count number of times file sourced noninteractively
  export BASHRC_NON_INTERACTIVE=${BASHRC_NON_INTERACTIVE:=0}
  ((BASHRC_NON_INTERACTIVE++))
  return
fi

export BASHRC_SOURCED_INTERACTIVELY=${BASHRC_SOURCED_INTERACTIVELY:=0}

## Bash customizations when running interactively

set -o notify  # Do not wait until next prompt to report bg jobs status.
set -o pipefail  # Return right most nonzero error, otherwise 0.
shopt -s extglob  # Turn on extended pattern matching.
shopt -s checkwinsize
shopt -s checkhash # Checks if hashed cmd exists, otherwise search path.

# Command line history editing and terminal title
set -o vi         # Cmdline editting like vi editor
shopt -s cmdhist     # Store multiline commands as single entry
shopt -s lithist     # in history with embedded whitespace.
shopt -s histappend    # Append, don't replace history file.
HISTSIZE=5000
HISTFILESIZE=5000
HISTCONTROL="ignoredups"
HOST=${HOSTNAME%%.*}
case $TERM in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*)
    PROMPT_COMMAND='history -a; echo -ne "\033]0;${USER}@${HOST}\007"'
    ;;
  screen)
    PROMPT_COMMAND='history -a; echo -ne "\033_${USER}@${HOST}\033\\"'
    ;;
  *)
    PROMPT_COMMAND='history -a'
    ;;
esac

# 3 line prompt with pwd
PS1='\n[\u@${HOST}: \w]\n\$ '
PS2='> '
PS3='> '
PS4='+ '

## Aliases and Functions

unalias rm 2> /dev/null
unalias ls 2> /dev/null
alias lc='ls --color=auto'
alias l1='ls -1'
alias la='ls -a'
alias ll='ls -ltr'
alias lla='ls -ltra'
alias l.='ls -dA .* --color=auto'
alias pst="ps axjf | sed -e '/^ PPID.*$/d' -e's/.*:...//'"
alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'

## pop up multiple directories
function ud() {
  upDir=../
  if [[ $1 =~ ^[1-9][0-9]*$ ]]
  then
    for ((ii = 1; ii < $1; ii++))
    do
      upDir=../$upDir
    done
  fi
  cd $upDir
}

## wget aliases to pulldown websites

# Pull down a subset of a website
alias Wget='wget -p --convert-links -e robots=off'

# Pull down more -- Not good for large websites
alias WgetMirror='wget --mirror -p --convert-links -e robots=off'

## Anaconda Python aliases
#    Have to use conda virtual environments since ~/opt/anaconda3/bin
#    contaminates path with old versions of /usr/bin utilities.
alias conda=~/opt/anaconda3/bin/conda
alias actA='sh -c ". ~/opt/anaconda3/bin/activate; bash"'
alias play='sh -c ". ~/opt/anaconda3/bin/activate play; bash"'

## NVIDIA aliases

# NVIDIA Daemon to keep card active when not running X-Windows
alias nv-pd='sudo nvidia-persistenced --user geoff --persistence-mode'

# Activate and Deactivate respectfully.
#    Communicates with above daemon if running, otherwise
#    directly with card in a deprecated manner.
alias nv-off='sudo nvidia-smi -pm 0'
alias nv-on='sudo nvidia-smi -pm 1'

## XFCE GUI-land aliases and functions

# Quick way to bring up file manager from CLI-land
alias fm='(/usr/bin/thunar &)'

# Terminal which inherits environment of parent shell
alias tm='(/usr/bin/xfce4-terminal --disable-server &)'

# PDF Reader
function ev() {
  ( /usr/bin/evince "$@" &>/dev/null & )
}
 
# Google Chrome Browser
function gc() {
  ( /opt/google/chrome/chrome "$@" &>/dev/null & )
}

# Bash completion for stack (Haskell)
#eval "$(stack --bash-completion-script stack)"

## Count number of time file sourced interactively
((BASHRC_SOURCED_INTERACTIVELY++))
