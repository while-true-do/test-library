#!/usr/bin/env bash
# name: tl-spelling.sh
# description: Script to test speeling.
# author: while-true-do.io
# license: BSD-3-Clause

# shellcheck disable=SC1091,SC2034

# Variables
SCRIPT_NAME=$(basename "$0")
SCRIPT_PATH=$(dirname "${BASH_SOURCE[0]}")
WORK_PATH=$(pwd)
# shellcheck source=_lib.sh
source "$SCRIPT_PATH/_lib.sh"

# Complex
function installAspell() {
  sudo dnf -y install aspell-en ||\
  sudo yum -y install aspell-en ||\
  sudo apt -y install aspell-en ||\
  sudo zypper -n install aspell-en

  RETURN=$?
  return $RETURN
}

function testAspellTxt() {
  files=$(find "$WORK_PATH" \( -iname "*.txt" ! -iname "kudos.txt" \) )

  echo "$SCRIPT_PATH/.tl-aspell"
  for file in $files
  do
    BADWORDS=""
    BADWORDS=$(aspell --personal="$WORK_PATH"/.aspell.en.pws --lang=en --encoding=utf-8 list < "$file" | sort -u)
    if [[ -n $BADWORDS ]]
    then
      printf "file: %s\n" "$file"
      printf "%s\n" "$BADWORDS"
      RETURN="1"
    fi
  done

  return $RETURN
}

function testAspellMd() {
  files=$(find "$WORK_PATH" -iname "*.md")

  for file in $files
  do
    BADWORDS=""
    BADWORDS=$(aspell --personal="$WORK_PATH"/.aspell.en.pws --lang=en --encoding=utf-8 list < "$file" | sort -u)
    if [[ -n $BADWORDS ]]
    then
      printf "file: %s\n" "$file"
      printf "%s\n" "$BADWORDS"
      RETURN="1"
    fi
  done

  return $RETURN
}

function help() {
  # help: action to show help
  printf "\n"
  printf "Usage: %s ACTION\n" "$SCRIPT_NAME"
  printf "\n"
  printf "Script to test speeling.\n"
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

  try "installAspell"

  sum
}

function test() {
  # test: action to run tests
  printf "[%s|%s]\n" "$SCRIPT_NAME" "${FUNCNAME[0]}"

  run "testAspellTxt"
  run "testAspellMd"

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
