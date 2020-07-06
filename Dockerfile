FROM ubuntu:focal

WORKDIR /k3os

RUN apt update && apt install wget grub-efi grub-pc-bin mtools xorriso -y

ENV k3os_release_version v0.11.0-rc1
ENV k3os_filename k3os-amd64.iso

CMD [ "sh", "-c", "./create_custom_iso.sh ${k3os_release_version} ${k3os_filename}" ]


