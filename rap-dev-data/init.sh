#!/bin/bash

# only run if mount of ssh-files to /tmp/.ssh is requested (in 'run' or
# 'compose')

echo ""

if [ -d /tmp/.ssh ]; then
  echo "Copy and chmod ssh key files..."
  cp -R /tmp/.ssh /home/rstudio/.ssh
  chmod 700 /home/rstudio/.ssh
  chmod 600 /home/rstudio/.ssh/*
  chmod 644 /home/rstudio/.ssh/*.pub
  echo ""
  echo "Converting ssh private key to ensure PEM format. Please hold your "
  echo "private key passwords ready (if any)."
  echo "Please note that this will only alter the private key inside the"
  echo "container and not your docker host source key."
  echo ""
  cd ~/.ssh
  ssh-keygen -f id_rsa -e -m pem -p
  cd ~/.
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
chmod ugo+rwx $R_RAP_CONFIG_PATH
mv rapbaseConfig.yml $R_RAP_CONFIG_PATH
mv dbConfig.yml $R_RAP_CONFIG_PATH
echo ""

# make sure files can be used for both 'rstudio' and 'shiny' users
echo "Creating template files and adjusting privileges"
cd $R_RAP_CONFIG_PATH
touch appLog.csv reportLog.csv
chmod ugo+rw *
mkdir autoReportBackup
chmod ugo+rwx autoReportBackup
cd ~
echo ""

# make odbc data source file
echo "Making .odbc.ini from config"
cd
sed 's/ : / = /g;s/:/]/g;/#/d;s/^\s*host/  SERVER/g;s/^\s*name/  DATABASE/g;s/^\s*user/  USER/g;s/^\s*pass/  PASSWORD/g;s/^\s*disp/  Description/g;s/^[A-Za-z]/[&/;s/^\s*//g;/^\[/aDriver = MariaDB Driver' $R_RAP_CONFIG_PATH/dbConfig.yml > .odbc.ini
echo ""

# clean-up
echo "Cleaning up"
cd regData
rm -f dump.sql key key.enc payload.*
echo ""

# finish
cd
echo "Finished"
echo ""
