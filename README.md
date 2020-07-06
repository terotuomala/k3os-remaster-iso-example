# k3os-remaster-iso-example
An example [k3os](https://github.com/rancher/k3os) ISO remastering using Docker.

<!-- TABLE OF CONTENTS -->
## Table of Contents

* [Features](#features)
* [Prerequisites](#prerequisites)
* [Usage](#usage)

<!-- FEATURES -->
## Features
- Docker image (Ubuntu 20.04) with all the necessary tools installed in order to [remaster](https://github.com/rancher/k3os#remastering-iso) the k3os ISO file.
- Customizable configuration ([config.yml](https://github.com/terotuomala/k3os-remaster-iso-example/blob/master/config.yml) and [grub.cfg](https://github.com/terotuomala/k3os-remaster-iso-example/blob/master/grub.cfg)) which can be modified before executing the Docker container that does the actual remastering.
- Possibility to use different [k3os release versions](https://github.com/rancher/k3os/releases) by defining it as an environment variable when executing the Docker container.
- Access to the remastered ISO file from the directory where the Docker container was executed.

<!-- PREREQUISITES -->
## Prerequisites
**NB.** The setup is tested on `macOS Mojave`.

Docker Desktop [installed](https://docs.docker.com/install/).
```sh
# If you don't want to sign up in order to download Docker
# use the following command to download the installer directly
$ curl -s https://download.docker.com/mac/stable/Docker.dmg
```
Edit the [config.yml](https://github.com/terotuomala/k3os-remaster-iso-example/blob/master/config.yml) to fit your needs. The configuration refence can be found from [here](https://github.com/rancher/k3os#configuration-reference).
```yaml
ssh_authorized_keys:
- github:terotuomala
hostname: k3os
k3os:
  sysctl:
    kernel.printk: "4 4 1 7"
    kernel.kptr_restrict: "1"
  dns_nameservers:
  - 8.8.8.8
  - 1.1.1.1
  ntp_servers:
  - 0.fi.pool.ntp.org
  - 1.fi.pool.ntp.org
  - 2.fi.pool.ntp.org
  - 3.fi.pool.ntp.org
  password: rancher
  k3s_args:
  - server
  - "--no-deploy=traefik"
```

<!-- USAGE -->
## Usage
Build the Docker image:
```sh
$ docker build -t k3os-custom-iso .
```
Run the Docker container using the image build in previous step:
```sh
$ docker run --rm -it -v ${PWD}:/k3os --privileged k3os-custom-iso
```
In order to use different **k3os** version than the default one **v0.11.0-rc1** please add the desired [release version](https://github.com/rancher/k3os/releases) as an environment variable:
```sh
$ docker run --rm -it -v ${PWD}:/k3os --privileged -e k3os_release_version=<DESIRED_RELEASE_VERSION> k3os-custom-iso
```
The remastered ISO file **k3os-custom.iso** can be found from the directory where the Docker container was executed.