#!/bin/sh

echo ""
echo "+--------------------------------+"
echo "|   Starting reverSSHi server    |"
echo "+--------------------------------+"
echo ""

# Setup Call in keys
if [ ! -z "$REVERSSHI_CALL_IN_PUBLIC_KEY" ]; then
    echo "Copying call in key from environment"
    echo "$REVERSSHI_CALL_IN_PUBLIC_KEY" >> /home/reversshi/.ssh/authorized_keys
else
    echo "Generating call in key, saving to /home/reversshi/keys/call_in/id_rsa"
    # Generate a key for call in
    echo ""
    ssh-keygen \
        -q \
        -f /home/reversshi/keys/call_in/id_rsa \
        -t rsa \
        -b "${REVERSSHI_CALL_IN_KEY_BYTES:-4096}" \
        -N ""
    cat /home/reversshi/keys/call_in/id_rsa.pub >> /home/reversshi/.ssh/authorized_keys
fi
if [ ! -z "$REVERSSHI_CLIENT_PUBLIC_KEY" ]; then
    echo "Copying client key from environment"
    echo "$REVERSSHI_CLIENT_PUBLIC_KEY" >> /home/reversshi/.ssh/authorized_keys
    echo "$REVERSSHI_CLIENT_PUBLIC_KEY" > /etc/reversshi/client_rsa.pub
fi

echo "Setting forwarding port"
echo -n "$REVERSSHI_FORWARD_PORT" > /etc/reversshi/forward_port

echo "Setting file permissions"
chown -R reversshi /home/reversshi
chmod 700 /home/reversshi/.ssh
chmod 600 /home/reversshi/.ssh/authorized_keys

# Setup client key

# Setup host in keys
if [ ! -z "$REVERSSHI_HOST_PUBLIC_KEY" ] && [ ! -z "$REVERSSHI_HOST_PRIVATE_KEY" ]; then
    echo "Copying host keys from environment"
    echo "$REVERSSHI_HOST_PUBLIC_KEY" > /etc/ssh/ssh_host_rsa_key.pub
    echo "$REVERSSHI_HOST_PRIVATE_KEY" > /etc/ssh/ssh_host_rsa_key
else
    echo "Generating host keys"
    ssh-keygen \
        -q \
        -f /etc/ssh/ssh_host_rsa_key \
        -t rsa \
        -b "${REVERSSHI_HOST_KEY_BYTES:-4096}" \
        -N ""
fi

mkdir ~/.ssh
ln -s /etc/ssh/ssh_host_rsa_key.pub ~/.ssh/id_rsa.pub
ln -s /etc/ssh/ssh_host_rsa_key ~/.ssh/id_rsa

# Start ssh server
/usr/sbin/sshd \
    -D \
    -e
