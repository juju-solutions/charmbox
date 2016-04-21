#!/bin/bash
set -e
HOME=/home/ubuntu

sudo apt-get update -qqy

# Fix for CI choking on duplicate hosts if the host key has changed
# which is common. 
mkdir -p $HOME/.ssh
echo 'Host *' > $HOME/.ssh/config
echo '  StrictHostKeyChecking no' >> $HOME/.ssh/config

# Chuck hates this
touch $HOME/.vimrc
echo "alias vim=vi" >> /home/ubuntu/.bashrc

sudo apt-get install -qy \
                        build-essential \
                        charm \
                        charm-tools \
                        python-dev \
                        python-flake8 \
                        python-pip \
                        python-virtualenv \
                        python-tox \
                        rsync \
                        unzip \
			make

echo "export LAYER_PATH=${HOME}/layers" >> /home/ubuntu/.bashrc
echo "export INTERFACE_PATH=${HOME}/interfaces" >> /home/ubuntu/.bashrc

chown -R ubuntu:ubuntu ${HOME}

