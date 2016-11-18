#!/bin/bash
set -ex

# Bundletester and friends in tims ppa
sudo add-apt-repository -u -y ppa:tvansteenburgh/ppa

sudo apt-get update -qq
sudo apt-get install -qy  \
                     build-essential \
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

sudo apt install --no-install-recommends charm

sudo pip install --upgrade pip six
sudo pip install amulet charm-tools flake8 bundletester tox
sudo pip3 install --upgrade pip
sudo pip3 install amulet

# Install charm-tools from source
git clone https://github.com/juju/charm-tools /tmp/charm-tools
cd /tmp/charm-tools
sudo pip2 install .
cd ..
rm -rf charm-tools

# Fix for CI choking on duplicate hosts if the host key has changed
# which is common. 
mkdir -p $HOME/.ssh
echo 'Host *' > $HOME/.ssh/config
echo '  StrictHostKeyChecking no' >> $HOME/.ssh/config

