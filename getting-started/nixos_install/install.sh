#!/bin/sh

cat NixosInstall.bin | NIX_CHANNEL=nixos-20.09 bash 2>&1 | tee /tmp/infect.log
