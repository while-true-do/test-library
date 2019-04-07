#!/usr/bin/env bash
# name: tl-ansible.sh
# description: Script to test Ansible Roles.
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

# Actions

function help() {
  # help: action to show help
  printf "\n"
  printf "Usage: %s ACTION\n" "$SCRIPT_NAME"
  printf "\n"
  printf "Script to test Ansible Roles.\n"
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

  try "pip install ansible"
  pip "install ansible-lint"
  pip "install yamllint"

  sum
}

function test() {
  # test: action to run tests
  printf "[%s|%s]\n" "$SCRIPT_NAME" "${FUNCNAME[0]}"

  run "yamllint $WORK_PATH"
  run "ansible-playbook --syntax-check $WORK_PATH/tests/test.yml"
  run "ansible-lint $WORK_PATH"

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
