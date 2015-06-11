#!/bin/bash
rvm implode

git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
# 用来编译安装 ruby
git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
# 用来管理 gemset, 可选, 因为有 bundler 也没什么必要
# git clone git://github.com/jamis/rbenv-gemset.git  ~/.rbenv/plugins/rbenv-gemset
# 通过 gem 命令安装完 gem 后无需手动输入 rbenv rehash 命令, 推荐
git clone git://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash
# 通过 rbenv update 命令来更新 rbenv 以及所有插件, 推荐
git clone https://github.com/rkh/rbenv-update.git ~/.rbenv/plugins/rbenv-update

# Unubtu请放到 ~/.bashrc 里, zsh用户是 ~/.zshrc
if [ $SHELL = "/bin/zsh" ]; then
  cat > ~/.zsh << EOF
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
  EOF
else if [ $SHELL = "/bin/bash" ]; then
  cat > ~/.bashrc << EOF
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
  EOF
fi

# 安装ruby
rbenv install --list
echo "输入需要安装的版本:"
read ruby_version
rbenv install $ruby_version

gem install rails
gem sources -l
gem sources -r https://rubygems.org/
gem sources -a https://ruby.taobao.org/
gem sources -u
gem sources -l

grep -i "gem: --no-ri --no-rdoc" .gemrc
reval=$?
if [ $reval -eq 1 ];then
  echo "\ngem: --no-ri --no-rdoc" >> .gemrc
fi


# 默认系统使用 $ruby_version
rbenv global $ruby_version      
# 当前的 shell 使用 $ruby_version, 会设置一个 `RBENV_VERSION` 环境变量
# rbenv shell $ruby_version
# 当前目录使用 $ruby_version, 会生成一个 `.rbenv-version` 文件 
# rbenv local $ruby_version

# 每当切换 ruby 版本和执行 bundle install 之后必须执行这个命令.
# rbenv-gem-rehash安装后,无需手动输入 rbenv rehash
# rbenv rehash
# 列出 irb 这个命令的完整路径
# rbenv which irb
# 列出包含 irb 这个命令的版本
# rbenv whence irb


### 解决 MacOSX 下编译 Ruby 无法在 irb 中输入中文的方法
# 安装 homebrew 的 readline，再进入源码目录，重新编译安装 readline.bundle

# brew install readline
# brew link readline
# cd src/ruby-1.9.3-p392/ext/readline
# ruby extconf.rb --with-readline-dir=$(brew --prefix readline)
# make install

#rbenv 下的解决办法

# brew install readline
# CONFIGURE_OPTS="--disable-install-doc --with-readline-dir=$(brew --prefix readline)" rbenv install 1.9.3-p392

# 有关 ruby-2.0.0-p0 在 OS X 10.7+ 上的问题，参见：https://github.com/sstephenson/ruby-build/wiki


