#!/bin/bash

# install aqua
DIR=$(mktemp -d)
cd $DIR

wget "https://github.com/aquaproj/aqua/releases/latest/download/aqua_linux_amd64.tar.gz"
tar xvf "aqua_linux_amd64.tar.gz"
mkdir -p ~/.local/bin 2&>1 > /dev/null
cp aqua ~/.local/bin/
PATH="~/.local/bin:$PATH"

# make global config file
mkdir -p ~/.config/aqua 2&>1 > /dev/null
AQUA_CONFIG_PATH="~/.config/aqua/aqua.yaml"
cd ~/.config/aqua/
aqua init

# install bitwarden
aqua g -i -f $AQUA_CONFIG_PATH bitwarden/clients
aqua g -i -f $AQUA_CONFIG_PATH twpayne/chezmoi
aqua -c $AQUA_CONFIG_PATH i
