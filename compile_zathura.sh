#!/bin/bash

sudo apt-get install libmagic-dev libsqlite3-dev libpoppler-dev libpoppler-glib-dev

mkdir -p $HOME/zathura
cd $HOME/zathura

dpkg -s gcc-4.9
if [[ $? -eq 1 ]]; then
    add-apt-repository ppa:ubuntu-toolchain-r/test
    apt-get update
    apt-get install gcc-4.9
    update-alternatives --remove-all gcc
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9
    update-alternatives --config gcc
fi

function install {
    if [ ! -d $1 ]; then
        git clone git://pwmt.org/$1.git
        cd $1
    else
        cd $1
        git pull
    fi
    make
    make install
    cd -
}

install girara
install zathura-pdf-poppler
install zathura
