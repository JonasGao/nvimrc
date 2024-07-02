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
  mkdir -p $HOME/.local/share/nvim/site/pack/packer/start
  git clone --depth 1 https://github.com/wbthomason/packer.nvim $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim
}

cargo_install() {
  REPO=$1; CMD=$2
  [ -z "$GITHUB_HOME" ] && [ -d "$HOME/github" ] && GITHUB_HOME="$HOME/github"
  [ -z "$GITHUB_HOME" ] && [ -d "$HOME/Github" ] && GITHUB_HOME="$HOME/Github"
  [ -z "$GITHUB_HOME" ] && mkdir -p "$HOME/github" ] && GITHUB_HOME="$HOME/github"
  if ! command -v "$CMD" &> /dev/null; then
    echo "Install $CMD..."
    pushd "$GITHUB_HOME" || exit 8
    [ ! -d "$CMD" ] && git clone $REPO $CMD
    pushd "$GITHUB_HOME/$CMD" || exit 8
    cargo build --release
    install target/release/$CMD /usr/local/bin
    popd || exit 9
    popd || exit 9
  fi
}

install_dependencies() {
  #$PACKER install ripgrep cmake gcc bat fd
  #Case my mackbook is too old, homebrew not support install these tools
  #echo "Please manually install tools: ripgrep and fd, bat"
  #echo "Please install compile dependencies: cmake & gcc"
  command -v cargo &> /dev/null \
    || (echo -e "\033[31mInstall failure. Install ripgrep/fd/bat need rust&cargo.\033[0m" \
    && echo -e "\033[33mInstall rust by \"curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh\"\033[0m" \
    && exit 7)
  cargo_install https://github.com/sharkdp/fd fd
  cargo_install https://github.com/BurntSushi/ripgrep rg
  command -v bat &> /dev/null || cargo install --locked bat #https://github.com/sharkdp/bat.git
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
