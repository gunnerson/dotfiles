#!/usr/bin/env bash
sudo mount -t cifs //bnas.bwaargh.lan/docs/v /mnt/bnas/docs -o credentials=/etc/samba/credentials/bnas,uid=1000,gid=1000
sudo mount -t cifs //bnas.bwaargh.lan/media /mnt/bnas/media -o credentials=/etc/samba/credentials/bnas,uid=1000,gid=1000
sudo mount -t cifs //bnas.bwaargh.lan/public /mnt/bnas/public -o credentials=/etc/samba/credentials/bnas,uid=1000,gid=1000
sudo mount -t cifs //bnas.bwaargh.lan/rpc /mnt/bnas/rpc -o credentials=/etc/samba/credentials/bnas,uid=1000,gid=1000
