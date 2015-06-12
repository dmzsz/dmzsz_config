#!/bin/bash
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.0.list
apt-get update
apt-get install -y mongodb-org
service mongod start
# service mongod stop
# service mongod restart

### Uninstall MongoDB
## Stop the mongod process by issuing the following command:
# service mongod stop
## Remove any MongoDB packages that you had previously installed.
# apt-get purge mongodb-org*
## Remove MongoDB databases and log files.
# rm -r /var/log/mongodb
# rm -r /var/lib/mongodb