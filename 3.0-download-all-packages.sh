#!/bin/bash

source vars.sh

# make sources dir and make it sticky
sudo mkdir -v $LFS/sources
sudo chmod -v a+wt $LFS/sources

# download list of files as sources
# I just downloaded this tar https://mirror.download.it/lfs/pub/lfs/lfs-packages/lfs-packages-12.0.tar

# unpack tar to sources
sudo tar -xf lfs-packages-12.0.tar -C $LFS/sources/
sudo chown root:root $LFS/sources/*