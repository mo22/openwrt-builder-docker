#!/bin/sh
if [ -d configdir ]; then
    cp configdir/.config .config
    chown openwrt .config
fi
# if mounted
[ -d build_dir ] && chmod 777 build_dir
[ -d staging_dir ] && chmod 777 staging_dir
[ -d dl ] && chmod 777 dl
[ -d bin ] && chmod 777 bin
sudo -u openwrt -i sh -c "$*"
if [ -d configdir ]; then
    cp .config configdir/.config
fi

