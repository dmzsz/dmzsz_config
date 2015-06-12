#!/bin/bash
wget http://download.redis.io/releases/redis-3.0.2.tar.gz ~
tar -xvzf redis-3.0.2.tar.gz
cd ~/redis-3.0.2 
make && make install

cp redis.config /etc/
sed -i "s/^daemonize no/daemonize yes/g" /etc/redis.conf
sed -i "s/^logfile \"\"/logfile \/var\/log\/redis\/redis.log/g" /etc/redis.conf
sed -i "s/^dir .\//dir \/var\/lib\/redis/g" /etc/redis.conf

useradd redis
mkdir -p /var/lib/redis
mkdir -p /var/log/redis
chown redis.redis /var/lib/redis
chown redis.redis /var/log/redis

wget https://github.com/dmzsz/master/etc/init.d/redis-server -O /etc/init.d/redis-server
chmod +x /etc/init.d/redis-server
# 设置开机自动启动，关机自动关闭
sduo update-rc.d redis-server defaults
