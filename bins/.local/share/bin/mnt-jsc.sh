#!/usr/bin/env bash
sudo mount -t cifs //172.21.204.98/Customer         /mnt/jsc/Customer         -o credentials=/etc/samba/credentials/jsc,uid=1000,gid=1000
sudo mount -t cifs //172.21.204.98/Service          /mnt/jsc/Service          -o credentials=/etc/samba/credentials/jsc,uid=1000,gid=1000
sudo mount -t cifs //172.21.204.98/Scratch          /mnt/jsc/Scratch          -o credentials=/etc/samba/credentials/jsc,uid=1000,gid=1000
sudo mount -t cifs //172.21.204.98/Service_no_sync  /mnt/jsc/Service_no_sync  -o credentials=/etc/samba/credentials/jsc,uid=1000,gid=1000
sudo mount -t cifs //172.21.204.98/Office           /mnt/jsc/Office           -o credentials=/etc/samba/credentials/jsc,uid=1000,gid=1000
sudo mount -t cifs //172.21.204.98/VAD              /mnt/jsc/VAD              -o credentials=/etc/samba/credentials/jsc,uid=1000,gid=1000

