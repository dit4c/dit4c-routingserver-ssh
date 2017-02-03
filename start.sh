#!/bin/sh
set -e

# Enforce assumption that /dev/shm is not sticky
chmod 0755 /dev/shm

export SSH_KEYDIR=${SSH_KEYDIR:-/dev/shm/ssh_host_keys}
export UPSTREAMS_DIR=${UPSTREAMS_DIR:-/dev/shm/upstreams}

# Create host key if necessary
mkdir -p $SSH_KEYDIR
test -e $SSH_KEYDIR/ssh_host_rsa_key || ssh-keygen -t rsa -f $SSH_KEYDIR/ssh_host_rsa_key

# Create upstreams directory
mkdir -p $UPSTREAMS_DIR
chown nginx $UPSTREAMS_DIR

mkdir -p /dev/shm/bin
# Generate nginx config & register-login
confd -onetime -backend env
exec /bin/s6-svscan /etc/services.d
