#! /bin/bash
getconf LONG_BIT #查看操作系统位数
lsb_release -a #操作系统信息

echo "请到 http://www.oracle.com/technetwork/java/javase/downloads/index.html 下载tar.gz压缩包，并放在home目录下"
file_save_url=~/
# 有人说 -maxdepth 在他的系统中不能用
# ls $file_save_url | sed "s:^:`pwd`/: " | grep 'jdk-.*.tar.gz' | xargs -I {} tar xvzf {} -C /tmp
find $file_save_url -maxdepth 1 | grep 'jdk-.*.tar.gz' | xargs -I {} tar xvzf {} -C /tmp
file_url=`find /tmp -maxdepth 1 | grep 'jdk[1-9]*.[0-9]*.[0-9]*_[0-9]*'`
file_name=jdk1.`${file_url:10:1}`
if [ ! -d /usr/lib/jvm/${file_name} ]; then
  sudo mkdir -p /usr/lib/jvm/${file_name}
fi
sudo mv $file_url/* /usr/lib/jvm/${file_name}/

grep -i "export JAVA_HOME=" ~/.profile
reval=$?
if [ $reval -eq 1 ];then
  echo "\nexport JAVA_HOME=/usr/lib/jvm/jdk1.${first_level}" >> ~/.profile
else
  # 删除行
  sed  -i "/^export JAVA_HOME=.*$/d" ~/.profile
  echo "\nexport JAVA_HOME=/usr/lib/jvm/jdk1.${first_level}" >> ~/.profile
fi

# source ~/.profile # jdk_setup.sh: source: not found
# echo $env

# 将系统默认的jdk修改过来
sudo update-alternatives --install /usr/bin/java java   /usr/lib/jvm/jdk1.${first_level}/bin/java  300
# 输入sun jdk前的数字就好了
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.${first_level}/bin/javac 300
sudo update-alternatives --config java
sudo update-alternatives --config javac

java -version
