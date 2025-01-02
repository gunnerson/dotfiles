#!/usr/bin/env bash
rsync -auP --info=progress2 --delete --exclude '#recycle' "/mnt/jsc/Customer/" "/home/rumata/jsc/Customer"
rsync -auP --info=progress2 --delete --exclude '#recycle' --exclude '#snapshot' "/mnt/jsc/Service/" "/home/rumata/jsc/Service"
