#!/bin/bash
file_name=redis-3.0.2
if [  ! -f  /tmp/${file_name}.tar.gz  ]; then
    wget http://download.redis.io/releases/${file_name}.tar.gz -O  /tmp/${file_name}.tar.gz 
fi
if [ ! -d /tmp/${file_name} ]; then
    tar -xvzf /tmp/${file_name}.tar.gz -C /tmp
fi
cd /tmp/${file_name}
make && sudo make install

sudo cp /tmp/${file_name}/redis.conf /etc/
sudo sed -i "s/^daemonize no/daemonize yes/g" /etc/redis.conf
sudo sed -i "s/^logfile \"\"/logfile \/var\/log\/redis\/redis.log/g" /etc/redis.conf
sudo sed -i "s/^dir .\//dir \/var\/lib\/redis/g" /etc/redis.conf

sudo useradd redis
sudo mkdir -p /var/lib/redis
sudo mkdir -p /var/log/redis
sudo chown redis.redis /var/lib/redis
sudo chown redis.redis /var/log/redis

if [  ! -f  /etc/init.d/redis-server  ]; then
    sudo wget https://raw.githubusercontent.com/dmzsz/dmzsz_config/master/ubuntu/etc/init.d/redis-server -O /etc/init.d/redis-server
fi
sudo chmod +x /etc/init.d/redis-server
# 设置开机自动启动，关机自动关闭
sudo update-rc.d redis-server defaults
sudo service redis-server start