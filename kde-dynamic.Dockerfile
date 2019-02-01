FROM voidlinux/voidlinux-musl
MAINTAINER Jonathan Schultz <jonathan@schultz.la>

# Use Australian mirror site
RUN cp /usr/share/xbps.d/*repository* /etc/xbps.d && sed -i -e 's|alpha.de.repo.voidlinux.org|mirror.aarnet.edu.au/pub/voidlinux|g' /etc/xbps.d/*repository*
RUN xbps-install --update --sync --yes

# Set up proxy
COPY myCA.pem /usr/share/ca-certificates
RUN chmod go+r /usr/share/ca-certificates/myCA.pem
RUN echo myCA.pem >> /etc/ca-certificates.conf && update-ca-certificates
ENV ftp_proxy http://172.17.0.1:3128
ENV http_proxy http://172.17.0.1:3128
ENV https_proxy http://172.17.0.1:3128

# Create kdedev user
RUN xbps-install --yes sudo && echo 'kdedev ALL=NOPASSWD: ALL' >> /etc/sudoers && echo 'Defaults env_keep += "ftp_proxy http_proxy https_proxy"' >> /etc/sudoers
RUN useradd kdedev
USER kdedev
WORKDIR /home/kdedev
CMD bash

# Get voidlinux ready for building
RUN sudo xbps-install --yes xtools
RUN git clone --depth 1 https://github.com/jschultz/void-packages
RUN cd void-packages && sed -i -e 's|alpha.de.repo.voidlinux.org|mirror.aarnet.edu.au/pub/voidlinux|g' etc/* && \
	./xbps-src binary-bootstrap

# Install patched version of proot
COPY repo/* /home/kdedev/void-packages/hostdir/binpkgs/
RUN sudo xbps-install --repository=void-packages/hostdir/binpkgs --yes proot
RUN echo XBPS_CHROOT_CMD=proot >> void-packages/etc/conf

RUN sudo xbps-install --yes \
        base-devel MesaLib-devel freetype-devel fontconfig-devel libressl-devel \
        cmake gperf ruby sqlite-devel libjpeg-turbo-devel icu-devel libxml++-devel libxslt-devel \
        libXcomposite-devel libXrender-devel gstreamer1-devel gst-plugins-base1-devel hyphen-devel libexecinfo-devel \
        libSM-devel attr-devel wayland-devel lmdb-devel giflib-devel ModemManager-devel NetworkManager-devel \
        exiv2-devel qrencode-devel libopenjpeg2-devel  lcms2-devel \
		ccache polkit-devel phonon-devel docbook-xml docbook-xsl libgcrypt-devel boost-devel intltool

# Install built packages
RUN sudo xbps-install --yes fontconfig-devel dbus-devel icu-devel libxslt-devel libgpg-error-devel libxcb-devel xcb-util-keysyms-devel libxml2-devel libglapi libGL libEGL libGLES libOSMesa libllvm7 poppler-devel poppler-qt5-devel

# Download, patch and build QT everywhere, QT webkit and friends, then delete sources
RUN sudo xbps-install -y wget xz libaccounts-glib-devel doxygen
COPY qt.musl.patch /home/kdedev
# COPY execinfo.h.patch /home/kdedev
COPY config.opt /home/kdedev
RUN sudo sh -c 'printf -- "-release\n" >> config.opt'
COPY libaccounts.patch /home/kdedev
COPY signon.patch /home/kdedev
RUN wget -qO- http://download.qt.io/official_releases/qt/5.11/5.11.3/single/qt-everywhere-src-5.11.3.tar.xz | tar xJ && \
	patch -d ~/qt-everywhere-src-5.11.3 -p0 < ~/qt.musl.patch && \
	wget -qO- https://raw.githubusercontent.com/gentoo/libressl/master/dev-qt/qtnetwork/files/qtnetwork-5.11.3-libressl-2.8.patch | patch -d ~/qt-everywhere-src-5.11.3/qtbase -p1 && \
    mv ~/config.opt ~/qt-everywhere-src-5.11.3 && \
	cd ~/qt-everywhere-src-5.11.3 && ./configure -redo && make -j4 -Oline && make -j4 install && \
	cd ~ && rm -r ~/qt-everywhere-src-5.11.3 && \
	export PATH=/home/kdedev/qt-everywhere-5.11.3/bin:$PATH && \
	wget -qO- http://download.qt.io/snapshots/ci/qtwebkit/5.212/1515668564/src/submodules/qtwebkit-everywhere-src-5.212.tar.xz | tar xJ && \
	cd qtwebkit-everywhere-src-5.212 && \
    cmake -DPORT=Qt -DCMAKE_BUILD_TYPE=Release -DQt5_DIR=/home/kdedev/qt-everywhere-5.11.3 -DCMAKE_PREFIX_PATH=/home/kdedev/qt-everywhere-5.11.3/lib/cmake -DCMAKE_INSTALL_PREFIX=/home/kdedev/qt-everywhere-5.11.3 -DENABLE_SAMPLING_PROFILER=0 -DUSE_THIN_ARCHIVES=OFF && \
    make -j4 && make -j4 install && \
    cd ~ && rm -r ~/qtwebkit-everywhere-src-5.212 && \
	wget -qO- https://gitlab.com/accounts-sso/libaccounts-qt/-/archive/master/libaccounts-qt-master.tar.gz | tar xz &&\
	cd ~/libaccounts-qt-master && \
    patch -p0 < /home/kdedev/libaccounts.patch && \
    qmake PREFIX=/home/kdedev/qt-everywhere-5.11.3 && \
    make -j4 -Oline && make -j4 install && \
    cd ~ && rm -r ~/libaccounts-qt-master && \
	wget -qO- https://gitlab.com/accounts-sso/signond/-/archive/master/signond-master.tar.gz | tar xz && \
	cd ~/signond-master && \
    patch -p0 < /home/kdedev/signon.patch && \
    qmake PREFIX=/home/kdedev/qt-everywhere-5.11.3 && \
    make -j4 -Oline && make -j4 install && \
    cd ~ && rm -r ~/signond-master

# Make path change permanent
ENV PATH /home/kdedev/qt-everywhere-5.11.3/bin:$PATH

# Install kdesrc-build
RUN sudo xbps-install -y git perl-YAML-LibYAML
RUN git clone git://anongit.kde.org/kdesrc-build.git

# Make empty library since build process will try to link with it
RUN sudo sh -c "echo \!\<arch\> > /usr/lib/libgcc_s.a"

# Install some fonts
RUN sudo xbps-install --yes dejavu-fonts-ttf

# Prepare the KDE build
RUN mkdir kde

# And some useful stuff for later on
COPY build-git-patch kde
RUN sudo xbps-install --yes bash ncurses-term vim
COPY .bashrc /home/kdedev

RUN sudo xbps-install -y openssh && sudo ssh-keygen -A
RUN mkdir .ssh
COPY authorized_keys /home/kdedev/.ssh

# Get KDE sources - moved to script to avoid constantly downloading them
# RUN ~/kdesrc-build/kdesrc-build --verbose --rc-file=$HOME/kde/kdesrc-buildrc-sources --src-only --include-dependencies frameworks
# RUN ~/kdesrc-build/kdesrc-build --verbose --rc-file=$HOME/kde/kdesrc-buildrc-sources --src-only --includeokular
