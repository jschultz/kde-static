#!/bin/sh
set -e  # Exit immediately on error

. ./local-env

SOURCEDIR=$HOME/src/kde/source
INSTALLDIR=$HOME/src/kde/install-osx
MXEGITDIR=$HOME/src/mxe
KDESRC_BUILDRC=kdesrc-buildrc-osx
DOCKERFILE=osxcross.Dockerfile
SDK_FILENAME=MacOSX10.14.sdk.tar.bz2
SDK_VERSION=10.14
DEPLOYMENT_TARGET=10.12
IMAGE_TAG=voidlinux/kde-osxcross$SDK_VERSION
CONTAINER_NAME=kde-osxcross$SDK_VERSION
cd $(dirname $(realpath $0))

# Build the docker image
docker build \
    --build-arg mirror=$mirror \
    --build-arg http_proxy=$http_proxy \
    --build-arg https_proxy=$https_proxy \
    --build-arg ftp_proxy=$ftp_proxy \
    --build-arg certificate=$certificate \
    --build-arg sdk_filename=$SDK_FILENAME\
    --build-arg sdk_version=$SDK_VERSION \
    --build-arg deployment_target=$DEPLOYMENT_TARGET \
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
    --volume $MXEGITDIR:/home/kdedev/git/mxe \
    --interactive --tty \
    --name=$CONTAINER_NAME --hostname=$CONTAINER_NAME \
    $IMAGE_TAG

exit

# Prepare the KDE build
docker cp $HOME/src/okular-static.cache/kde/source kde-osxcross:/home/kdedev/kde
docker cp patch-kde.sh                  kde-osxcross:/home/kdedev/kde
docker cp kdesrc-buildrc-osxcross       kde-osxcross:/home/kdedev/kde/kdesrc-buildrc
docker cp kdesrc-buildrc-sources        kde-osxcross:/home/kdedev/kde
docker cp kf5-frameworks-build-include  kde-osxcross:/home/kdedev/kde

docker start kde-osxcross

docker exec kde-osxcross sh -c "cd kde && sh patch-kde.sh"
docker exec kde-osxcross sh -c "\$HOME/kdesrc-build/kdesrc-build --rc-file=\$HOME/kde/kdesrc-buildrc --build-only --refresh-build --include-dependencies frameworks"
