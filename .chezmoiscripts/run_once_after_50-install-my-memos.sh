#!/bin/bash

if [ -e "$HOME/misc/study-memos" ]; then
    echo "memo is downloaded, skip"
    exit 0
fi

mkdir -p "$HOME/misc"
cd "$HOME/misc"
git clone 'git@github.com:4hiziri/study-memos'
