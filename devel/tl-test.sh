#!/usr/bin/env bash
# name: <TODO: NAME>
# description: <TODO: DESCRIPTION>
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
# TODO: Add steps or delete functions.
function comp() {
  echo "I am a complex task with some globbing or so."
}

# Actions
function conf() {
  # conf: action to do configurations
  # TODO: Add steps or delete action.
  printf "[%s|%s]\n" "$SCRIPT_NAME" "${FUNCNAME[0]}"

  run "true"

  sum
}

function help() {
  # help: action to show help
  # TODO: Help is mandatory and needs to be maintained.
  printf "\n"
  printf "Usage: %s ACTION\n" "$SCRIPT_NAME"
  printf "Usage: %s ACTION [--OPTION]\n" "$SCRIPT_NAME"
  printf "\n"
  printf "<DESCRIPTION>\n"
  printf "\n"
  printf "Actions:\n"
  printf "\t help) Show the help\n"
  printf "\t prep) Run all preparations\n"
  printf "\t test) Run all tests\n"
  printf "\n"
  printf "Options:\n"
  printf "\t --help) Show the help for an ACTION\n"
  printf "\n"
}

function post() {
  # post: action to do post operations like cleaning up
  # TODO: Add steps or delete action.
  printf "[%s|%s]\n" "$SCRIPT_NAME" "${FUNCNAME[0]}"

  run "true"

  sum
}

function prep() {
  # test: action to do preparations
  # TODO: Add steps or delete action.
  printf "[%s|%s]\n" "$SCRIPT_NAME" "${FUNCNAME[0]}"

  try "true"
  try "false"

  sum
}

function pull() {
  # pull: action to update/pull additional content
  # TODO: Add steps or delete action.
  printf "[%s|%s]\n" "$SCRIPT_NAME" "${FUNCNAME[0]}"
}

function test() {
  # test: action to run tests
  # TODO: Add steps or delete action.
  printf "[%s|%s]\n" "$SCRIPT_NAME" "${FUNCNAME[0]}"

  run "true"
  run "false"

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
