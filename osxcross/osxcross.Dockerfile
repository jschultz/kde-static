FROM voidlinux/voidlinux
MAINTAINER Jonathan Schultz <jonathan@schultz.la>

# Set up proxy
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
RUN xbps-install --update --sync --yes

# Need to do sync/update in two stages because xbps needs to be update before remaining packages
RUN xbps-install --sync --yes xbps
RUN xbps-install --update --yes

# Create kdedev user
RUN xbps-install --yes sudo && echo 'kdedev ALL=NOPASSWD: ALL' >> /etc/sudoers && echo 'Defaults env_keep += "ftp_proxy http_proxy https_proxy"' >> /etc/sudoers
RUN useradd kdedev
USER kdedev
WORKDIR /home/kdedev
CMD bash

# And some useful stuff for later on
RUN sudo xbps-install --yes bash ncurses-term vim
COPY .bashrc /home/kdedev
RUN sudo xbps-install -y openssh && sudo ssh-keygen -A
RUN mkdir .ssh

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
    xz \
    clang \
    zlib-devel          \
    gmp-devel           \
    mpfr-devel          \
    libmpc-devel        \
    cmake               \
    libxml2-devel	\
    gobject-introspection \
    mozjs52-devel \
    ccache


# Install osxcross
ARG sdk_filename
ENV sdk_filename=$sdk_filename
ARG sdk_version
ENV sdk_version=$sdk_version
ARG deployment_target
ENV deployment_target=$deployment_target

RUN git clone --depth=1 https://github.com/tpoechtrager/osxcross.git
RUN cd osxcross && ./tools/get_dependencies.sh
COPY $sdk_filename /home/kdedev/osxcross/tarballs
RUN cd osxcross && UNATTENDED=1 OSX_VERSION_MIN=$deployment_target ./build.sh
RUN sudo xbps-install --yes llvm
RUN cd osxcross && ./build_compiler_rt.sh

# /home/kdedev/osxcross/target/bin ???
ENV PATH /home/kdedev/osxcross/target/bin:$PATH
CMD /bin/bash

# Make gcc the default compiler because clang seems to break things
RUN sudo xbps-alternatives -s gcc

# Install MXE cross-building environment
RUN git clone --depth 1 --branch x86_64-apple-darwin18 https://github.com/jschultz/mxe.git

# Build Qt5 and other packages we'll need
RUN cd mxe && make cmake-conf
RUN cd mxe && make qt5
RUN cd mxe && make libxslt
RUN cd mxe && make llvm
RUN cd mxe && make poppler
RUN cd mxe && make docbook-xml
RUN cd mxe && make docbook-xsl
RUN cd mxe && make boost
RUN cd mxe && make giflib
RUN cd mxe && make libqrencode

# Update path
ENV PATH /home/kdedev/mxe/usr/bin:$PATH

# Fudge default cmake
RUN ln -s /home/kdedev/mxe/usr/bin/x86_64-apple-darwin18-cmake /home/kdedev/mxe/usr/bin/cmake

# Install kdesrc-build
RUN sudo xbps-install -y git perl-YAML-LibYAML
RUN git clone --depth 1 git://anongit.kde.org/kdesrc-build.git

RUN sudo xbps-install --yes ccache

# Prepare the KDE build
RUN mkdir kde

# And some useful stuff for later on
RUN sudo xbps-install --yes bash ncurses-term vim
COPY .bashrc /home/kdedev
RUN sudo xbps-install -y openssh && sudo ssh-keygen -A
