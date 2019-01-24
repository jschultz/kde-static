#!/bin/sh

docker cp squid:/etc/squid/ssl_cert/myCA.pem .

docker build --file=voidlinux-musl.Dockerfile --tag=voidlinux/build .

docker run --rm --privileged --cap-add=SYS_ADMIN --volume=`pwd`/repo:/void-packages/hostdir/binpkgs voidlinux/build sh -c "\
    cd void-packages && \
    ./xbps-src pkg -j4 proot"

cp $HOME/.bashrc .
docker build --file=kde-static.Dockerfile --tag=voidlinux/kde-static .
