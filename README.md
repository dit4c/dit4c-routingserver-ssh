# dit4c-routing-server

[![Build Status](https://travis-ci.org/dit4c/dit4c-routingserver-ssh.svg?branch=master)](https://travis-ci.org/dit4c/dit4c-routingserver-ssh)

A routing server for DIT4C, based on SSH. It uses [NGINX](https://nginx.org/) to proxy requests, and reverse port forwarding over unix domain sockets to expose instances. Authentication is via PGP-based SSH keys, fetched from a configured server.

Used with [dit4c-helper-listener-ssh](https://github.com/dit4c/dit4c-helper-listener-ssh/). It can also be used stand-alone against any repository of PGP keys.

(It would also be trivial to rewrite `etc/confd/templates/register-login` to work with GitHub's SSH key API, as this was used during initial PoC testing.)
