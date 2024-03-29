#!/usr/bin/env bash

# Axin Bash Prompt, inspired by theme "Sexy" and "Bobby"
# thanks to them

if [[ $COLORTERM = gnome-* && $TERM = xterm ]]  && infocmp gnome-256color >/dev/null 2>&1; then export TERM=gnome-256color
elif [[ $TERM != dumb ]] && infocmp xterm-256color >/dev/null 2>&1; then export TERM=xterm-256color
fi

if tput setaf 1 &> /dev/null; then
    if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
      MAGENTA=$(tput setaf 9)
      ORANGE=$(tput setaf 172)
      GREEN=$(tput setaf 190)
      PURPLE=$(tput setaf 141)
      WHITE=$(tput setaf 0)
    else
      MAGENTA=$(tput setaf 5)
      ORANGE=$(tput setaf 4)
      GREEN=$(tput setaf 2)
      PURPLE=$(tput setaf 1)
      WHITE=$(tput setaf 7)
    fi
    BOLD=$(tput bold)
    RESET=$(tput sgr0)
else
    MAGENTA="\033[1;31m"
    ORANGE="\033[1;33m"
    GREEN="\033[1;32m"
    PURPLE="\033[1;35m"
    WHITE="\033[1;37m"
    BOLD=""
    RESET="\033[m"
fi

function python_env() {
  if [[ ! -z $VIRTUAL_ENV ]]; then
    echo "\[$GREEN\](venv $(basename $VIRTUAL_ENV)) ";
  fi
}

function conda_env() {
  if [[ ! -z $CONDA_DEFAULT_ENV ]]; then
    echo "\[$GREEN\](conda $CONDA_DEFAULT_ENV) ";
  fi
}

function cwd_prompt() {
    local _cwd=$(pwd | sed "s|^${HOME}|~|");
    echo $_cwd;
}

function prompt_command() {
    PS1="$(python_env)$(conda_env)\[${BOLD}${MAGENTA}\]\u \[$WHITE\]@ \[$ORANGE\]\h \[$WHITE\]in \[$GREEN\]$(cwd_prompt)\[$PURPLE\]\$(scm_prompt_info) \n\$ \[$RESET\]"
}

THEME_CLOCK_COLOR=${THEME_CLOCK_COLOR:-"${white}"}

safe_append_prompt_command prompt_command
