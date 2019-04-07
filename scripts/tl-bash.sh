#!/usr/bin/env bash
# name: tl-bash.sh
# description: Script to test Shell Scripts.
# author: while-true-do.io
# license: BSD-3-Clause

# shellcheck disable=SC1091,SC2034

# Variables
SCRIPT_NAME=$(basename "$0")
SCRIPT_PATH=$(dirname "${BASH_SOURCE[0]}")
WORK_PATH=$(pwd)
# shellcheck source=_lib.sh
source "$SCRIPT_PATH/_lib.sh"

# Complex tests
function instShellcheck() {
  sudo dnf -y install ShellCheck ||\
  sudo yum -y install ShellCheck ||\
  sudo apt-get update ||\
  sudo apt-get -y install shellcheck ||\
  sudo zypper -n install ShellCheck

  return $?
}

function testShellcheck() {
  files=$(find "${WORK_PATH}" -iname \*.sh)

  for file in $files
  do
    shellcheck -x "$file" || RETURN="1"
  done

  return $RETURN
}

# Actions
function help() {
  # help: action to show help
  printf "\n"
  printf "Usage: %s ACTION\n" "$SCRIPT_NAME"
  printf "\n"
  printf "Testing Shell Scripts.\n"
  printf "\n"
  printf "Actions:\n"
  printf "\t help) Show the help\n"
  printf "\t prep) Run all preparations\n"
  printf "\t test) Run all tests\n"
  printf "\n"
}

function prep() {
  # test: action to do preparations
  printf "[%s|%s]\n" "$SCRIPT_NAME" "${FUNCNAME[0]}"

  try "instShellcheck"

  sum
}

function test() {
  # test: action to run tests
  printf "[%s|%s]\n" "$SCRIPT_NAME" "${FUNCNAME[0]}"

  run "testShellcheck"

  sum
}

# Main
if [[ -n "$*" ]]
then
  ACTION="$1"
  shift
  $ACTION "$@"
else
  help
fi
