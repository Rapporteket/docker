#!/bin/bash

# set proxy
http_proxy="www-proxy.helsenord.no:8080"
https_proxy=$http_proxy

# get pubkey of user $1
curl -sf "https://github.com/$1.keys" | head -n1 > pubkey
echo "\nPubkey:\n"
echo `cat pubkey`


# archive and compress
tar -czf payload.tar.gz dump.sql dbConfig.yml rapbaseConfig.yml

# encrypt
./enc.sh payload.tar.gz pubkey

# add encrypted key to payload
tar -czf payload.tar.gz payload.tar.gz.enc key.enc

# cleanup
rm key key.enc pubkey payload.tar.gz.enc
