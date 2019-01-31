#!/bin/sh

docker cp squid:/etc/squid/ssl_cert/myCA.pem .

docker build --file=voidlinux-musl.Dockerfile --tag=voidlinux/build:test .

docker run --rm --privileged --cap-add=SYS_ADMIN --volume=`pwd`/repo:/void-packages/hostdir/binpkgs voidlinux/build:test sh -c "\
    cd void-packages && \
    ./xbps-src pkg -j4 proot"

exit
cp $HOME/.bashrc .
docker build --file=kde-static.Dockerfile --tag=voidlinux/kde-static .

docker create --volume /tmp/.X11-unix:/tmp/.X11-unix --env DISPLAY=$DISPLAY \
              --volume /srv/docker/ccache:/ccache    --env CCACHE_DIR=/ccache \
              --interactive --tty \
              --name=kde-static --hostname=kde-static \
              voidlinux/kde-static

docker cp $HOME/src/okular-static.cache/kde/source kde-static:/home/kdedev/kde
docker start kde-static
docker exec kde-static sh -c "cd kde && sh patch-kde.sh"
docker exec kde-static sh -c "\$HOME/kdesrc-build/kdesrc-build --rc-file=\$HOME/kde/kdesrc-buildrc --build-only --refresh-build frameworks"