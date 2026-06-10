#!/bin/bash

GREEN="\e[0;32m"
RED="\e[0;31m"
CLEAR="\033[0m"

ebegin() {
  last_emsg="$*"
  echo -e "${GREEN}$1${CLEAR}" >&2
}

eend() {
  if [ "$1" = 0 ] || [ $# -lt 1 ]; then
    echo -e "${GREEN}$last_emsg: ok${CLEAR}" >&2
  else
    shift
    echo -e "${RED}$last_emsg: failed. $*${CLEAR}" >&2
    echo "Error, exit"
    /bin/bash
  fi
}

# install aqua
ebegin "APT update"
sudo apt update && sudo apt upgrade -y
eend $?

ebegin "Install etckeeper"
sudo apt install etckeeper
eend $?

DIR=$(mktemp -d)
cd $DIR

ebegin "Install aqua"
wget "https://github.com/aquaproj/aqua/releases/latest/download/aqua_linux_amd64.tar.gz"
tar xf "aqua_linux_amd64.tar.gz"
mkdir -p ~/.local/bin 2&>1 > /dev/null
cp aqua ~/.local/bin/
export PATH="$HOME/.local/bin:$PATH"
eend $?

ebegin "Setup aqua initial config"
mkdir -p ~/.config/aqua 2&>1 > /dev/null
export AQUA_GLOBAL_CONFIG="$HOME/.config/aqua/aqua.yaml"
cd ~/.config/aqua/
aqua init
eend $?

ebegin "Install chezmoi with bitwarden, mise via aqua"
aqua up -r
aqua g -g -i bitwarden/clients
aqua g -g -i jdx/mise
aqua g -g -i twpayne/chezmoi
aqua i -a
eend $?

ebegin "Login bitwarden"
export BW_SESSION=$(bw login --raw)
eend $?

ebegin "Set github token"
export GITHUB_TOKEN=$(bw get notes "github token")
eend $?

export PATH="$(aqua root-dir)/bin:$PATH"

ebegin "Deploy mise dotfiles"
MY_REPO="4hiziri/my-chezmoi"
chezmoi init $MY_REPO
chezmoi apply "~/.config/mise/config.toml"
eend $?

ebegin "Install mise tools"
sudo apt install -y libffi-dev libssl-dev libyaml-dev zlib1g-dev libzstd-dev
mise plugin add sbcl https://github.com/mise-plugins/mise-sbcl
mise --raw install # for sbcl build, need raw input/output
eend $?

ebegin "Deploy all dotfiles"
chezmoi apply
eend $?

ebegin "Change shell"
chsh $(whoami) -s /bin/zsh
eend $?

cd ~

exec zsh
