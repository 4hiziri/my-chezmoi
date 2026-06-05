#!/bin/bash
ver="30.2"

sudo apt-get -y install\
     build-essential\
     gcc\
     gnutls-bin\
     gnutls-dev\
     libacl1-dev\
     libasound2-dev\
     libgccjit-dev\
     libgif-dev\
     libgnutls28-dev\
     libgpm-dev\
     libgtk-3-dev\
     libjpeg-dev\
     libm17n-dev\
     libmagickwand-dev\
     libotf-dev\
     libpng-dev
     librsvg2-dev\
     libseccomp-dev\
     libsystemd-dev\
     libtiff-dev\
     libtree-sitter-dev\
     libwebp-dev\
     libxft-dev\
     libxml2-dev\
     mailutils\
     make\
     ncurses-dev\
     pkg-config\
     texinfo\
     zlib1g-dev


cd
mkdir 'src' 2>&1 > /dev/null
cd src
wget "http://ftp.jaist.ac.jp/pub/GNU/emacs/emacs-$ver.tar.gz"
tar xvf "emacs-$ver.tar.gz"
rm -f "emacs-$ver.tar.gz"
cd "emacs-$ver"

./autogen.sh
./configure\
    --with-cairo\
    --without-x\
    --without-dbus\
    --without-gconf\
    --without-gsettings\
    --without-toolkit-scroll-bars\
    --without-xaw3d\
    --with-sound\
    --without-pop\
    --without-selinux\
    --without-gpm\
    --with-native-compilation\
    --with-gnutls\
    --with-x-toolkit=lucid\
    --with-tree-sitter
make
sudo make install
