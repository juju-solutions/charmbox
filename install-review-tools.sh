#!/bin/bash
set -e
HOME=/home/ubuntu

# Add tims awesome PPA for the 2.0 bleeding edge tooling
add-apt-repository -y ppa:tvansteenburgh/ppa

apt-get update -qqy
apt-get install -qy  \
                     build-essential \
                     cython \
                     git \
                     juju-deployer \
                     libssl-dev \
                     make \
                     python-dev \
                     python-jujuclient \
                     python3-dev \
                     python-pip \
                     python3-pip \
                     python-virtualenv \
                     rsync  \
                     unzip

apt install --no-install-recommends charm

pip install --upgrade pip six
pip install amulet charm-tools flake8 bundletester tox

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

