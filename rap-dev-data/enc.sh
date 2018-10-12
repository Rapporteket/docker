#!/bin/bash

INFILE=$1
PUBKEY=$2

ENCFILE="$1.enc"

# make aes256 sym key
openssl rand -out key 32

# encrypt with symetric key
openssl aes-256-cbc -md sha256 -in $INFILE -out $ENCFILE -pass file:key

# encrypt symetric key with (asymetric) pub key
openssl rsautl -encrypt -oaep -pubin -inkey \
  <(ssh-keygen -e -f $PUBKEY -m PKCS8) -in key -out key.enc
