#!/bin/bash
set -e
HOME=/home/ubuntu

sudo apt-get update -qqy
sudo apt-get install -qy unzip \
                         build-essential\
                         charm-tools \
                         python-dev \
                         python-pip \
                         python-virtualenv \
                         python-tox \
                         rsync  \
			 make
sudo pip install bundletester flake8 pyyaml --upgrade

echo "export LAYER_PATH=${HOME}/layers" >> /home/ubuntu/.bashrc
echo "export INTERFACE_PATH=${HOME}/interfaces" >> /home/ubuntu/.bashrc

# Fix for CI choking on duplicate hosts if the host key has changed
# which is common. 
mkdir -p $HOME/.ssh
echo 'Host *' > $HOME/.ssh/config
echo '  StrictHostKeyChecking no' >> $HOME/.ssh/config

chown -R ubuntu:ubuntu ${HOME}

