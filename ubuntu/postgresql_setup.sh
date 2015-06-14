# deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -sc)-pgdg main
# wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
# sudo apt-get update 
# sudo apt-get install postgresql
# sudo apt-get install pgadmin3
# psql --version
# pgadmin3 --version

## 修改postgres登陆密码
# 安装完毕后，系统会创建一个数据库超级用户“postgres”, 密码为空不能通过连接登陆。
# 这个用户既是不可登录的操作系统用户，也是数据库用户.
# 修改数据库ubuntu用户postgres的密码
# echo "修改数据库ubuntu用户postgres的密码"
# # sudo passwd postgres
# # 切换到ubuntu下postgres用户,登录postgres数据库
# sudo su - postgres -c psql postgres <<EOF
# ALTER USER postgres with PASSWORD 'psql'
# \q
# EOF

## 创建普通数据库用户
# http://www.php100.com/manual/PostgreSQL8/app-createuser.html
# 1.用户可以创建数据库、用户不可以创建其他用户、该用户不是超级用户,提示符要求输入新用户的口令。
# 不创建数据库 没法登陆用户
# 用户名必须都是小写,sql语句不去分大小写
sudo su - postgres <<!
createuser -A -d -e gen
# 创建一个属于自定义用户genAdmin的数据库
createdb -O gen gendb
# alert user gen with password 'psql' 所有语句全变成小写!!!!
psql gendb <<EOF
ALTER USER gen with PASSWORD 'gen'
\q
EOF
!

# 创建用户的同时,提示建立密码
# sudo su - postgres <<EOF
# createuser -AdeP genAdmin
# createdb -O genAdmin gendb
# EOF

# 删除用户之先前在postgres用户下删除genAdmin的数据库
# sudo su - postgres<<EOF
# dropdb gendb
# dropuser gen
# EOF
