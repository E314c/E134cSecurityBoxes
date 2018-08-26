#!/bin/sh
# Build the vulnerable executable without stack-protection and without being a position-independent-execution
gcc vuln.c -g -m32 -o vuln \
    -fno-stack-protector \
    -no-pie