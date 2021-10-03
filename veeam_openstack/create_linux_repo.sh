#!/bin/bash

fdisk -l
pvcreate /dev/sdb
pvs

vgcreate vg_data /dev/sdb

vgs


lvcreate -n lv_data -l 100%FREE vg_data
lvdisplay

mkfs.xfs -b size=4096 -m reflink=1,crc=1 /dev/vg_data/lv_data

mkdir /data

echo "/dev/vg_data/lv_data  /data        xfs   defaults        0 1" >> /etc/fstab

mount -a
