FROM ubuntu:jammy

WORKDIR /k3os

RUN apt update && apt install wget grub-efi grub-pc-bin mtools xorriso -y

ENV k3os_release_version v0.21.5-k3s2r1
ENV k3os_filename k3os-amd64.iso

CMD [ "sh", "-c", "./create_custom_iso.sh ${k3os_release_version} ${k3os_filename}" ]