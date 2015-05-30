#!/bin/bash
host=192.168.0.102
ping -c1 -W1 $host
if [ $? -ne 0 ]; then
        wakeonlan 30:85:a9:9d:03:d0
        until nc -vzw 2 $host 22; do sleep 1; done
fi
ssh lorenz@$host
