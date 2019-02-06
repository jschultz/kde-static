#!/bin/sh
set -e  # Exit immediately on error

# Grab our certificate from squid container
docker cp squid:/etc/squid/ssl_cert/myCA.pem .

# Build the initial build container
docker build --file=voidlinux-musl.Dockerfile --tag=voidlinux/build:test .

# Build proot inside the build container
# This is required until proot release is made that includes https://github.com/proot-me/PRoot/pull/149
docker run --rm --privileged --cap-add=SYS_ADMIN \
           --volume=`pwd`/repo:/void-packages/hostdir/binpkgs voidlinux/build:test sh -c "\
                cd void-packages && \
                ./xbps-src pkg -j4 proot"

docker build --file=kde-static.Dockerfile --tag=voidlinux/kde-static .

docker create --volume /tmp/.X11-unix:/tmp/.X11-unix --env DISPLAY=$DISPLAY \
              --volume /srv/docker/ccache:/ccache    --env CCACHE_DIR=/ccache \
              --volume $HOME/src/kde/source:/home/kdedev/kde/source \
              --interactive --tty \
              --name=kde-static --hostname=kde-static \
              voidlinux/kde-static

# Prepare the KDE build
docker cp kdesrc-buildrc-static         kde-static:/home/kdedev/kde/kdesrc-buildrc
docker cp kf5-frameworks-build-include  kde-static:/home/kdedev/kde

docker start kde-static

docker exec kde-static sh -c "\$HOME/kdesrc-build/kdesrc-build --rc-file=\$HOME/kde/kdesrc-buildrc --build-only --refresh-build --include-dependencies frameworks"
docker exec kde-static sh -c "\$HOME/kdesrc-build/kdesrc-build --rc-file=\$HOME/kde/kdesrc-buildrc --build-only --refresh-build okular"