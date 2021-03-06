FROM voidlinux/voidlinux-musl
MAINTAINER Jonathan Schultz <jonathan@schultz.la>

# Save proxy for use after build - watch for secrets!
ENV http_proxy  $http_proxy
ENV https_proxy $https_proxy
ENV ftp_proxy   $ftp_proxy

# Copy certificate
ARG certificate
COPY $certificate /usr/share/ca-certificates
RUN chmod go+r /usr/share/ca-certificates/$certificate
RUN echo $certificate >> /etc/ca-certificates.conf && update-ca-certificates

# Change mirror
ARG mirror
ENV mirror ${mirror:-alpha.de.repo.voidlinux.org}
RUN cp /usr/share/xbps.d/*repository* /etc/xbps.d && sed -i -e "s|alpha.de.repo.voidlinux.org|$mirror|g" /etc/xbps.d/*repository*

# Need to do sync/update in two stages because xbps needs to be update before remaining packages
RUN xbps-install --sync --yes xbps
RUN xbps-install --update --yes

# Create kdedev user
RUN xbps-install --yes sudo && echo 'kdedev ALL=NOPASSWD: ALL' >> /etc/sudoers && echo 'Defaults env_keep += "ftp_proxy http_proxy https_proxy"' >> /etc/sudoers
RUN useradd kdedev
USER kdedev
WORKDIR /home/kdedev
CMD bash

# Get voidlinux ready for building
RUN sudo xbps-install --yes xtools
RUN git clone --depth 1 https://github.com/jschultz/void-packages
COPY binpkgs/* /home/kdedev/void-packages/hostdir/binpkgs/
RUN sudo chown -R kdedev.kdedev /home/kdedev/void-packages/hostdir
RUN sudo xbps-install --repository=void-packages/hostdir/binpkgs --yes proot
RUN echo XBPS_CHROOT_CMD=proot >> void-packages/etc/conf

RUN cd void-packages && sed -i -e "s|alpha.de.repo.voidlinux.org|$mirror|g" etc/* && \
	./xbps-src binary-bootstrap

RUN sudo xbps-install --yes \
        base-devel MesaLib-devel freetype-devel fontconfig-devel libressl-devel \
        cmake gperf ruby sqlite-devel libjpeg-turbo-devel icu-devel libxml++-devel libxslt-devel \
        libXcomposite-devel libXrender-devel gstreamer1-devel gst-plugins-base1-devel hyphen-devel libexecinfo-devel \
        libSM-devel attr-devel wayland-devel lmdb-devel giflib-devel ModemManager-devel NetworkManager-devel \
        exiv2-devel qrencode-devel libopenjpeg2-devel  lcms2-devel \
		ccache polkit-devel phonon-devel docbook-xml docbook-xsl libgcrypt-devel boost-devel intltool


# Rebuild xbps because of redirection problem: https://github.com/voidlinux/xbps/issues/295
# RUN if ! ls >/dev/null 2>&1 void-packages/hostdir/binpkgs/xbps-*.xbps ; then cd void-packages && ./xbps-src pkg -j4 xbps; fi
# RUN sudo xbps-install --repository=/home/kdedev/void-packages/hostdir/binpkgs --force --yes xbps libxbps
# RUN sudo sh -c "echo repository=/home/kdedev/void-packages/hostdir/binpkgs > /etc/xbps.d/00-repository-local.conf"

# Now update build packages to pick up fixed xbps
# RUN cp -r /home/kdedev/void-packages/hostdir/binpkgs void-packages/masterdir/host && cd void-packages && ./xbps-src zap && ./xbps-src binary-bootstrap

# Build packages
RUN if ! ls >/dev/null 2>&1 void-packages/hostdir/binpkgs/libglib-devel-*.xbps;          then cd void-packages && ./xbps-src pkg     libglib-devel; fi
RUN if ! ls >/dev/null 2>&1 void-packages/hostdir/binpkgs/fontconfig-devel-*.xbps;       then cd void-packages && ./xbps-src pkg -j4 fontconfig-devel; fi
RUN if ! ls >/dev/null 2>&1 void-packages/hostdir/binpkgs/dbus-devel-*.xbps;             then cd void-packages && ./xbps-src pkg -j4 dbus-devel; fi
RUN if ! ls >/dev/null 2>&1 void-packages/hostdir/binpkgs/icu-devel-*.xbps;              then cd void-packages && ./xbps-src pkg -j4 icu-devel; fi
RUN if ! ls >/dev/null 2>&1 void-packages/hostdir/binpkgs/libxslt-devel-*.xbps;          then cd void-packages && ./xbps-src pkg -j4 libxslt-devel; fi
RUN if ! ls >/dev/null 2>&1 void-packages/hostdir/binpkgs/libgpg-error-devel-*.xbps;     then cd void-packages && ./xbps-src pkg -j4 libgpg-error-devel; fi
RUN if ! ls >/dev/null 2>&1 void-packages/hostdir/binpkgs/libxcb-devel-*.xbps;           then cd void-packages && ./xbps-src pkg -j4 libxcb-devel; fi
RUN if ! ls >/dev/null 2>&1 void-packages/hostdir/binpkgs/xcb-util-keysyms-devel-*.xbps; then cd void-packages && ./xbps-src pkg -j4 xcb-util-keysyms-devel; fi
RUN if ! ls >/dev/null 2>&1 void-packages/hostdir/binpkgs/libxml2-devel-*.xbps;          then cd void-packages && ./xbps-src pkg -j4 libxml2-devel; fi
RUN if ! ls >/dev/null 2>&1 void-packages/hostdir/binpkgs/libglapi-*.xbps;               then cd void-packages && ./xbps-src pkg     libglapi; fi # Fails with -j4
RUN if ! ls >/dev/null 2>&1 void-packages/hostdir/binpkgs/libllvm7-*.xbps;               then cd void-packages && ./xbps-src pkg -j4 libllvm7; fi
RUN if ! ls >/dev/null 2>&1 void-packages/hostdir/binpkgs/poppler-devel-*.xbps;          then cd void-packages && ./xbps-src pkg     poppler-devel; fi
RUN if ! ls >/dev/null 2>&1 void-packages/hostdir/binpkgs/poppler-qt5-devel-*.xbps;      then cd void-packages && ./xbps-src pkg -j4 poppler-qt5-devel; fi
RUN if ! ls >/dev/null 2>&1 void-packages/hostdir/binpkgs/wayland-*.xbps;                then cd void-packages && ./xbps-src pkg -j4 wayland; fi
RUN if ! ls >/dev/null 2>&1 void-packages/hostdir/binpkgs/qrencode-*.xbps;               then cd void-packages && ./xbps-src pkg -j4 qrencode; fi
RUN if ! ls >/dev/null 2>&1 void-packages/hostdir/binpkgs/harfbuzz-devel-*.xbps;         then cd void-packages && ./xbps-src pkg -j4 harfbuzz-devel; fi

# Add graphite, exiv2

# Install built packages
RUN sudo xbps-install --repository=/home/kdedev/void-packages/hostdir/binpkgs --force --yes libglib-devel fontconfig-devel dbus-devel icu-devel libxslt-devel libgpg-error-devel libxcb-devel xcb-util-keysyms-devel libxml2-devel libglapi libGL libEGL libGLES libOSMesa libllvm7 poppler-devel poppler-qt5-devel wayland qrencode harfbuzz

# Download, patch and build QT everywhere, QT webkit and friends, then delete sources
RUN sudo xbps-install -y wget xz libaccounts-glib-devel doxygen
COPY qt.musl.patch /home/kdedev
COPY config.opt /home/kdedev
COPY qtnetwork-5.12.4-libressl.patch /home/kdedev
RUN sudo sh -c 'printf -- "-static\n-release\n" >> config.opt'
COPY libaccounts.patch /home/kdedev
COPY signon.patch /home/kdedev
RUN wget -qO- http://download.qt.io/official_releases/qt/5.12/5.12.4/single/qt-everywhere-src-5.12.4.tar.xz | tar xJ && \
	patch -d ~/qt-everywhere-src-5.12.4 -p0 < ~/qt.musl.patch && \
	patch -d ~/qt-everywhere-src-5.12.4/qtbase -p1 < qtnetwork-5.12.4-libressl.patch && \
	mv ~/config.opt ~/qt-everywhere-src-5.12.4 && \
	cd ~/qt-everywhere-src-5.12.4 && ./configure -redo && make -j4 -Oline && make -j4 install && \
	cd ~ && rm -r ~/qt-everywhere-src-5.12.4 && \
	export PATH=/home/kdedev/qt-everywhere-5.12.4/bin:$PATH && \
	wget -qO- http://download.qt.io/snapshots/ci/qtwebkit/5.212/1515668564/src/submodules/qtwebkit-everywhere-src-5.212.tar.xz | tar xJ && \
	cd qtwebkit-everywhere-src-5.212 && \
    cmake -DPORT=Qt -DCMAKE_BUILD_TYPE=Release -DQt5_DIR=/home/kdedev/qt-everywhere-5.12.4 -DCMAKE_PREFIX_PATH=/home/kdedev/qt-everywhere-5.12.4/lib/cmake -DCMAKE_INSTALL_PREFIX=/home/kdedev/qt-everywhere-5.12.4 -DENABLE_SAMPLING_PROFILER=0 -DUSE_THIN_ARCHIVES=OFF && \
    make -j4 && make -j4 install && \
    cd ~ && rm -r ~/qtwebkit-everywhere-src-5.212 && \
	wget -qO- https://gitlab.com/accounts-sso/libaccounts-qt/-/archive/master/libaccounts-qt-master.tar.gz | tar xz &&\
	cd ~/libaccounts-qt-master && \
    patch -p0 < /home/kdedev/libaccounts.patch && \
    qmake PREFIX=/home/kdedev/qt-everywhere-5.12.4 && \
    make -j4 -Oline && make -j4 install && \
    cd ~ && rm -r ~/libaccounts-qt-master && \
	wget -qO- https://gitlab.com/accounts-sso/signond/-/archive/master/signond-master.tar.gz | tar xz && \
	cd ~/signond-master && \
    patch -p0 < /home/kdedev/signon.patch && \
    qmake PREFIX=/home/kdedev/qt-everywhere-5.12.4 && \
    make -j4 -Oline && make -j4 install && \
    cd ~ && rm -r ~/signond-master

# Make path change permanent
ENV PATH /home/kdedev/qt-everywhere-5.12.4/bin:$PATH

# Install kdesrc-build
RUN sudo xbps-install -y git perl-YAML-LibYAML
RUN git clone --depth 1 git://anongit.kde.org/kdesrc-build.git

# Make empty library since build process will try to link with it
RUN sudo sh -c "echo \!\<arch\> > /usr/lib/libgcc_s.a"

# Install some fonts
RUN sudo xbps-install --yes dejavu-fonts-ttf

# Prepare the KDE build
RUN mkdir kde

# And some useful stuff for later on
RUN sudo xbps-install --yes bash ncurses-term vim
COPY .bashrc /home/kdedev
RUN sudo xbps-install -y openssh && sudo ssh-keygen -A
RUN mkdir .ssh
