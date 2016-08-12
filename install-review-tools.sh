#!/bin/bash
set -ex

# Install the additional tools for reviews.

HOME=/home/ubuntu

# Add tims awesome PPA for the 2.0 bleeding edge tooling
sudo add-apt-repository -y ppa:tvansteenburgh/ppa

sudo apt-get update -qqy
sudo apt-get install -qy amulet \
                         build-essential \
                         cython \
                         charm-tools \
                         git \
                         make \
                         python-dev \
                         python3-dev \
                         python-pip \
                         python3-pip \
                         python-virtualenv \
                         rsync  \
                         unzip

sudo pip install --upgrade pip
sudo pip install --upgrade bundletester flake8 pyyaml tox

base_directory=$PWD

# Temporarily install amulet from github to get the latest changes.
git clone https://github.com/juju/amulet /tmp/amulet
cd /tmp/amulet
pip install --upgrade ./
pip3 install --upgrade ./
cd $base_directory
rm -rf /tmp/amulet

# Temporarily install python-jujuclient from launchpad to get latest changes.
bzr branch lp:python-jujuclient /tmp/python-jujuclient
cd /tmp/python-jujuclient
pip install --upgrade ./
pip3 install --upgrade ./
cd $base_directory
rm -rf /tmp/python-jujuclient

# Temporarily install charm-tools from github to get the latest changes.
git clone https://github.com/juju/charm-tools /tmp/charm-tools
cd /tmp/charm-tools
pip install --upgrade ./
pip3 install --upgrade ./
cd $base_directory
rm -rf /tmp/charm-tools

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
