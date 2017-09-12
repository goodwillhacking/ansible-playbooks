# Install guide

```
# loadkeys sg
```
Update wifi configuration:
```
# vi /etc/wpa_supplicant/wpa_supplicant.conf
network={
    ssid="****"
    psk="****"
}
# wpa_supplicant -B -iwlp2s0 -c /etc/wpa_supplicant/wpa_supplicant.conf
# dhcpcd
```

## Partitioning
Create two partitions (don't forget bootable flag):
```
# fdisk /dev/sda
```

## Encryption
```
# cryptsetup -y -v luksFormat /dev/sda2
# cryptsetup open /dev/sdaX cryptroot
# mkfs.ext4 /dev/mapper/cryptroot
# mount /dev/mapper/cryptroot /mnt

# mkfs.ext4 -O ^64bit /dev/sda1
# mkdir /mnt/boot
# mount /dev/sda1 /mnt/boot
```

## Base system
```
# XBPS_ARCH=x86_64-musl xpbs-install -S -R https://repo.voidlinux.eu/current/musl -r /mnt base-system cryptsetup syslinux ansible git
# cp /etc/wpa_supplicant/wpa_supplicant.conf /mnt/etc/wpa_supplicant
# mount -t proc /proc /mnt/proc
# mount --rbind /dev /mnt/dev
# mount --rbind /sys /mnt/sys
# chroot /mnt /bin/bash

# passwd root
# vi /etc/fstab
# echo myhostname > /etc/hostname
```

## Bootloader
```
# find / -name mbr.bin
# dd conv=notrunc bs=440 count=1 if=mbr.bin of=/dev/sdX
# mkdir /boot/syslinux
# extlinux --install /boot/syslinux
# xbps-reconfigure -f linux4.12
# useradd -m -G wheel -s /bin/bash lbischof
# passwd lbischof
```
add following configuration in `/boot/syslinux/syslinux.cfg`:
```
DEFAULT void
LABEL void
  LINUX ../vmlinuz-4.12.12_1
  APPEND root=/dev/mapper/luks-$UID cryptdevice=/dev/sda2:cryptroot ro rd.auto quiet
  INITRD ../initramfs-4.12.12_1.img
```
uncomment wheel rule in /etc/sudoers

umount and reboot

## Finishing

```
$ sudo ln -s /etc/sv/dhcpcd /var/service
$ git clone https://github.com/lbischof/ansible-playbooks
$ ansible-playbook ansible-playbooks/playbook.yml
```
