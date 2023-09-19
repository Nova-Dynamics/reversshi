#!/bin/sh

echo ""
echo "+-------------------------------+"
echo "|   Connecting to client...     |"
echo "+-------------------------------+"
echo ""

/usr/bin/ssh \
    -p 2223 \
    ${1:-root}@localhost
