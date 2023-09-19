#!/bin/sh

echo ""
echo "+--------------------------------+"
echo "|   Starting reverSSHi client    |"
echo "+--------------------------------+"
echo ""

if [ ! -z "$REVERSSHI_PUBLIC_KEY" ] && [ ! -z "$REVERSSHI_PRIVATE_KEY" ]; then
    echo "Copying keys from environment"
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh
    echo "$REVERSSHI_PUBLIC_KEY" > ~/.ssh/id_rsa.pub
    chmod 644 ~/.ssh/*.pub
    echo "$REVERSSHI_PRIVATE_KEY" > ~/.ssh/id_rsa
    chmod 600 ~/.ssh/*
else
    echo "Generating client keys"
    ssh-keygen \
        -q \
        -f /root/.ssh/id_rsa \
        -t rsa \
        -N ""
fi

echo "Generating host keys"
ssh-keygen \
    -q \
    -f /etc/ssh/ssh_host_rsa_key \
    -t rsa \
    -b 4096 \
    -N ""

/usr/sbin/sshd \
    -D \
    -e
