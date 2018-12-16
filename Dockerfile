FROM ubuntu:17.10
MAINTAINER Mathieu Tarral <mathieu.tarral@gmail.com>

# FRAMEWORKS            |       BUILD DEPENDENCY
#-----------------------|---------------------------------
# kcodecs               |       gperf
# kservice              |       flex bison
# ki18n                 |       qtscript5-dev
# kwindowsystem         |       libqt5x11extras5-dev
# kwidgetsaddons        |       qttools5-dev
# kiconthemes           |       libqt5svg5-dev
# kwallet               |       libgcrypt20-dev
# kdeclarative          |       qtdeclarative5-dev libepoxy-dev
# kactivities           |       libboost-all-dev
# kdewebkit             |       libqt5webkit5-dev
# kdelib4support        |       libsm-dev
# khtml                 |       libgif-dev libjpeg-dev libpng-dev
# frameworkintegration  |       libxcursor-dev
# ktexteditor           |       libqt5xmlpatterns5-dev
# polkit-qt-1           |       libpolkit-agent-1-dev
# phonon-vlc            |       libvlc-dev libvlccore-dev
# phonon-gstreamer      |       libgstreamer-plugins-base1.0-dev
# akonadi               |       xsltproc
# networkmanager-qt     |       libnm-glib-dev modemmanager-dev
#-----------------------|---------------------------------

# Install dependencies
#---------------------------
# set noninteractive frontend only during build
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-key adv --recv-keys && \
    apt-get install net-tools && \
    route -n | awk '/^0.0.0.0/ {print $2}' > /tmp/host_ip.txt; nc -zv `cat /tmp/host_ip.txt` 3142 &> /dev/null && if [ $? -eq 0 ]; then echo "Acquire::http::Proxy \"http://$(cat /tmp/host_ip.txt):3142\";" > /etc/apt/apt.conf.d/30proxy; echo "Proxy detected on docker host - using for this build"; else echo "NO PROXY"; fi
RUN apt-get install -y git bzr vim g++ cmake tar doxygen && \
    apt-get install -y libwww-perl libxml-parser-perl libjson-perl libyaml-libyaml-perl dialog gettext libxrender-dev pkg-config libxcb-keysyms1-dev docbook-xsl libxslt1-dev libxml2-utils libudev-dev libqt4-dev && \
    apt-get install -y \
                        gperf \
                        flex bison \
                        qtscript5-dev \
                        libqt5x11extras5-dev \
                        qttools5-dev \
                        libqt5svg5-dev \
                        libgcrypt20-dev \
                        qtdeclarative5-dev libepoxy-dev \
                        libboost-all-dev \
                        libqt5webkit5-dev \
                        libsm-dev \
                        libgif-dev libjpeg-dev libpng-dev \
                        libxcursor-dev \
                        libqt5xmlpatterns5-dev \
                        libpolkit-agent-1-dev \
                        libvlc-dev libvlccore-dev \
                        libgstreamer-plugins-base1.0-dev \
                        xsltproc \
                        libnm-glib-dev modemmanager-dev \
                        libssl-dev \
                        libfreetype6-dev libfontconfig1-dev \
                        libbsd-dev libphonon-dev \
                        ruby libsqlite3-dev libxcomposite-dev libhyphen-dev && \
    useradd -d /home/kdedev -m kdedev

# some symlinks in /root to handle sudo ./kdesrc-build
RUN ln -s /home/kdedev/.kdesrc-buildrc /root/.kdesrc-buildrc && \
    ln -s /home/kdedev/kdesrc-build /root/kdesrc-build
# setup kdedev account
RUN apt-get install -y sudo && echo 'kdedev ALL=NOPASSWD: ALL' >> /etc/sudoers
USER kdedev
ENV HOME /home/kdedev
WORKDIR /home/kdedev/
CMD ["bash"]

RUN git config --global url."git://anongit.kde.org/".insteadOf kde: && \
    git config --global url."ssh://git@git.kde.org/".pushInsteadOf kde: && \
    git clone git://anongit.kde.org/kdesrc-build.git

RUN sudo apt-get install -y wget && \
    wget -qO- http://download.qt.io/official_releases/qt/5.11/5.11.3/single/qt-everywhere-src-5.11.3.tar.xz | tar xJ
RUN wget -qO- http://qt.mirror.constant.com/snapshots/ci/qtwebkit/5.212/1515668564/src/submodules/qtwebkit-everywhere-src-5.212.tar.xz | tar xJ

