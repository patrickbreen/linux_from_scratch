#!/bin/bash

# this has to be run as sudo

source vars.sh

# create dir layout
mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin}
for i in bin lib sbin; do
 ln -sv usr/$i $LFS/$i
done
case $(uname -m) in
 x86_64) mkdir -pv $LFS/lib64 ;;
esac

# make cross compiler dir
mkdir -pv $LFS/tools