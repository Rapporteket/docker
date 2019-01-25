#!/bin/bash

# only run if mount of ssh-files to /tmp/.ssh is requested (in 'run' or
# 'compose')

if [ -d /tmp/.ssh ]; then
  echo "Copy and chmod ssh key files..."
  cp -R /tmp/.ssh /home/rstudio/.ssh
  chmod 700 /home/rstudio/.ssh
  chmod 600 /home/rstudio/.ssh/*
  chmod 644 /home/rstudio/.ssh/*.pub
  echo ""
fi

# move into data dir
echo "Moving into data directory..."
cd regData
echo ""

if [ ! -f ./payload.tar.gz ]; then
  echo ""
  echo "This container is likely based on a previous (initial) state."
  echo "Hence, data is probably already present. Keep on working!"
  echo ""
  echo "To keep your data safe, please consider running"
  echo "'docker rm -vf \$(docker ps -a -q)' after terminating this container."
  echo "Then, run this script again next time the container is started."
  echo ""
  echo "Exiting."
  echo ""
  
  exit
fi


# unwrap payload
echo "Unwraping payload"
tar -xzf payload.tar.gz
echo ""

# decrypt
echo "Decrypt payload using your private key"
./dec.sh payload.tar.gz.enc ~/.ssh/id_rsa
echo ""

# extract
echo "Extract payload" 
tar -xzf payload.tar.gz
echo ""

# load
echo "Loading data into database. "
mysql -h db -u root -p < dump.sql
echo ""

# insert Rapporteket config
echo "Inserting config"
mkdir -p $R_RAP_CONFIG_PATH
mv rapbaseConfig.yml $R_RAP_CONFIG_PATH
mv dbConfig.yml $R_RAP_CONFIG_PATH
echo ""

# celan-up
echo "Cleaning up"
rm -f dump.sql key key.enc payload.*
echo ""

# finish
cd
echo "Finished"
echo ""
