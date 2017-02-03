#!/bin/sh

set -ex

# Configure DNS
rm /etc/resolv.conf
echo nameserver 8.8.8.8 > /etc/resolv.conf

# Install packages
apk update
apk add curl gnupg openssh s6 sudo
rm -rf /var/cache/apk/*

# Correct file ownerships
chown -R root:root /etc/confd /start.sh /etc/sudoers
chmod 400 /etc/sudoers

# Create SSH users
adduser -D register && passwd -u register
adduser -D listen && passwd -u listen

# register user will be using GPG - ensure base files exists
su - register -c 'gpg2 --list-keys'

# Cleanup DNS config
rm -f /etc/resolv.conf
