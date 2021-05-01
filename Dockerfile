FROM ubuntu:20.04

RUN sed -i.bak -r 's!http://(security|archive).ubuntu.com/ubuntu!http://ftp.riken.jp/Linux/ubuntu!' /etc/apt/sources.list \
        && apt update \
        && DEBIAN_FRONTEND=noninteractive apt install -y xserver-xorg

# RUN apt install -y wget gnupg \
#         && wget -q https://www.ubuntulinux.jp/ubuntu-ja-archive-keyring.gpg -O- | apt-key add - \
#         && wget -q https://www.ubuntulinux.jp/ubuntu-jp-ppa-keyring.gpg -O- | apt-key add - \
#         && wget https://www.ubuntulinux.jp/sources.list.d/bionic.list -O /etc/apt/sources.list.d/ubuntu-ja.list \
#         && apt update \
#         && apt install -y ubuntu-defaults-ja ibus-anthy

RUN apt install -y dbus-x11 x11-xserver-utils language-pack-ja fonts-noto
RUN apt install -y fcitx-anthy

# RUN sed -i '$a export DISPLAY=host.docker.internal:0' ~/.bashrc \
#         && echo 'export GTK_IM_MODULE=ibus' >> ~/.bashrc \
#         && echo 'export QT_IM_MODULE=ibus' >> ~/.bashrc \
#         && echo 'export XMODIFIERS=@im=ibus' >> ~/.bashrc \
#         && echo 'export LANG=ja_JP.UTF-8' >> ~/.bashrc \
#         && update-locale LANG=ja_JP.UTF-8

RUN sed -i '$a export DISPLAY=host.docker.internal:0' ~/.bashrc \
        && echo 'export GTK_IM_MODULE=fcitx' >> ~/.bashrc \
        && echo 'export QT_IM_MODULE=fcitx' >> ~/.bashrc \
        && echo 'export XMODIFIERS=@im=fcitx' >> ~/.bashrc \
        && echo 'export LANG=ja_JP.UTF-8' >> ~/.bashrc \
        && update-locale LANG=ja_JP.UTF-8

# RUN apt install -y firefox
