# Install guide

```
loadkeys sg
wifi-menu
```

## Partitioning
Create two partitions for `/boot` and `/`

## Encryption
```
cryptsetup -y -v luksFormat /dev/sda2
cryptsetup open /dev/sda2 cryptroot
mkfs.ext4 /dev/mapper/cryptroot
mount /dev/mapper/cryptroot /mnt

# Boot partition
mkfs.ext4 /dev/sda1
resize2fs -s /dev/sda1
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
```

## Base system
```
echo 'Server = http://archlinux.puzzle.ch/$repo/os/$arch' > /etc/pacman.d/mirrorlist
pacstrap /mnt base base-devel
genfstab -U /mnt >> /mnt/etc/fstab
cp /etc/netctl/profile /mnt/etc/netctl
arch-chroot /mnt /bin/bash
```

## Bootloader
Add the `encrypt` hook after `base udev` in /etc/mkinitcpio.conf. Remove the fsck hook
```
find / -name mbr.bin
dd conv=notrunc bs=440 count=1 if=mbr.bin of=/dev/sda
mkdir /boot/syslinux
extlinux --install /boot/syslinux
mkinitcpio -p linux
```
add following configuration in `/boot/syslinux/syslinux.cfg`:
```
DEFAULT void
LABEL void
  LINUX ../vmlinuz-linux
  APPEND root=/dev/mapper/cryptroot cryptdevice=/dev/sda2:cryptroot ro rd.auto quiet
  INITRD ../initramfs-linux.img
```

## Finishing
uncomment wheel rule in /etc/sudoers
```
pacman -S iw wpa_supplicant dialog git sudo ansible
useradd -m -G wheel -s /bin/bash lbischof
passwd lbischof
exit
umount -R /mnt
reboot

su - lbischof
git clone https://github.com/lbischof/ansible-playbooks
ansible-playbook ansible-playbooks/desktop.yml
```
