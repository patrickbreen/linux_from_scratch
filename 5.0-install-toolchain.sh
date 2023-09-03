#!/bin/bash

# this has to be run as sudo

source vars.sh

# 1) install binutils
cd $LFS/sources/12.0/
tar -xf binutils-2.41.tar.xz
cd binutils-2.41

mkdir -v build
cd build
../configure --prefix=$LFS/tools \
--with-sysroot=$LFS \
--target=$LFS_TGT \
--disable-nls \
--enable-gprofng=no \
--disable-werror
make
make install

# 2) install gcc
cd $LFS/sources/12.0/
tar -xf gcc-13.2.0.tar.xz
cd gcc-13.2.0

tar -xf ../mpfr-4.2.0.tar.xz
mv -v mpfr-4.2.0 mpfr
tar -xf ../gmp-6.3.0.tar.xz
mv -v gmp-6.3.0 gmp
tar -xf ../mpc-1.3.1.tar.gz
mv -v mpc-1.3.1 mpc

case $(uname -m) in
 x86_64)
 sed -e '/m64=/s/lib64/lib/' \
 -i.orig gcc/config/i386/t-linux64
 ;;
esac

mkdir -v build
cd build
../configure \
 --target=$LFS_TGT \
 --prefix=$LFS/tools \
 --with-glibc-version=2.38 \
 --with-sysroot=$LFS \
 --with-newlib \
 --without-headers \
 --enable-default-pie \
 --enable-default-ssp \
 --disable-nls \
 --disable-shared \
 --disable-multilib \
 --disable-threads \
 --disable-libatomic \
 --disable-libgomp \
 --disable-libquadmath \
 --disable-libssp \
 --disable-libvtv \
 --disable-libstdcxx \
 --enable-languages=c,c++
make
make install
cd ..

# we had to make another header for some reason
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
 `dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/include/limits.h

# 3) install linux headers
cd $LFS/sources/12.0/
tar -xf linux-6.4.12.tar.xz
cd linux-6.4.12

make mrproper
make headers
find usr/include -type f ! -name '*.h' -delete
cp -rv usr/include $LFS/usr

# 4) install linux glibc
cd $LFS/sources/12.0/
tar -xf glibc-2.38.tar.xz
cd glibc-2.38

case $(uname -m) in
 i?86) ln -sfv ld-linux.so.2 $LFS/lib/ld-lsb.so.3
 ;;
 x86_64) ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64
        ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64/ld-lsb-x86-64.so.3
 ;;
esac

patch -Np1 -i ../glibc-2.38-fhs-1.patch

mkdir -v build
cd build

echo "rootsbindir=/usr/sbin" > configparms
../configure \
 --prefix=/usr \
 --host=$LFS_TGT \
 --build=$(../scripts/config.guess) \
 --enable-kernel=4.14 \
 --with-headers=$LFS/usr/include \
 libc_cv_slibdir=/usr/lib
make

# make absolutely sure that the $LFS variable is set because if it isn't and you're running as root,
# which we aren't supposed to, but of course we are, we will overwrite the host glibc and
#  system will die
make DESTDIR=$LFS install
sed '/RTLDLIST=/s@/usr@@g' -i $LFS/usr/bin/ldd

# test system with following lines
# echo 'int main(){}' | $LFS_TGT-gcc -xc -
# readelf -l a.out | grep ld-linux

# successful test shows [Requesting program interpreter: /lib64/ld-linux-x86-64.so.2]


# 5) install linux libstdc++
cd $LFS/sources/12.0/
rm -rf gcc-13.2.0
tar -xf gcc-13.2.0.tar.xz
cd gcc-13.2.0

mkdir -v build
cd build
../libstdc++-v3/configure \
 --host=$LFS_TGT \
 --build=$(../config.guess) \
 --prefix=/usr \
 --disable-multilib \
 --disable-nls \
 --disable-libstdcxx-pch \
 --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/13.2.0
make
make DESTDIR=$LFS install
rm -v $LFS/usr/lib/lib{stdc++,stdc++fs,supc++}.la