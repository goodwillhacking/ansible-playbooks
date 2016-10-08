# Install guide

```
loadkeys sg
wifi-menu
```
Due to a bug the connection takes a while to connect. Running `pacman -Syy` seems to help...

## Partitioning
```
(parted) mklabel gpt
(parted) mkpart primary ext4 0% 512M
(parted) mkpart primary btrfs 512M 100%
(parted) set 1 boot on
```
## Encryption
```
cryptsetup -y -v luksFormat /dev/sdaX
cryptsetup open /dev/sdaX cryptroot
mkfs.btrfs /dev/mapper/cryptroot
mount /dev/mapper/cryptroot /mnt

# Boot partition
mkfs.fat -F 32 /dev/sdaY
mkdir /mnt/boot
mount /dev/sdaY /mnt/boot
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
mkinitcpio -p linux
cp /usr/share/systemd/bootctl/arch.conf /boot/loader/entries
# options cryptdevice=/dev/sda2:cryptroot root=/dev/mapper/cryptroot quiet rw
echo 'default arch' > /boot/loader/loader.conf
```

## Finishing
```
pacman -S iw wpa_supplicant dialog git sudo ansible
exit
umount -R /mnt
reboot

echo "work" > /etc/hostname #also update /etc/hosts
# uncomment sudo rule in /etc/sudoers
groupadd sudo
useradd -m -G sudo -s /bin/bash lbischof
passwd lbischof
passwd --lock
su - lbischof
git clone https://github.com/lbischof/ansible-playbooks
ansible-playbook ansible-playbooks/desktop.yml
```
