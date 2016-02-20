# Install guide

## Setup network
```
iw dev
wifi-menu -o wlp2s0
iw dev wlp2s0 link
```
## Partitioning
```
(parted) mklabel msdos
(parted) mkpart primary ext4 0% 500M
(parted) mkpart primary ext4 500M 100%
(parted) set 1 boot on
```
## Encryption
```
cryptsetup -y -v luksFormat /dev/sdaX
cryptsetup open /dev/sdaX cryptroot
mkfs -t ext4 /dev/mapper/cryptroot
mount -t ext4 /dev/mapper/cryptroot /mnt

mkfs -t ext4 /dev/sdaY
mkdir /mnt/boot
mount -t ext4 /dev/sdaY /mnt/boot
```

## Base system
```
echo "Server = http://archlinux.puzzle.ch/$repo/os/$arch" > /etc/pacman.d/mirrorlist
pacstrap /mnt base base-devel
genfstab -U /mnt >> /mnt/etc/fstab
cp /etc/netctl/profile /mnt/etc/netctl
arch-chroot /mnt /bin/bash
```

## Locale
```
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
ln -s /usr/share/zoneinfo/Europe/Zurich /etc/localtime
hwclock --systohc --utc
```

## Grub
```
#Add the `encrypt` hook after `base udev` in /etc/mkinitcpio.conf
mkinitcpio -p linux
pacman -S intel-ucode grub neovim

#Add to GRUB_CMDLINE_LINUX_DEFAULT in /etc/default/grub
cryptdevice=/dev/sda2:cryptroot root=/dev/mapper/cryptroot

grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
```

## Finishing
```
pacman -S iw wpa_supplicant dialog git sudo ansible
echo "work" > /etc/hostname #also update /etc/hosts
passwd
useradd -m -G sudo -s /bin/bash lbischof
passwd lbischof
exit
umount -R /mnt
reboot
```

## Networking
It seems wireless n doesn't work: `/etc/modprobe.d/iwlwifi.conf`
```
options iwlwifi 11n_disable=1
```
autostart wifi: `systemctl enable netctl-auto@wlp2s0`
