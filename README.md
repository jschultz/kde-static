I've been looking for a simple way to make my work-in-progress project [okular-tagging](https://github.com/jschultz/okular-tagging)
available to others in the simplest way possible for users who have no interest or ability in installing or building packages.
One option that has always attacted me is a static build as it eliminates in one stroke all the problems associated with runtime 
library dependencies.

This repository represents the results of my on-and-off efforts over some time to build KDE frameworks and the non-trivial application
okular  statically.

Somewhat to my surprise it turned out not to be too complicated. Although the patches to the KDE sources are quite long, the vast
bulk of them are simple changes to cmake files to enable static libraries. The biggest hurdle was turning okular's generator plugins
into static libraries, which involved a bit (but not too much) hackery. The end result is a series of patches to KDE sources that
work not only for static and conventional dynamic building, but also cross-building for MingW using the excellent [MXE](https://mxe.cc/)
framework.

If you just want to take a look at what I did to KDE, it's all in [patch-kde.sh](patch-kde.sh).

The whole thing is done using Docker containers based on the voidlinux distro using musl libraries, but since the final output is a
statically linked executable it should run on pretty much any Linux distribution. The mingw executable runs under wine or Windows.

## How to build KDE frameworks and okular statically

To build KDE frameworks plus okular statically, you'll need to start by downloading the KDE sources. The best way to do this is to use
[kdesrc-build](https://kdesrc-build.kde.org/). The configuration file [kdesrc-buildrc-sources] downloads frameworks revision
v5.54.0 and okular revision 18.12. Currently hard-coded, the KDE sources need to be loaded under ~/src/kde/source.

Having downloaded the KDE sources you need to apply the patches to enable them to be build statically. You can do this by invoking the
script [patch-kde.sh](patch-kde.sh) from the directory in which the sources were downloaded (ie ~/src/kde/source).

You can now start the build process by running [kde-static.sh](kde-static.sh) from the repository directory.

## How it works

The process begins by building the proot library, which owing to an upstream release issue, does not work correctly on modern kernels
in its stock release. This creates an initial docker image named `voidlinux/build`.

It then creates a second docker image named `voidlinux/kde-static`. This image contains all the prerequisites for building KDE:

- Packages that need to be build specially to get static libraries.
- qt5, qtwebkit, libaccounts, signond
- kdesrc-build

Finally the build script launches a conainer `kde-static` to build frameworks and okular

## The results

The final okular executable is around 85MB in size, which seems pretty reasonable to me for such a large application. Apparently using
Link-Time Optimization (LTO) this could be reduced by up to 80%.

## Other things

Since my internet connection is the end of the proverbial wet piece of string, I have done a few things to reduce net traffic.
These shouldn't affect someone who isn't worried about these things, but you are, or if they cause problems, then note that:

1. `http_proxy`, `https_proxy` and `ftp_proxy` are all inherited into docker images and containers
2. The environment variable `certificate` can contain the name of a file inside the build context (ie the repository root) that
contains a certificate that will be loaded into the docker image. This allows proxying of https connections by, for example, squid.

Similar scripts `kde-dynamic.sh` and `ming.sh` build KDE frameworks and okular dynamically and cross-built for MingW32 respectively.
