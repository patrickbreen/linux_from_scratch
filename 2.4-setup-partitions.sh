#!/bin/bash

source vars.sh

# wipe partition table on /dev/sdb
sudo dd if=/dev/zero of=/dev/sdb bs=512 count=1

# make 440 GB partition on /dev/sdb
echo -e "o\nn\np\n1\n\n+440G\nw" | sudo fdisk /dev/sdb

# update partitions
sudo partprobe

# make filesystem
sudo mkfs.ext4 /dev/sdb1

# mount
sudo mkdir $LFS
sudo mount /dev/sdb1 $LFS

# make mount persistent
echo "/dev/sdb1 $LFS ext4 defaults 0 0" | sudo tee -a /etc/fstab
