#!/bin/bash
set -e
source /electron-headless/buildconfig
set -x

apt-get update

## Install HTTPS support for APT.
$minimal_apt_get_install apt-transport-https ca-certificates

## Enable Ubuntu Universe and Multiverse.
sed -i 's/^#\s*\(deb.*universe\)$/\1/g' /etc/apt/sources.list
sed -i 's/^#\s*\(deb.*multiverse\)$/\1/g' /etc/apt/sources.list

cat /electron-headless/nodesource.gpg.key | apt-key add -

## Creating apt sources list file for the NodeSource Node.js 4.x LTS Argon repo...
echo 'deb https://deb.nodesource.com/node_4.x trusty main' > /etc/apt/sources.list.d/nodesource.list
echo 'deb-src https://deb.nodesource.com/node_4.x trusty main' >> /etc/apt/sources.list.d/nodesource.list

apt-get update

## Prevent initramfs updates from trying to run grub and lilo.
## https://journal.paul.querna.org/articles/2013/10/15/docker-ubuntu-on-rackspace/
## http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=594189
export INITRD=no
mkdir -p /etc/container_environment
echo -n no > /etc/container_environment/INITRD

## Fix locale.
$minimal_apt_get_install language-pack-en
locale-gen en_US
update-locale LANG=en_US.UTF-8 LC_CTYPE=en_US.UTF-8
echo -n en_US.UTF-8 > /etc/container_environment/LANG
echo -n en_US.UTF-8 > /etc/container_environment/LC_CTYPE
