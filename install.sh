#!/bin/bash

NVIM_CONF_HOME="$HOME/.config/nvim"
PACK_HOME="$NVIM_CONF_HOME/pack"
PACK_START="$PACK_HOME/dist/start"
SCRIPT_NAME="$0"
[ -z "$PACKER" ] && PACKER="pacman"

usage() {
  printf """Usage: $SCRIPT_NAME [-apdh]
  a all
  p packer
  d dependencies
  b build telescope fzf
  """ >&2
  exit 2
}

set_variable() {
  local varname=$1
  shift
  if [ -z "${!varname}" ]; then
    eval "$varname=\"$@\""
  else
    echo "Error: $varname already set" >&2
    exit 3
  fi
}

install_packer() {
  D="$PACK_START/packer.nvim"
  if [ -d "$D" ]
  then
    printf "\033[0;33mPacker already exists.\033[0m\n"
    exit 4
  fi
  git clone https://github.com/wbthomason/packer.nvim "$D"
}

install_dependencies() {
  #$PACKER install ripgrep cmake gcc bat fd
  #Case my mackbook is too old, homebrew not support install these tools
  echo "Please manually install tools: ripgrep and fd, bat"
  echo "Please install compile dependencies: cmake & gcc"
}

build_telescope_fzf() {
  pushd "$HOME/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim" || exit 5
  cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build
  popd || exit 6
}

###########################
# Main script starts here

unset ACTION
while getopts "apdb?h" OPT
do
  case "$OPT" in
    a) set_variable ACTION all ;;
    p) set_variable ACTION install_packer ;;
    d) set_variable ACTION install_dependencies ;;
    b) set_variable ACTION build_telescope_fzf ;;
    h|?) usage ;;
  esac
done

[ -z "$ACTION" ] && usage

eval "$ACTION"
