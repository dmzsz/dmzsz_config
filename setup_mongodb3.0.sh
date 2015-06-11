sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo service mongod start
# sudo service mongod stop
# sudo service mongod restart

### Uninstall MongoDB
## Stop the mongod process by issuing the following command:
# sudo service mongod stop
## Remove any MongoDB packages that you had previously installed.
# sudo apt-get purge mongodb-org*
## Remove MongoDB databases and log files.
# sudo rm -r /var/log/mongodb
# sudo rm -r /var/lib/mongodb

exit 1;