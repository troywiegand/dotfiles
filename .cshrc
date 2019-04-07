set     red="%{\033[1;31m%}"
set   green="%{\033[0;32m%}"
set  yellow="%{\033[1;33m%}"
set    blue="%{\033[1;34m%}"
set magenta="%{\033[1;35m%}"
set    cyan="%{\033[1;36m%}"
set   white="%{\033[0;37m%}"
set     end="%{\033[0m%}" # This is needed at the end... :(

# Setting the actual prompt.  I made two separate versions for you to try, pick
# whichever one you like better, and change the colors as you want.  Just don't
# mess with the ${end} guy in either line...  Comment out or delete the prompt you don't use.

# set prompt="${green}%n${blue}@%m ${white}%~ ${green}%%${end} "

# Clean up after ourselves...

# @(#)cshrc Butler University 1998
#
# set the umask so that new files will have -rwx------ permissions
#
umask 077

if ( $?prompt ) then
	set history=32
endif

#
# Set the prompt to the host name
#
#set prompt="`uname -n`% "

#
# If /usr/bin/CSHRC exists, source it
# This is a global cshrc file which sets environment variables, etc.
#
if (-e /usr/bin/CSHRC) then
    source /usr/bin/CSHRC
endif

set path=($path /usr/ccs/bin /bin /usr/bin /usr/sbin /usr/include /usr/ucbinclude /usr/java/bin /usr/ucb /etc .) 

# 
# Set the default editor to vi/joe/pico
#

# setenv EDITOR /usr/bin/vi
# setenv EDITOR /usr/bin/joe
setenv EDITOR /usr/bin/pico

#
# filename completion of unambiguous filenames with the <esc> key
#
# set filec

set prompt="${red}[${yellow}%n${green}@${blue}%m${magenta}:%~${red}]${green} ⚡${end}"
