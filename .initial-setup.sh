#!/bin/bash

# install aqua
DIR=$(mktemp -d)
cd $DIR

wget "https://github.com/aquaproj/aqua/releases/latest/download/aqua_linux_amd64.tar.gz"
tar xvf "aqua_linux_amd64.tar.gz"
mkdir -p ~/.local/bin 2&>1 > /dev/null
cp aqua ~/.local/bin/
export PATH="$HOME/.local/bin:$PATH"

# make global config file
mkdir -p ~/.config/aqua 2&>1 > /dev/null
export AQUA_GLOBAL_CONFIG="$HOME/.config/aqua/aqua.yaml"
cd ~/.config/aqua/
aqua init

# install bitwarden
aqua up -r
aqua g -g bitwarden/clients
aqua g -g twpayne/chezmoi
aqua i -a

export PATH="$(aqua root-dir)/bin:$PATH"
echo "installed aqua and done chezmoi setup"
