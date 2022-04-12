FROM alpine:3.15

# core tools
RUN apk add alpine-sdk build-base apk-tools alpine-conf busybox fakeroot syslinux xorriso squashfs-tools sudo git mtools dosfstools grub-efi coreutils

RUN adduser --uid 1000 -S build -G abuild \
 && echo "%abuild ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/abuild \
 && mkdir /build

USER build
WORKDIR /home/build

RUN ln -s aports/scripts/mnt/keys   .abuild

RUN git clone --depth 1 --branch 3.15-stable https://gitlab.alpinelinux.org/alpine/aports.git

WORKDIR /home/build/aports/scripts

RUN ln -s ./mnt/mkimg.blahaj.sh   mkimg.blahaj.sh
RUN ln -s ./mnt/genapkovl-blahaj.sh genapkovl-blahaj.sh

CMD [ "./mnt/doit.sh"]
