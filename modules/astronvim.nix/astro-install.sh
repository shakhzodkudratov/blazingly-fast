#! /bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

function _remove() {
  # Don't delete the lock file
  rm -rf ~/.config/nvim/lua
  rm -rf ~/.config/nvim/init.lua
}

function _replace() {
  rsync -a "$SCRIPT_DIR/src/ ~/.config/nvim"
}

case $1 in
--remove-only)
  _remove
  ;;
*)
  _remove
  _replace
  ;;
esac
