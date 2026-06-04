#!/bin/bash

# install aqua
echo "START: initial setup"

DIR=$(mktemp -d)
cd $DIR

echo "START: aqua install"
wget "https://github.com/aquaproj/aqua/releases/latest/download/aqua_linux_amd64.tar.gz"
tar xf "aqua_linux_amd64.tar.gz"
mkdir -p ~/.local/bin 2&>1 > /dev/null
cp aqua ~/.local/bin/
export PATH="$HOME/.local/bin:$PATH"
echo "DONE: aqua install"

# make global config file
echo "START: setup aqua initial config"
mkdir -p ~/.config/aqua 2&>1 > /dev/null
export AQUA_GLOBAL_CONFIG="$HOME/.config/aqua/aqua.yaml"
cd ~/.config/aqua/
aqua init
echo "DONE: setup aqua initial config"

# install essential tools
echo "START: install chezmoi with bitwarden, mise via aqua"
aqua up -r
aqua g -g -i bitwarden/clients
aqua g -g -i jdx/mise
aqua g -g -i twpayne/chezmoi
aqua i -a

export PATH="$(aqua root-dir)/bin:$PATH"
echo "DONE: install chezmoi with bitwarden, mise via aqua"

echo "START: chezmoi init"
MY_REPO="4hiziri/my-chezmoi"
bw login
chezmoi init $MY_REPO
chezmoi apply # need password of bitwarden

# linux part, for ruby, sbcl
sudo apt install libffi-dev libssl-dev libyaml-dev zlib1g-dev libzstd-dev
