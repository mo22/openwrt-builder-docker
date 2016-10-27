#!/bin/bash
set -eo pipefail

docker build --tag openwrt-builder-docker:latest .

mkdir -p dl bin

if [ "$1" == "menuconfig" ]; then
    docker run --interactive --tty --rm \
        --volume "$( realpath . )":/openwrt/configdir \
        openwrt-builder-docker:latest "make menuconfig V=s"

elif [ "$1" == "build" ]; then
    docker run --interactive --tty --rm \
        --volume "$( realpath ./bin )":/openwrt/bin \
        --volume "$( realpath ./dl )":/openwrt/dl \
        --volume "$( realpath . )":/openwrt/configdir \
        openwrt-builder-docker:latest "make defconfig && make V=s -j"

elif [ "$1" == "build1" ]; then
    docker run --interactive --tty --rm \
        --volume "$( realpath ./bin )":/openwrt/bin \
        --volume "$( realpath ./dl )":/openwrt/dl \
        --volume "$( realpath . )":/openwrt/configdir \
        openwrt-builder-docker:latest "make defconfig && make V=s -j1"

fi

