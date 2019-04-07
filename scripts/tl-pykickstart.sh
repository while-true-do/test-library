#!/usr/bin/env bash
# name: tl-pykickstart.sh
# description: Script to test kickstart files.
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
function testKsvalidator() {
  files=$(find "$WORK_PATH" -iname "*.ks")

  for file in $files
  do
    ksvalidator "$file" || RETURN="1"
  done

  return $RETURN
}

# Actions
function help() {
  # help: action to show help
  printf "\n"
  printf "Usage: %s ACTION\n" "$SCRIPT_NAME"
  printf "\n"
  printf "Script to test kickstart files.\n"
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

  try "pip install pykickstart"

  sum
}

function test() {
  # test: action to run tests
  printf "[%s|%s]\n" "$SCRIPT_NAME" "${FUNCNAME[0]}"

  run "testKsvalidator"

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
