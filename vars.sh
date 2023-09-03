#!/bin/bash

# LFS book puts this in the lfs user bashrc, but I'm putting it here instead
set +h
umask 022
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=$LFS/tools/bin:$PATH
CONFIG_SITE=$LFS/usr/share/config.site
export LFS LC_ALL LFS_TGT PATH CONFIG_SITE

# use parallel make
export MAKEFLAGS='-j12'