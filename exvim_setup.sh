# #!/bin/bash
exvim_home=/opt/exvim

if [ ! -d $exvim_home ]; then
  mkdir $exvim_home
else
  rm -rf $exvim_home
  mkdir  $exvim_home
fi

git clone https://github.com/exvim/main $exvim_home
cd $exvim_home
sh unix/install.sh

if [ ! -e ~/.vimrc ]; then
  touch ~/.vimrc
  chown -R gen:gen ~/.vimrc
  rm /etc/vim/.vimrc
  touch ~/.vimrc
  chown -R gen:gen ~/.vimrc
fi

grep -i "let g:exvim_custom_path=" /etc/vim/vimrc
reval=$?
if [ $reval -eq 1 ];then
  cat >> /etc/vim/vimrc << EOF

let g:exvim_custom_path='$exvim_home/'
source $exvim_home/.vimrc
EOF
else
  # 删除行
  sed -i '/^let g:exvim_custom_path=.*/d' /etc/vim/vimrc
  sed -i '/^source .*\/\.vimrc.*/d' /etc/vim/vimrc
  cat << EOF >> /etc/vim/vimrc
let g:exvim_custom_path='$exvim_home/'
source $exvim_home/.vimrc
EOF
fi


apt-get install ctags

# cat >> /etc/vim/vimrc << EOF
# let g:exvim_custom_path='/opt/exvim/'
# source $exvim_home/.vimrc
# EOF

# cat << EOF >> /etc/vim/vimrc 
# let g:exvim_custom_path='/opt/exvim/'
# source $exvim_home/.vimrc
# EOF