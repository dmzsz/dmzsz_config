#!/bin/bash
sudo apt-get install zsh
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
sed -i "s/plugins=(git)/plugins=(git ruby rake bundler)/g" ~/.zshrc
# Change your default shell
chsh -s /bin/zsh

# If you want to uninstall oh-my-zsh, just run: 
# uninstall_oh_my_zsh
# if you'd like to upgrade at any point in time  you just need to run: 
# upgrade_oh_my_zsh