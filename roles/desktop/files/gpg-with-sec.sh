#!/bin/bash

# Usage:
# Import other public key normally
# Run this script with --sign {key}
# Export with gpg --armor --output E4758D1D.signed-by.01234567.asc --export E4758D1D

# Import:
# --import, --list-sigs, --send-keys

# The DOS label of your USB stick
LABEL=gpg

# The pathname to the file containing your private keys
# on that stick
KEYFILE=gpg/bischof@puzzle.ch.private.gpg-key

# Identify the device file corresponding to your USB stick
device=$(/sbin/findfs LABEL=$LABEL)


if [ -n "$device" ]; then
    # Mount the stick
    udisksctl mount --block-device $device

    # Create temporary GnuPG home directory
    tmpdir=$(mktemp -d -p $XDG_RUNTIME_DIR gpg.XXXXXX)

    function finish {
        [ -f $tmpdir/S.gpg-agent ] && gpg-connect-agent --homedir $tmpdir KILLAGENT /bye
        rm -rf $tmpdir
    }
    trap finish EXIT

    # Import the private keys
    gpg2 --homedir $tmpdir --import /media/$USER/$LABEL/$KEYFILE

    # Unmount the stick
    udisksctl unmount --block-device $device

    # Launch GnuPG from the temporary directory,
    # with the default public keyring
    # and with any arguments given to us on the command line
    gpg2 --homedir $tmpdir --keyring ${GNUPGHOME:-$HOME/.gnupg}/pubring.gpg $@
fi
