#!/bin/bash

TEMP=$(mktemp -d)
cd $TEMP

install_font() {
    cd $TEMP
    local URL=$1
    local DIR=$(basename $URL '.zip')
    if [ -e "$HOME/.local/share/fonts/${DIR}" ]; then
        echo "${DIR} installed, skip"
        return 0
    fi
    wget $URL
    unar $(basename $URL)
    mkdir -p "$HOME/.local/share/fonts/${DIR}"
    for file in $(ls -1 $DIR | grep -E '(otf|ttf)'); do
        cp "$DIR/$file" "$HOME/.local/share/fonts/${DIR}"
    done
}

install_nerd_font() {
    cd $TEMP
    local URL=$1
    local DIR=$(basename $URL '.zip')
    if [ -e "$HOME/.local/share/fonts/${DIR}Nerd" ]; then
        echo "${DIR} Nerd installed, skip"
        return 0
    fi
    wget $URL
    unar $(basename $URL)
    mkdir -p "$HOME/.local/share/fonts/${DIR}Nerd"
    for file in $(ls -1 $DIR | grep -E '(otf|ttf)'); do
        cp "$DIR/$file" "$HOME/.local/share/fonts/${DIR}Nerd"
    done
}

# cica
install_font 'https://github.com/miiton/Cica/releases/download/v5.0.3/Cica_v5.0.3.zip'

# OpenDyslexic nerd
install_nerd_font 'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/OpenDyslexic.zip'

# monofur nerd
install_nerd_font 'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Monofur.zip'

# geist mono nerd

install_nerd_font 'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/GeistMono.zip'

# BigBlueTeam nerd

install_nerd_font 'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/BigBlueTerminal.zip'

# firecode nerd

install_nerd_font 'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip'

# JetBrains Mono nerd

install_nerd_font 'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip'

# Symbol only mono nerd

install_nerd_font 'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/NerdFontsSymbolsOnly.zip'

# RobotoMono nerd

install_nerd_font 'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/RobotoMono.zip'

# font update
fc-cache -f -v

rm -rf $TEMP
