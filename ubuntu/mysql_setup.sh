wget http://dev.mysql.com/get/mysql-apt-config_0.3.5-1ubuntu14.04_all.deb -O /tmp/mysql-apt-config_0.3.5-1ubuntu14.04_all.deb
sudo dpkg -i /tmp/mysql-apt-config_0.3.5-1ubuntu14.04_all.deb
# 打开配置
# sudo dpkg-reconfigure mysql-apt-config
sudo apt-get update
sudo apt-get install mysql-server 
sudo apt-get install mysql-workbench-community
sudo apt-get install libmysqlclient18
