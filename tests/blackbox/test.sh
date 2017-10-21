#!/usr/bin/env test

# install dependencies
#apt install -qq netcat

# configure zeyple
cp ../../zeyple/zeyple.conf.example /etc/zeyple.conf

# emulate postfix reinjection listening port
# this will simply receive any data and save it as a file
nc -l 10026 > email.eml &

# send an email, route it through zeyple
# zeyple will process the mail and send it to the postfix emulator (see above)
echo "lalala" | python ../../zeyple/zeyple.py user@domain.invalid

# ...
echo contents of final mail are
cat email.eml
