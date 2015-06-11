wget http://download.redis.io/releases/redis-3.0.2.tar.gz ~
tar -xvzf redis-3.0.2.tar.gz
cd ~/redis-3.0.2 
make && sudo make install

sudo cp redis.config /etc/
sudo sed -i "s/^daemonize no/daemonize yes/g" /etc/redis.conf
sudo sed -i "s/^logfile \"\"/logfile \/var\/log\/redis\/redis.log/g" /etc/redis.conf
sudo sed -i "s/^dir .\//dir \/var\/lib\/redis/g" /etc/redis.conf

sudo useradd redis
sudo mkdir -p /var/lib/redis
sudo mkdir -p /var/log/redis
sudo chown redis.redis /var/lib/redis
sudo chown redis.redis /var/log/redis

sudo wget https://github.com/dmzsz/master/etc/init.d/redis-server -O /etc/init.d/redis-server
sudo chmod +x /etc/init.d/redis-server
# 设置开机自动启动，关机自动关闭
sduo update-rc.d redis-server defaults
