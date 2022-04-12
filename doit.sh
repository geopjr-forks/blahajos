#!/bin/sh -e

echo -e "\n" | abuild-keygen -i -a
sh mkimage.sh \
 --tag v3.15 \
 --outdir ./mnt/iso/ \
 --arch x86_64 \
 --repository http://dl-cdn.alpinelinux.org/alpine/latest-stable/main/ \
 --repository http://dl-cdn.alpinelinux.org/alpine/latest-stable/community/ \
 --profile blahaj
