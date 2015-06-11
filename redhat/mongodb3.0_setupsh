#!/bin/bash
if [ ! -e /etc/yum.repos.d/mongodb-org-3.0.repo ]; then
  touch  /etc/yum.repos.d/mongodb-org-3.0.repo
  cat > /etc/yum.repos.d/mongodb-org-3.0.repo <<EOF
[mongodb-org-3.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.0/x86_64/
gpgcheck=0
enabled=1
EOF
fi

sudo yum install -y mongodb-org

# Run MongoDB Important:
# You must configure SELinux to allow MongoDB to start on Red Hat Linux-based systems 
# (Red Hat Enterprise Linux or CentOS Linux). 
# Administrators have three options:
# enable access to the relevant ports (e.g. 27017) for SELinux
sudo semanage port -a -t mongod_port_t -p tcp 27017
# set SELinux to permissive mode in /etc/selinux.conf
sudo sed -i "s/SELINUX=enforcing/SELINUX=permissive/g" /etc/selinux.conf
# disable SELinux entirely; as above but set
# sudo sed -i "s/^SELINUX=.*$/SELINUX=disabled/g" /etc/selinux.conf

sudo service mongod start
sudo chkconfig mongod on

# sudo service mongod stop
# sudo service mongod restart

### Uninstall MongoDB
# This process will completely remove MongoDB, its configuration, and all databases.
# sudo service mongod stop
# sudo yum erase $(rpm -qa | grep mongodb-org)
# sudo rm -r /var/log/mongodb
# sudo rm -r /var/lib/mongodb