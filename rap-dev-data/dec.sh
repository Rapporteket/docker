#!/bin/bash

ENCFILE=$1
PRIKEY=$2

FILE=`echo "$1" | sed 's/.enc//'`

# decrypt symetric key with asymetric (private) key
openssl rsautl -decrypt -oaep -inkey $PRIKEY -in key.enc -out key

# decrypt with symetric key
openssl aes-256-cbc -md sha256 -d -in $1 -out $FILE -pass file:key
