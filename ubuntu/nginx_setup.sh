#!/bin/bash
key_file=/tmp/nginx_signing.key
if [ ! -f $key_file ]; then
  echo "$key_file no exits, begin download";
  wget --user=gen http://nginx.org/keys/nginx_signing.key -O $key_file
  chown gen:gen $key_file
else
  echo "$key_file exits"
fi
apt-key add $key_file

codename=`lsb_release -c |awk '{print $2}'`

grep -i "deb .*nginx.*" /etc/apt/sources.list
reval=$?
if [ $reval -eq 1 ];then
  cat >> /etc/apt/sources.list << EOF

# nginx
deb http://nginx.org/packages/ubuntu/ $codename nginx
deb-src http://nginx.org/packages/ubuntu/ $codename nginx
EOF
else
  # 删除行
  sed -i '/^deb .*nginx.*/d' /etc/apt/sources.list
  sed -i '/^deb-src .*nginx.*/d' /etc/apt/sources.list
  cat << EOF >> /etc/apt/sources.list
deb http://nginx.org/packages/ubuntu/ $codename nginx
deb-src http://nginx.org/packages/ubuntu/ $codename nginx
EOF
fi



# apt-get update
# apt-get install nginx
