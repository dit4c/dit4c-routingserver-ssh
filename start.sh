#!/bin/sh
set -e

# Enforce assumption that /dev/shm is not sticky
chmod 0755 /dev/shm

export SSH_KEYDIR=${SSH_KEYDIR:-/dev/shm/ssh_host_keys}
export UPSTREAMS_DIR=${UPSTREAMS_DIR:-/dev/shm/upstreams}
export PGP_CACHEDIR=${PGP_CACHEDIR:-/dev/shm/listen_keys}

# Create host key if necessary
mkdir -p $SSH_KEYDIR
test -e $SSH_KEYDIR/ssh_host_rsa_key || ssh-keygen -q -t rsa -N '' -f $SSH_KEYDIR/ssh_host_rsa_key

# Create upstreams directory
mkdir -p $UPSTREAMS_DIR
chown nginx $UPSTREAMS_DIR

# Create directory for listen account keys
mkdir -p $PGP_CACHEDIR
chown register $PGP_CACHEDIR

mkdir -p /dev/shm/bin
# Generate nginx config & register-login
confd -onetime -backend env

# Check configs (fail fast)
/usr/sbin/nginx -t -c /dev/shm/nginx.conf
/usr/sbin/sshd -t -f /dev/shm/sshd_config

# Start services
exec /bin/s6-svscan /etc/services.d
