#!/bin/bash

# move into data dir
cd regData

# unwrap payload
tar -xzf payload.tar.gz

# decrypt
./dec.sh payload.tar.gz.enc ~/.ssh/id_rsa

# extract
tar -xzf payload.tar.gz

# load
echo "\nLoading data into database. "
mysql -h db -u root -p < dump.sql

# insert Rapporteket config
mkdir -p $R_RAP_CONFIG_PATH
mv rapbaseConfig.yml $R_RAP_CONFIG_PATH
mv dbConfig.yml $R_RAP_CONFIG_PATH

# celan-up
rm -f dump.sql key key.enc payload.*

# finish
cd
