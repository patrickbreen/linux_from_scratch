#!/bin/bash

# this has to be run as sudo

# TODO fill this in. Need to delete and re unpack the tar maybe for things
# that have already been built earlier

source vars.sh

# 1) install m4
cd $LFS/sources/12.0/
tar -xf m4-1.4.19.tar.xz 
cd m4-1.4.19

./configure --prefix=/usr \
 --host=$LFS_TGT \
 --build=$(build-aux/config.guess)
 make
 make DESTDIR=$LFS install

# 2) ncurses
cd $LFS/sources/12.0/
tar -xf ncurses-6.4.tar.gz
cd ncurses-6.4

# 3) bash
cd $LFS/sources/12.0/
tar -xf bash-5.2.15.tar.gz
cd bash-5.2.15

# 4) coreutils
cd $LFS/sources/12.0/
tar -xf coreutils-9.3.tar.xz
cd coreutils-9.3

# 5) diff utils
cd $LFS/sources/12.0/
tar -xf diffutils-3.10.tar.xz
cd diffutils-3.10

# 6) file
cd $LFS/sources/12.0/
tar -xf file-5.45.tar.gz
cd file-5.45

# 7) find utils
cd $LFS/sources/12.0/
tar -xf findutils-4.9.0.tar.xz
cd findutils-4.9.0

# 8) gawk
cd $LFS/sources/12.0/
tar -xf gawk-5.2.2.tar.xz
cd gawk-5.2.2

# 9) grep
cd $LFS/sources/12.0/
tar -xf grep-3.11.tar.xz
cd grep-3.11

# 10) gzip
cd $LFS/sources/12.0/
tar -xf gzip-1.12.tar.xz
cd gzip-1.12

# 11) make
cd $LFS/sources/12.0/
tar -xf make-4.4.1.tar.gz
cd make-4.4.1

# 12) patch
cd $LFS/sources/12.0/
tar -xf patch-2.7.6.tar.xz
cd patch-2.7.6

# 13) sed
cd $LFS/sources/12.0/
tar -xf sed-4.9.tar.xz
cd sed-4.9

# 14) tar
cd $LFS/sources/12.0/
tar -xf tar-1.35.tar.xz
cd tar-1.35

# 15) xz
cd $LFS/sources/12.0/
tar -xf xz-5.4.4.tar.xz
cd xz-5.4.4

# 16) binutils
cd $LFS/sources/12.0/
tar -xf binutils-2.41.tar.xz
cd binutils-2.41

# 17) gccs
cd $LFS/sources/12.0/
tar -xf gcc-13.2.0.tar.xz
cd gcc-13.2.0


