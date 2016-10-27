FROM ubuntu:xenial

ENV DEBIAN_FRONTEND noninteractive

RUN \
    apt-get update && \
    apt-get install -y \
        build-essential \
        subversion \
        libncurses5-dev \
        zlib1g-dev \
        gawk \
        flex \
        git-core \
        gettext \
        libssl-dev \
        unzip \
        gcc-multilib \
        wget \
        python2.7 \
        sudo

RUN \
    useradd --no-create-home --home-dir /openwrt openwrt && \
    echo 'openwrt ALL=NOPASSWD: ALL' > /etc/sudoers.d/openwrt && \
    mkdir -p /openwrt && \
    chown openwrt /openwrt

WORKDIR /openwrt/

RUN sudo -i -u openwrt git clone git://github.com/openwrt/openwrt.git /openwrt
RUN sudo -i -u openwrt git checkout v15.05.1
RUN sudo -i -u openwrt ./scripts/feeds update -a
RUN sudo -i -u openwrt ./scripts/feeds install -a

RUN sudo -i -u openwrt make defconfig

COPY start.sh /start.sh
ENTRYPOINT [ "/start.sh" ]

