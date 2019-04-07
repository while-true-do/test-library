#!/usr/bin/env bash
# name: _lib.sh
# description: Common functions for test-library.
# author: while-true-do.io
# license: BSD-3-Clause

# shellcheck disable=SC2034

# Variables
declare -A color
color[default]="\e[m"
color[crit]="\e[0;31m"
color[okay]="\e[0;32m"
color[warn]="\e[0;33m"
color[undef]="\e[0;34m"

declare -A state
state[default]="0"
state[crit]="1"
state[okay]="0"
state[warn]="0"

declare -A count
count[default]="0"
count[crit]="0"
count[okay]="0"
count[warn]="0"
count[undef]="0"

# Functions
function add() {
  # add: use $1 as variable name and add 1 to it
  eval "$1"=$(($1+1))

  return 0
}

function die() {
  # die: exit the program with a message
  #      optionally, exit with a return status
  MESSAGE="$1"
  RESULT="${2:-1}"

  printf "\n"
  printf "${color[crit]}[%s|action: %s|result: %s|%s]${color[default]}\n" "$SCRIPT_NAME" "${FUNCNAME[2]}" "$RESULT" "$MESSAGE"
  printf "\n"

  exit "$RESULT"
}

function run() {
  # run: run a command and check it's result
  COMMAND="$1"
  printf "[%s|%s|%s|%s]\n" "$SCRIPT_NAME" "${FUNCNAME[1]}" "${FUNCNAME[0]}" "${COMMAND}"

  $COMMAND
  RETURN="$?"
  printf "\n"

  if [[ $RETURN == "0" ]]
  then
    add "count[okay]"
  else
    add "count[crit]"
  fi

  return 0
}

function try() {
  # try: try to execute a command or die
  COMMAND="$1"
  printf "[%s|%s|%s|%s]\n" "$SCRIPT_NAME" "${FUNCNAME[1]}" "${FUNCNAME[0]}" "${COMMAND}"

  $COMMAND
  RETURN="$?"
  printf "\n"

  if [[ $RETURN == "0" ]]
  then
    add "count[okay]"
  else
    add "count[crit]"
    die "$COMMAND" "$RETURN"
  fi

  return 0
}

function sum() {
  # print out the summary
  printf "[%s|%s|\
${color[okay]}okay: %s${color[default]}|\
${color[warn]}warn: %s${color[default]}|\
${color[crit]}crit: %s${color[default]}|\
${color[undef]}undef: %s${color[default]}]\n" "$SCRIPT_NAME" "${FUNCNAME[1]}" "${count[okay]}" "${count[warn]}" "${count[crit]}" "${count[undef]}"
  printf "\n"

  if [[ ${count[crit]} -gt "0" ]]
  then
    RESULT="1"
  else
    RESULT="0"
  fi

  return $RESULT
}
