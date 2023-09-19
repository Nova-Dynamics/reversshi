
REVERSSHI_HOST=${1:-localhost}
REVERSSHI_PORT=${2:-2222}

touch ~/.ssh/authorized_keys
ssh \
    -o "UserKnownHostsFile /dev/null" \
    -o "StrictHostKeyChecking no" \
    -p "$REVERSSHI_PORT" \
    reversshi@$REVERSSHI_HOST \
    "./keys.sh" > ~/.ssh/authorized_keys

ssh \
    -o "UserKnownHostsFile /dev/null" \
    -o "StrictHostKeyChecking no" \
    -N \
    -T \
    -R2223:localhost:22 \
    -p "$REVERSSHI_PORT" \
    reversshi@$REVERSSHI_HOST
