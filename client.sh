
# export $(cat .env | sed 's/[ ]*#.*//g' | xargs -d "\n")

# ssh-keygen -f "~/.ssh/known_hosts" -R "[localhost]:2222"

ssh \
    -o "UserKnownHostsFile /dev/null" \
    -o "StrictHostKeyChecking no" \
    -N \
    -T \
    -R${REVERSSHI_FORWARD_PORT:-2223}:localhost:22 \
    -p "${REVERSSHI_PORT:-2222}" \
    reversshi@${REVERSSHI_HOST:-localhost}