RUN cd qt-everywhere-src-5.11.3 && ./configure \
    -static \
    -release \ 
    -prefix /home/kdedev/qt-everywhere-5.11.3 \
    -qt-zlib \
    -qt-pcre \
    -qt-libpng \
    -qt-libjpeg \
    -qt-freetype \
    -opengl desktop \
    -system-freetype \
    -fontconfig \
    -openssl-linked \
    -sql-sqlite \
    -quick-designer \
    -make libs \
    -make tools \
    -nomake examples \
    -nomake tests \
    -recheck \
    -opensource \
    -confirm-license && \
make -j4 && make -j4 install
RUN cd qtwebkit-everywhere-src-5.212 && \
    cmake -DPORT=Qt -DCMAKE_BUILD_TYPE=ReleASE -DQt5_DIR=/home/kdedev/qt-everywhere-5.11.3 -DCMAKE_PREFIX_PATH=/home/kdedev/qt-everywhere-5.11.3/lib/cmake -DCMAKE_INSTALL_PREFIX=/home/kdedev/qt-everywhere-5.11.3 && \
    make -j4 && make -j4 install

RUN sudo sh -c "echo deb-src http://archive.ubuntu.com/ubuntu/ artful main restricted >> /etc/apt/sources.list && apt-get update"
RUN apt-get source libsystemd-dev && sudo apt-get build-dep -y libsystemd-dev && \
    cd systemd-234 && dpkg-buildpackage -uc -us -j8 -rfakeroot
RUN apt-get source libp11-kit-dev && sudo apt-get build-dep -y libp11-kit-dev && \
    cd p11-kit-0.23.7 && dpkg-buildpackage -uc -us -j8 -rfakeroot
ADD mesa.debian.rules.patch /home/kdedev
RUN apt-get source libgl1-mesa-dev && sudo apt-get build-dep -y libgl1-mesa-dev && \
    cd mesa-17.2.2 && patch -p0 < ../mesa.debian.rules.patch
# Ignore build error
RUN cd mesa-17.2.2 && EXPAT_LIBS=-lexpat dpkg-buildpackage -uc -us -j8 -rfakeroot; exit 0

ADD kdesrc-build.patch /home/kdedev
RUN cd kdesrc-build && patch -p1 < ../kdesrc-build.patch

RUN mkdir kde
ADD kdesrc-buildrc kde
RUN ~/kdesrc-build/kdesrc-build --verbose --rc-file=$HOME/kde/kdesrc-buildrc --src-only --include-dependencies okular

ADD git-patch.sh kde
ADD build-git-patch kde
RUN cd kde && sh git-patch.sh

RUN sudo apt-get install -y libpoppler-dev libpoppler-qt5-dev
RUN apt-get source liblcms2-dev && sudo apt-get build-dep -y liblcms2-dev && \
    cd lcms2-2.7 && dpkg-buildpackage -uc -us -j8 -rfakeroot
RUN apt-get source libnss3-dev && sudo apt-get build-dep -y libnss3-dev && \
    cd nss-3.32 && dpkg-buildpackage -uc -us -j8 -rfakeroot; exit 0

ENV KDE_STANDARD_LIBRARIES "-lqtpcre2 -licui18n -licuuc -lglib-2.0 -ldl -licudata -lqtlibpng -lqtharfbuzz -ldbus-1 /home/kdedev/systemd-234/build-deb/src/libsystemd/libsystemd.a /home/kdedev/systemd-234/build-deb/src/shared/libsystemd-shared-234.a -lssl -ldl -lgnutls -ltasn1 -lcrypto -lnettle /home/kdedev/p11-kit-0.23.7/.libs/libp11-kit-internal.a /usr/lib/x86_64-linux-gnu/libhogweed.a -lgmp -lz -lidn -ldl -lffi -lXau -lXdmcp -lxml2 -lgcrypt -lgpg-error -lxcb -lXau -lXdmcp /home/kdedev/qt-everywhere-5.11.3/plugins/platforms/libqxcb.a -lqxcb -lQt5XcbQpa -lQt5EventDispatcherSupport -lxcb-static -lQt5ThemeSupport -lQt5ServiceSupport -lltdl -lQt5FontDatabaseSupport -lfreetype -lXrender -lX11-xcb -lfontconfig -lexpat -lbsd -lQt5EdidSupport -lGL -lglapi"
RUN sudo sh -c "sudo echo \!\<arch\> > /usr/lib/x86_64-linux-gnu/libgcc_s.a"

RUN sudo apt-get install -y ccache openssh-server
RUN mkdir .ssh
ADD authorized_keys /home/kdedev/.ssh

ADD find-libraries.sh kde

RUN ~/kdesrc-build/kdesrc-build --rc-file=$HOME/kde/kdesrc-buildrc --build-only --refresh-build --include-dependencies okular; exit 0

