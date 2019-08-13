# ~/.bashrc: executed by bash(1) for non-login shells.

##All my cool alias and stuff
if [ -f $HOME/.bothrc ]; then
    . $HOME/.bothrc
fi

##Prompt Defn for Ballers
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h:\[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 6)\] ⚡\[$(tput setaf 248)\]"

stty -ixon # Disable ctrl-s and ctrl-q.
#shopt -s autocd #Allows you to cd into directory merely by typing the directory name.
HISTSIZE= HISTFILESIZE= # Infinite history.

#TERMINAL=gnome-terminal
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

if [ -f /etc/bash_completion ]; then
 . /etc/bash_completion
 fi