#!/bin/sh
set -e  # Exit immediately on error

docker build --file=mingw.Dockerfile --tag=voidlinux/kde-mingw-static .

docker create --volume /tmp/.X11-unix:/tmp/.X11-unix --env DISPLAY=$DISPLAY \
              --volume /srv/docker/ccache:/ccache    --env CCACHE_DIR=/ccache \
              --volume $HOME/src/kde/source:/home/kdedev/kde/source \
              --interactive --tty \
              --name=kde-mingw-static --hostname=kde-mingw-static \
              voidlinux/kde-mingw-static

# Prepare the KDE build
docker cp kdesrc-buildrc-mingw          kde-mingw-static:/home/kdedev/kde/kdesrc-buildrc
docker cp kf5-frameworks-build-include  kde-mingw-static:/home/kdedev/kde

# Prebuilt executables needed for cross-building
docker cp hostapps kde-mingw-static:/home/kdedev

docker start kde-mingw-static

docker exec kde-mingw-static sh -c "\$HOME/kdesrc-build/kdesrc-build --rc-file=\$HOME/kde/kdesrc-buildrc --build-only --refresh-build --include-dependencies frameworks"
docker exec kde-mingw-static sh -c "\$HOME/kdesrc-build/kdesrc-build --rc-file=\$HOME/kde/kdesrc-buildrc --build-only --refresh-build okular"
