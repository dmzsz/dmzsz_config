#!/bin/bash
key_file=/tmp/nginx_signing.key
if [ ! -f $key_file ]; then
  echo "$key_file no exits, begin download";
  wget --user=gen http://nginx.org/keys/nginx_signing.key -O $key_file
  # curl http://nginx.org/keys/nginx_signing.key | sudo apt-key add -
else
  echo "$key_file exits"
fi
sudo apt-key add $key_file

# codename=`lsb_release -c |awk '{print $2}'`
codename=$(lsb_release -sc)
source_url=/etc/apt/sources.list

grep -i "deb .*nginx.*" $source_url
reval=$?
if [ $reval -eq 1 ];then
  cat << 'EOF' | sudo tee -a $source_url
# nginx
deb http://nginx.org/packages/ubuntu/ $codename nginx
deb-src http://nginx.org/packages/ubuntu/ $codename nginx
EOF
else
  # 删除行
  sudo sed -i '/^deb .*nginx.*/d' $source_url
  sudo sed -i '/^deb-src .*nginx.*/d' $source_url
  cat << 'EOF' | sudo tee -a $source_url
deb http://nginx.org/packages/ubuntu/ $codename nginx
deb-src http://nginx.org/packages/ubuntu/ $codename nginx
EOF
fi

sudo apt-get update
sudo apt-get install nginx
