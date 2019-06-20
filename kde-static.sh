#!/bin/sh
set -e  # Exit immediately on error

SOURCEDIR=$HOME/src/kde/source
INSTALLDIR=$HOME/src/kde/install-static
KDESRC_BUILDRC=kdesrc-buildrc-static
DOCKERFILE=kde-static.Dockerfile
IMAGE_TAG=voidlinux/kde-static
CONTAINER_NAME=kde-static

cd $(dirname $(realpath $0))

# Build proot if we don't already have it
if ! test -f binpkgs/proot-*.x86_64-musl.xbps; then
    # Build the initial build container
    docker build \
        --no-cache \
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
        --volume=`pwd`/binpkgs:/void-packages/hostdir/binpkgs \
        voidlinux/build \
        sh -c "\
            cd void-packages && \
            ./xbps-src pkg -j4 proot"
fi

# Build the docker image
docker build \
    --build-arg mirror=$mirror \
    --build-arg http_proxy=$http_proxy \
    --build-arg https_proxy=$https_proxy \
    --build-arg ftp_proxy=$ftp_proxy \
    --build-arg certificate=$certificate \
    --file=$DOCKERFILE \
    --tag=$IMAGE_TAG .

# Create installation directory - otherwise Docker will create it with root ownership.
if ! test -d $INSTALLDIR; then
    mkdir $INSTALLDIR
fi

# Create container to build KDE
docker create \
    --volume /tmp/.X11-unix:/tmp/.X11-unix --env DISPLAY=$DISPLAY \
    --volume /srv/docker/ccache:/ccache    --env CCACHE_DIR=/ccache \
    --volume $SOURCEDIR:/home/kdedev/kde/source \
    --volume $INSTALLDIR:/home/kdedev/kde/install \
    --interactive --tty \
    --name=$CONTAINER_NAME --hostname=$CONTAINER_NAME \
    $IMAGE_TAG

# Prepare the KDE build
docker cp $KDESRC_BUILDRC              $CONTAINER_NAME:/home/kdedev/kde/kdesrc-buildrc
docker cp kf5-frameworks-build-include $CONTAINER_NAME:/home/kdedev/kde

# Copy our public key to the image for eash SSH access
docker cp $HOME/.ssh/id_rsa.pub $CONTAINER_NAME:/home/kdedev/.ssh/authorized_keys

docker start $CONTAINER_NAME

docker exec $CONTAINER_NAME sh -c "\$HOME/kdesrc-build/kdesrc-build --rc-file=\$HOME/kde/kdesrc-buildrc --build-only --refresh-build --include-dependencies frameworks"
docker exec $CONTAINER_NAME sh -c "\$HOME/kdesrc-build/kdesrc-build --rc-file=\$HOME/kde/kdesrc-buildrc --build-only --refresh-build libkexiv2"
docker exec $CONTAINER_NAME sh -c "\$HOME/kdesrc-build/kdesrc-build --rc-file=\$HOME/kde/kdesrc-buildrc --build-only --refresh-build okular"
