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
IMAGE_TAG=voidlinux/kde-osxcross
CONTAINER_NAME=kde-osxcross
cd $(dirname $(realpath $0))

# Build the docker image
docker build \
    $@ \
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

# Prepare the KDE build
#docker cp $HOME/src/okular-static.cache/kde/source $CONTAINER_NAME:/home/kdedev/kde
docker cp ../patch-kde.sh               $CONTAINER_NAME:/home/kdedev/kde
docker cp kdesrc-buildrc-osxcross       $CONTAINER_NAME:/home/kdedev/kde/kdesrc-buildrc
docker cp ../kdesrc-buildrc-sources        $CONTAINER_NAME:/home/kdedev/kde
docker cp ../kf5-frameworks-build-include  $CONTAINER_NAME:/home/kdedev/kde

# Prebuilt executables needed for cross-building
docker cp ../hostapps $CONTAINER_NAME:/home/kdedev

docker start $CONTAINER_NAME

docker exec $CONTAINER_NAME sh -c "\$HOME/kdesrc-build/kdesrc-build         \
                                    --rc-file=\$HOME/kde/kdesrc-buildrc     \
                                    --build-only                            \
                                    --refresh-build                         \
                                    --include-dependencies                  \
                                    frameworks;                             \
                                exit 0"   # Don't worry about failures
docker exec $CONTAINER_NAME sh -c "\$HOME/kdesrc-build/kdesrc-build         \
                                    --rc-file=\$HOME/kde/kdesrc-buildrc     \
                                    --build-only                            \
                                    --refresh-build                         \
                                    --no-include-dependencies               \
                                    okular"

mkdir $INSTALLDIR/Applications/KDE/okular.app/Contents/Resources
cp $INSTALLDIR/share/okular/drawingtools.xml $INSTALLDIR/Applications/KDE/okular.app/Contents/Resources
cp $INSTALLDIR/share/kxmlgui5/okular/part.rc $INSTALLDIR/Applications/KDE/okular.app/Contents/Resources
cp $INSTALLDIR/share/kxmlgui5/okular/shell.rc $INSTALLDIR/Applications/KDE/okular.app/Contents/Resources
cp $INSTALLDIR/etc/xdg/ui/ui_standards.rc $INSTALLDIR/Applications/KDE/okular.app/Contents/Resources
cp $INSTALLDIR/share/icons/breeze/breeze-icons.rcc $INSTALLDIR/Applications/KDE/okular.app/Contents/Resources/icontheme.rcc
