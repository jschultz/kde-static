#!/bin/sh

cp $HOME/.bashrc .
docker build --file=mingw.Dockerfile --tag=voidlinux/kde-mingw-static .

docker create --volume /tmp/.X11-unix:/tmp/.X11-unix --env DISPLAY=$DISPLAY \
              --volume /srv/docker/ccache:/ccache    --env CCACHE_DIR=/ccache \
              --interactive --tty \
              --name=kde-mingw-static --hostname=kde-mingw-static \
              voidlinux/kde-mingw-static

# Prepare the KDE build
docker cp $HOME/src/okular-static.cache/kde/source kde-mingw-static:/home/kdedev/kde
docker cp patch-kde.sh                  kde-mingw-static:/home/kdedev/kde
docker cp kdesrc-buildrc-mingw          kde-mingw-static:/home/kdedev/kde/kdesrc-buildrc
docker cp kdesrc-buildrc-sources        kde-mingw-static:/home/kdedev/kde
docker cp kf5-frameworks-build-include  kde-mingw-static:/home/kdedev/kde

# Prebuilt executables needed for cross-building
docker cp hostapps kde-mingw-static:/home/kdedev

docker start kde-mingw-static

docker exec kde-mingw-static sh -c "cd kde && sh patch-kde.sh"
docker exec kde-mingw-static sh -c "\$HOME/kdesrc-build/kdesrc-build --rc-file=\$HOME/kde/kdesrc-buildrc --build-only --refresh-build --include-dependencies frameworks"
