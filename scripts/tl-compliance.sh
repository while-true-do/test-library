#!/usr/bin/env bash
# name: tl-comlpiance.sh
# description: Script to check for repository compliance.
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
files=".editorconfig .gitignore .gitattributes .gitmessage LICENSE README.md kudos.txt"

function testExistence() {
    # Test, if templates from doc-library are used.
    RETURN="0"

    for file in ${files}
    do
      if [[ ! -f $file ]]
      then
        echo "Missing file: $file"
        RETURN="1"
      fi
    done

    return $RETURN
}

function testTemplateLeftovers() {
  # Test, if files from doc-library/templates are maintained.
  RETURN="0"

  for file in ${files}
  do
    grep -H -n "{{ WTD_REPO_NAME }}" "$WORK_PATH/$file" && RETURN="1"
    grep -H -n "TODO:" "$WORK_PATH/$file" && RETURN="1"
  done

  return $RETURN
}

# Actions
function help() {
  # help: action to show help
  printf "\n"
  printf "Usage: %s ACTION\n" "$SCRIPT_NAME"
  printf "\n"
  printf "Script to check for repository compliance.\n"
  printf "\n"
  printf "Actions:\n"
  printf "\t help) Show the help\n"
  printf "\t test) Run all tests\n"
  printf "\n"
}

function test() {
  # test: action to run tests
  printf "[%s|%s]\n" "$SCRIPT_NAME" "${FUNCNAME[0]}"

  run "testExistence"
  run "testTemplateLeftovers"

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
