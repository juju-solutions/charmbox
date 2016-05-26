#!/bin/bash
set -e
HOME=/home/ubuntu

# Add tims awesome PPA for the 2.0 bleeding edge tooling
sudo add-apt-repository -y ppa:tvansteenburgh/ppa
sudo apt-get update -qqy
sudo apt-get install -qy unzip \
                         build-essential\
                         charm-tools \
                         python-dev \
                         python-pip \
                         python-virtualenv \
                         rsync  \
			 make
sudo pip install bundletester flake8 pyyaml tox --upgrade


# Fix for CI choking on duplicate hosts if the host key has changed
# which is common. 
mkdir -p $HOME/.ssh
echo 'Host *' > $HOME/.ssh/config
echo '  StrictHostKeyChecking no' >> $HOME/.ssh/config

# Chuck hates this
touch $HOME/.vimrc
echo "alias vim=vi" >> /home/ubuntu/.bashrc

echo "export LAYER_PATH=${HOME}/layers" >> /home/ubuntu/.bashrc
echo "export INTERFACE_PATH=${HOME}/interfaces" >> /home/ubuntu/.bashrc

chown -R ubuntu:ubuntu ${HOME}

