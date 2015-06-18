#!/bin/bash
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable

[ -s "$HOME/.profile" ] && source "home/discourse/.profile"
[ -s "$HOME/.rvm/scripts/rvm" ] && source "home/discourse/.rvm/scripts/rvm"

source ~/.bashrc
source ~/.bash_profile

gem sources --remove https://rubygems.org/
gem sources -a https://ruby.taobao.org/

rvm list known
echo "输入需要安装的版本:"
read ruby_version
rvm install $ruby_version

grep -i "gem: --no-ri --no-rdoc" ~/.gemrc
reval=$?
if [ $reval -eq 1 -o $reval -eq 2 ]; then
  echo "\ngem: --no-ri --no-rdoc" >> ~/.gemrc
fi
rvm -v
rvm use 2.2
ruby -v
gem -v
gem install rails
