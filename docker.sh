#!/bin/bash
set -eo pipefail

docker build --tag openwrt-compile:latest .

mkdir -p configdir dl bin

cp "$2" configdir/.config

if [ "$1" == "menuconfig" ]; then
    docker run --interactive --tty --rm \
        --volume "$( realpath ./configdir )":/openwrt/configdir \
        openwrt-compile:latest "make menuconfig V=s"

elif [ "$1" == "build" ]; then
    docker run --interactive --tty --rm \
        --volume "$( realpath ./bin )":/openwrt/bin \
        --volume "$( realpath ./dl )":/openwrt/dl \
        --volume "$( realpath ./configdir )":/openwrt/configdir \
        openwrt-compile:latest "make defconfig && make V=s -j"

elif [ "$1" == "build1" ]; then
    docker run --interactive --tty --rm \
        --volume "$( realpath ./bin )":/openwrt/bin \
        --volume "$( realpath ./dl )":/openwrt/dl \
        --volume "$( realpath ./configdir )":/openwrt/configdir \
        openwrt-compile:latest "make defconfig && make V=s -j1"

fi

cp configdir/.config "$2"


