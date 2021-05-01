FROM ubuntu:20.04

RUN set -xe \
    \
    && sed -i.bak -r 's!http://(security|archive).ubuntu.com/ubuntu!http://ftp.riken.jp/Linux/ubuntu!' /etc/apt/sources.list \
        && apt update \
        && DEBIAN_FRONTEND=noninteractive apt install -y xserver-xorg \
        && apt install -y fcitx-anthy language-pack-ja fonts-noto dbus-x11 x11-xserver-utils \
        && apt install -y wget curl fuse git \
        && apt clean \
        && rm -rf /var/lib/apt/lists/*

RUN sed -i '$a export DISPLAY=host.docker.internal:0' ~/.bashrc \
        && echo 'export GTK_IM_MODULE=fcitx' >> ~/.bashrc \
        && echo 'export QT_IM_MODULE=fcitx' >> ~/.bashrc \
        && echo 'export XMODIFIERS=@im=fcitx' >> ~/.bashrc \
        && echo 'export LANG=ja_JP.UTF-8' >> ~/.bashrc \
        && update-locale LANG=ja_JP.UTF-8

WORKDIR /root
RUN wget https://raw.githubusercontent.com/nagygergo/jetbrains-toolbox-install/master/jetbrains-toolbox.sh \
        &&chmod u+x jetbrains-toolbox.sh \
        && ./jetbrains-toolbox.sh

# IJ系のキャッシュをvolumeに配置
RUN mkdir -p /ij_cache/.cache \
    && mkdir /ij_cache/.config \
    && mkdir /ij_cache/.java \
    && mkdir /ij_cache/.jdks \
    && mkdir /ij_cache/.local \
    && mkdir /ij_cache/.sbt \
    && mkdir /ij_cache/.ivy2 \
    && ln -s /ij_cache/.cache ~/.cache \
    && ln -s /ij_cache/.config ~/.config \
    && ln -s /ij_cache/.java ~/.java \
    && ln -s /ij_cache/.jdks ~/.jdks \
    && ln -s /ij_cache/.local ~/.local \
    && ln -s /ij_cache/.sbt ~/.sbt \
    && ln -s /ij_cache/.ivy2 ~/.ivy2 

RUN mkdir -p /IdeaProjects \
    && ln -s /IdeaProjects ~/IdeaProjects

VOLUME [ "/ij_cache", "/IdeaProjects" ]
