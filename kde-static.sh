#!/bin/sh
set -e  # Exit immediately on error

# Build the initial build container
docker build \
    --build-arg mirror=$mirror \
    --build-arg http_proxy=$http_proxy \
    --build-arg https_proxy=$https_proxy \
    --build-arg ftp_proxy=$ftp_proxy \
    --build-arg certificate=$certificate \
    --file=voidlinux-musl.Dockerfile \
    --tag=voidlinux/build .

# Build proot inside the build container
# This is required until proot release is made that includes https://github.com/proot-me/PRoot/pull/149
docker run \
    --rm --privileged --cap-add=SYS_ADMIN \
    --volume=`pwd`/repo:/void-packages/hostdir/binpkgs \
    voidlinux/build \
    sh -c "\
        cd void-packages && \
        ./xbps-src pkg -j4 proot"

# Build the docker image
docker build \
    --build-arg mirror=$mirror \
    --build-arg http_proxy=$http_proxy \
    --build-arg https_proxy=$https_proxy \
    --build-arg ftp_proxy=$ftp_proxy \
    --build-arg certificate=$certificate \ 
    --file=kde-static.Dockerfile \
    --tag=voidlinux/kde-static .

# Create container to build KDE
docker create \
    --volume /tmp/.X11-unix:/tmp/.X11-unix --env DISPLAY=$DISPLAY \
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