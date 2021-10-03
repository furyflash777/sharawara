#!/bin/bash

#Create directory for image
yum install wget -y

mkdir /VeeamBootISO

cd /tmp

#Download iso image
wget http://repository.veeam.com/backup/linux/agent/veeam-recovery-media/x64/veeam-recovery-media-5.0.0.iso
mv /tmp/veeam-recovery-media* /VeeamBootISO/veeam-recovery-media.iso

#Create custom grub entry

cat >> /etc/grub.d/40_custom << 'EOF'
menuentry "Veeam Recovery Media" {
insmod ext2
set isofile="/VeeamBootISO/veeam-recovery-media.iso"
loopback loop (hd0,1)/$isofile
linux (loop)/isolinux/velinux iso-scan/filename=$isofile quiet noeject nopromt splash --
initrd (loop)/isolinux/initrd.img
}
EOF

#Make new grub menu
grub2-mkconfig -o /boot/grub2/grub.cfg
