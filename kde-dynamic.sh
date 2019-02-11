#!/bin/sh
set -e  # Exit immediately on error

# Build the docker image
docker build \
    --build-arg mirror=$mirror \
    --build-arg http_proxy=$http_proxy \
    --build-arg https_proxy=$https_proxy \
    --build-arg ftp_proxy=$ftp_proxy \
    --build-arg certificate=$certificate \
    --file=kde-dynamic.Dockerfile \
    --tag=voidlinux/kde-dynamic .

# Create container to build KDE
docker create \
    --volume /tmp/.X11-unix:/tmp/.X11-unix --env DISPLAY=$DISPLAY \
    --volume /srv/docker/ccache:/ccache    --env CCACHE_DIR=/ccache \
    --volume $HOME/src/kde/source:/home/kdedev/kde/source \
    --interactive --tty \
    --name=kde-dynamic --hostname=kde-dynamic \
    voidlinux/kde-dynamic

# Prepare the KDE build
docker cp kdesrc-buildrc-dynamic        kde-dynamic:/home/kdedev/kde/kdesrc-buildrc
docker cp kf5-frameworks-build-include  kde-dynamic:/home/kdedev/kde

docker start kde-dynamic

docker exec kde-dynamic sh -c "\$HOME/kdesrc-build/kdesrc-build --rc-file=\$HOME/kde/kdesrc-buildrc --build-only --refresh-build --include-dependencies frameworks"
docker exec kde-dynamic sh -c "\$HOME/kdesrc-build/kdesrc-build --rc-file=\$HOME/kde/kdesrc-buildrc --build-only --refresh-build okular"