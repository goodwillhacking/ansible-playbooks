# Import master private key
$ mount /dev/sd## /mnt
$ mkdir ~/gpgtmp
$ chmod 0700 ~/gpgtmp
$ gpg2 --homedir ~/gpgtmp --import /mnt/private-key.asc

$ gpg2 --homedir ~/gpgtmp --edit-key bob@example.com
$ gpg -a --export 54265e8c > /mnt/updated-key.txt
$ gpg-connect-agent --homedir ~/gpgtmp KILLAGENT /bye
$ rm -rf ~/gpgtmp
$ umount /mnt

# Inspect and import the keys
$ cat /mnt/updated-key.txt | gpg --list-packets | head -20
$ gpg --import /mnt/updated-key.txt
$ gpg --send-keys 54265e8c
