#!/bin/bash

TEMP=$(mktemp -d)
cd $TEMP

install_font() {
    cd $TEMP
    local URL=$1
    wget $URL
    unar $(basename $URL)
    local DIR=$(basename $URL '.zip')
    mkdir -p "$HOME/.local/share/fonts/${DIR}Nerd"
    for file in $(ls -1 $DIR | grep -E '(otf|ttf)'); do
        cp "$DIR/$file" "$HOME/.local/share/fonts/${DIR}Nerd"
    done
}

# cica
install_font 'https://github.com/miiton/Cica/releases/download/v5.0.3/Cica_v5.0.3.zip'

# OpenDyslexic nerd
install_font 'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/OpenDyslexic.zip'

# monofur nerd
install_font 'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Monofur.zip'

# geist mono nerd

install_font 'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/GeistMono.zip'

# BigBlueTeam nerd

install_font 'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/BigBlueTerminal.zip'

# firecode nerd

install_font 'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip'

# JetBrains Mono nerd

install_font 'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip'

# Symbol only mono nerd

install_font 'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/NerdFontsSymbolsOnly.zip'

# RobotoMono nerd

install_font 'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/RobotoMono.zip'

# font update
fc-cache -f -v

rm -rf $TEMP
