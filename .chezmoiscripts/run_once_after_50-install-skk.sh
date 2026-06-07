#!/bin/bash

# install skk input system
sudo apt-get install -y fcitx5 fcitx5-skk

# make skk dict
mkdir -p "$HOME/src"
cd "$HOME/src"
git clone "https://github.com/skk-dev/dict"
cd dict
for JISYO in $(ls -1 | grep "SKK-JISYO.*"); do
    nkf --ic=e --oc=w8 -O $JISYO "$JISYO.utf-8"
done
cd "$HOME/src"
git clone "https://github.com/4hiziri/my-skk-dict"

DICT_NAME=SKK-JISYO.yaskkserv2
DICT_PATH="$HOME/.config/skk/"

mkdir -p $DICT_PATH
yaskkserv2_make_dictionary --utf8 --dictionary-filename="$DICT_PATH/$DICT_NAME" "$HOME/src/dict/SKK-JISYO.L.utf-8" "$HOME/src/my-skk-dict/SKK-JISYO.L.k2c.utf-8" "$HOME/src/dict/SKK-JISYO.fullname.utf-8" "$HOME/src/dict/SKK-JISYO.jinmei.utf-8" "$HOME/src/dict/SKK-JISYO.propernoun.utf-8" "$HOME/src/dict/SKK-JISYO.geo.utf-8" "$HOME/src/dict/SKK-JISYO.station.utf-8" "$HOME/src/dict/SKK-JISYO.JIS2.utf-8" "$HOME/src/dict/SKK-JISYO.assoc.utf-8" "$HOME/src/dict/SKK-JISYO.itaiji.utf-8" "$HOME/src/dict/zipcode/SKK-JISYO.zipcode.utf-8" "$HOME/src/dict/zipcode/SKK-JISYO.office.zipcode.utf-8" "$HOME/src/dict/SKK-JISYO.edict.utf-8" "$HOME/src/dict/SKK-JISYO.edict2.utf-8"

# run skk-server
systemctl --user daemon-reload
systemctl --user enable yaskkserv2
systemctl --user start yaskkserv2
