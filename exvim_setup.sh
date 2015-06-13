# #!/bin/bash
sudo apt-get install vim
exvim_home=/opt/exvim

if [ ! -d $exvim_home ]; then
  sudo mkdir $exvim_home
else
  sudo rm -rf $exvim_home
  sudo mkdir  $exvim_home
fi

sudo git clone https://github.com/exvim/main $exvim_home
cd $exvim_home
sudo sh unix/install.sh

# if [ ! -f ~/.vimrc ]; then
#   touch ~/.vimrc
# fi
vimrc_url=/usr/share/vim/vimrc
grep -i "let g:exvim_custom_path=" $vimrc_url
reval=$?
if [ $reval -eq 1 ];then
  echo "
let g:exvim_custom_path='$exvim_home/'
source $exvim_home/.vimrc" | sudo tee -a $vimrc_url
else
  # 删除行
  sudo sed -i '/^let g:exvim_custom_path=.*/d' $vimrc_url
  sudo sed -i '/^source .*\/\.vimrc.*/d' $vimrc_url
  echo "let g:exvim_custom_path='$exvim_home/'
source $exvim_home/.vimrc"| sudo tee -a $vimrc_url
fi

sudo apt-get install ctags

# cat >> /etc/vim/vimrc << EOF
# let g:exvim_custom_path='/opt/exvim/'
# source $exvim_home/.vimrc
# EOF

# cat << EOF >> /etc/vim/vimrc 
# let g:exvim_custom_path='/opt/exvim/'
# source $exvim_home/.vimrc
# EOF