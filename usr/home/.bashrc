# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples


if [ -f /etc/env ]; then
       set -a
       . /etc/env
       set +a
fi

set -o vi
export EDITOR="vim"

export DATE=$(date +"%y%m%d")
export TIME=$(date +"%T")
export YEAR=$(date +"%Y")
export MONTH=$(date +"%m")
export DAY=$(date +"%d")
export USER=$(whoami)
export HOST=$(cat /etc/hostname)
export PWD_=$(pwd)
export SOURCE="$HOME/.bashrc"


export OCTET="(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)"
export IPV4_REG="($OCTET\.){3}$OCTET"
export IPV6_REG="(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))"
export IP_REG="($IPV4_REG)|($IPV6_REG)"
export EMAIL_REG="[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}"

MAC_REG='([0-9A-Fa-f]{2}[:-]){5}[0-9A-Fa-f]{2}'

export YES_REG="\$y\$[./A-Za-z0-9]+\$[./A-Za-z0-9]{,86}\$[./A-Za-z0-9]{43}"
export FILE_REG="[a-zA-Z0-9]+\.[a-zA-Z0-9]+"
export YYYY_REG="((19[5-9][0-9])|(20[0-2][0-9]))"
export MM_REG="((0?[1-9])|(1[0-2]))"
export DD_REG="((0?[1-9])|([1-2][0-9])|(3[0-1]))"
export DATE_REG="(${YYYY_REG}${MM_REG}${DD_REG})|(${DD_REGMM_REG}${YYYY_REG})"
export YYYYMMDD_REG="${YYYY_REG}${MM_REG}${DD_REG}"
export DDMMYYYY_REG="${DD_REG}${MM_REG}${YYYY_REG}"
export CFUNCTION="^[a-z].*\)$"

# --- Media File Extension Regex Patterns ---
export AUDIO_REG="mp3|wav|ogg|flac|m4a|aac|aiff|opus"
export VIDEO_REG="mp4|mkv|mov|avi|webm|wmv|flv|mpeg|mpg|3gp|m4v"
export IMAGE_REG="jpg|jpeg|png|gif|bmp|webp|tiff|ico|heic|svg|jfif"

export MEDIA_REG="\.(${AUDIO_REG}|${VIDEO_REG}|${IMAGE_REG})$"

PATH="/bin:/sbin:/usr/bin:/usr/sbin:/opt"
PATH="$PATH:$SBIN_DIR"
PATH="$PATH:$BIN_DIR"
export PATH

export WWAN="$(ip link | grep -Eo "wwp[a-z0-9]+")"
export WLAN="$(ip link | grep -Eo "wlan[a-z0-9]+")"

case $- in
    *i*) ;;
      *) return;;
esac
#. /etc/bash.bashrc


# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
# append to the history file, don't overwrite it
#shopt -s histappend
PROMPT_COMMAND='history -a'
export HISTTIMEFORMAT='%F %T '

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
HISTFILE=~/.history

## check the window size after each command and, if necessary,
## update the values of LINES and COLUMNS.
##shopt -s checkwinsize
#
## If set, the pattern "**" used in a pathname expansion context will
## match all files and zero or more directories and subdirectories.
##shopt -s globstar
#
## make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Définir les couleurs
GREEN='\[\e[32m\]'
YELLOW='\[\e[33m\]'
ORANGE='\[\e[38;5;214m\]'  # Il n'y a pas de code direct pour l'orange, mais ce code ANSI s'en approche
RED='\[\e[31m\]'
NO_COLOR='\[\e[0m\]'  # Réinitialiser la couleur
# Définir PS1 avec les couleurs
#export PS1="\n\u@\H-\D{%y%m%d}-\t-\w\n=>"
# Couleurs
USER_COLOR="\[\e[1;32m\]"   # Vert clair pour l'utilisateur
HOST_COLOR="\[\e[1;34m\]"   # Bleu clair pour l'hôte
DATE_COLOR="\[\e[1;33m\]"   # Jaune pour la date
TIME_COLOR="\[\e[1;36m\]"   # Cyan pour l'heure
DIR_COLOR="\[\e[1;35m\]"    # Magenta clair pour le répertoire
RESET_COLOR="$NO_COLOR"

export GIT_EDITOR=vim

BRANCH="$(git rev-parse --abbrev-ref HEAD)"
PS1="\n\n${DATE_COLOR}\D{%y%m%d}${RESET_COLOR}-${TIME_COLOR}\t${RESET_COLOR}-${USER_COLOR}\u${RESET_COLOR}@${HOST_COLOR}\H${RESET_COLOR}-${DIR_COLOR}\w${RESET_COLOR}\n=> "

export HISTCONTROL=ignorespace

DEVICE="$(ip addr | grep -v DOWN | grep -E "^[0-9]" | awk -F':' '{print $2}' | grep -v lo)"

export REMOTE_BRANCHES="github origin"

export LESS=-R

export AWK_GREP_KEY="'{
  for (i = 1; i <= NF; i++)
    if ($i ~ "^"key"=") {
      split($i, a, "=")
      print a[2]
    }
}'"

bind -f  /home/.inputrc

if [ -f /home/.bash_aliases ]; then
       . /home/.bash_aliases
fi

# permet les accents
#setxkbmap us -variant intl

#envsubst < ${MACHINE_PATH}/dotfiles/ssh/config.template > ~/.ssh/config

#export PATH=~/.npm-global/bin:$PATH

