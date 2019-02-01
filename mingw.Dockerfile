FROM voidlinux/voidlinux
MAINTAINER Jonathan Schultz <jonathan@schultz.la>

# Set up proxy
COPY myCA.pem /usr/share/ca-certificates
RUN chmod go+r /usr/share/ca-certificates/myCA.pem
RUN echo myCA.pem >> /etc/ca-certificates.conf && update-ca-certificates
ENV ftp_proxy http://172.17.0.1:3128
ENV http_proxy http://172.17.0.1:3128
ENV https_proxy http://172.17.0.1:3128

# Use Australian mirror site
RUN cp /usr/share/xbps.d/*repository* /etc/xbps.d && sed -i -e 's|alpha.de.repo.voidlinux.org|mirror.aarnet.edu.au/pub/voidlinux|g' /etc/xbps.d/*repository*
RUN xbps-install --update --sync --yes

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

RUN sudo xbps-install --yes \
    bash \
	git \
    autoconf \
    automake \
    flex \
    gcc \
    gdk-pixbuf-devel \
    gettext \
    gettext-devel \
    git \
    gperf \
    intltool \
    libcurl-devel \
    libtool \
    lzip \
    make \
    p7zip \
    patch \
    perl-XML-Parser \
    pkg-config \
    python \
    ruby \
    unzip \
    wget \
    xz

# Install MXE cross-building environment
RUN git clone --depth 1 https://github.com/mxe/mxe.git

# Build Qt5
RUN cd mxe && make qt5
RUN cd mxe && make fontconfig dbus icu4c libxslt libgpg_error libxcb xcb-util-keysyms libxml2 libglapi libGL libEGL libGLES libOSMesa llvm poppler poppler-qt5

# Update path
ENV PATH /home/kdedev/mxe/usr/i686-w64-mingw32.static/qt5/bin:/home/kdedev/mxe/usr/bin:$PATH

# Fudge default cmake
RUN ln -s /home/kdedev/mxe/usr/bin/i686-w64-mingw32.static-cmake /home/kdedev/mxe/usr/bin/cmake

# Install kdesrc-build
RUN sudo xbps-install -y git perl-YAML-LibYAML
RUN git clone git://anongit.kde.org/kdesrc-build.git

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
