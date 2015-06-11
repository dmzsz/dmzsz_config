#! /bin/bash
getconf LONG_BIT #查看操作系统位数
lsb_release -a #操作系统信息

if [ ! -d /usr/lib/jvm/jdk1.8 ]; then
  sudo mkdir -p /usr/lib/jvm/jdk1.8
fi

# wget http://download.oracle.com/otn-pub/java/jdk/8u45-b14/jdk-8u45-linux-x64.tar.gz ~
# tar -xzvf ~/jdk-8u45-linux-x64.tar.gz -C ~/
sudo cp -r ~/jdk1.8.0_45/* /usr/lib/jvm/jdk1.8/

grep -i "export JAVA_HOME=\/usr\/lib\/jvm\/jdk1.8" ~/.profile
reval=$?
if [ $reval -eq 1 ];then
  echo "\nexport JAVA_HOME=/usr/lib/jvm/jdk1.8" >> ~/.profile
fi

# source ~/.profile # jdk_setup.sh: source: not found
# echo $env

# 将系统默认的jdk修改过来
sudo update-alternatives --install /usr/bin/java java   /usr/lib/jvm/jdk1.8/bin/java  300
# 输入sun jdk前的数字就好了
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.8/bin/javac 300
sudo update-alternatives --config java
sudo update-alternatives --config javac

java -version