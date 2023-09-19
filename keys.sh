#!/bin/sh

cat /etc/ssh/ssh_host_rsa_key.pub
if [ -e /etc/reversshi/client_rsa.pub ]; then
    cat /etc/reversshi/client_rsa.pub
fi
