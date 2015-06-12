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

if [ ! -e ~/vimrc ]; then
  touch ~/vimrc
  chown -R gen:gen ~/vimrc
  # rm ~/.vimrc
  # touch ~/.vimrc
  # chown -R gen:gen ~/.vimr
fi

sudo cat >> ~/vimrc << EOF
let g:exvim_custom_path='$exvim_home/'
source $exvim_home/.vimrc
EOF

# apt-get install ctags