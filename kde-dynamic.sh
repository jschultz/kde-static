#!/bin/sh

docker cp squid:/etc/squid/ssl_cert/myCA.pem .

docker build --file=kde-dynamic.Dockerfile --tag=voidlinux/kde-dynamic .

cp $HOME/.bashrc .
docker build --file=kde-dynamic.Dockerfile --tag=voidlinux/kde-dynamic .

docker create --volume /tmp/.X11-unix:/tmp/.X11-unix --env DISPLAY=$DISPLAY \
              --volume /srv/docker/ccache:/ccache    --env CCACHE_DIR=/ccache \
              --interactive --tty \
              --name=kde-dynamic --hostname=kde-dynamic \
              voidlinux/kde-dynamic

# Prepare the KDE build
docker cp $HOME/src/okular-static.cache/kde/source kde-dynamic:/home/kdedev/kde
docker cp patch-kde.sh                  kde-dynamic:/home/kdedev/kde
docker cp kdesrc-buildrc-dynamic        kde-dynamic:/home/kdedev/kde/kdesrc-buildrc
docker cp kdesrc-buildrc-sources        kde-dynamic:/home/kdedev/kde
docker cp kf5-frameworks-build-include  kde-dynamic:/home/kdedev/kde

docker start kde-dynamic

docker exec kde-dynamic sh -c "cd kde && sh patch-kde.sh"
docker exec kde-dynamic sh -c "\$HOME/kdesrc-build/kdesrc-build --rc-file=\$HOME/kde/kdesrc-buildrc --build-only --refresh-build --include-dependencies frameworks"