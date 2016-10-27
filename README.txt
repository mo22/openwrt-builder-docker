docker image for building openwrt images

see Dockerfile for openwrt tag

usage:

    # run menuconfig - the container will copy the .config file from the configdir if it exists
    docker run -it -v "$( realpath . )":/openwrt/configdir openwrt-builder-docker:latest make menuconfig

    # build it - the container will store output in bin and keep downloaded files in dl
    docker run -it -v "$( realpath . )":/openwrt/configdir -v "$( realpath ./bin )":/openwrt/bin -v "$( realpath ./dl )":/openwrt/dl openwrt-builder-docker:latest make V=s -j

