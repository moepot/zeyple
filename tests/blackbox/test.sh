#!/usr/bin/env bash

# install dependencies
#apt install -qq netcat

cd ../../zeyple

# configure zeyple
sudo cp ./zeyple.conf.example /etc/zeyple.conf
sudo touch /var/log/zeyple.log
sudo chmod 777 /var/log/zeyple.log
rm __init__.py

# emulate postfix reinjection listening port
# this will simply receive any data and save it as a file
echo open postfix emulator
nc -l 10026 > email.eml &

# send an email, route it through zeyple
# zeyple will process the mail and send it to the postfix emulator (see above)
echo "lalala" | python ./zeyple.py user@domain.invalid

# ...
echo contents of final mail are
cat email.eml
