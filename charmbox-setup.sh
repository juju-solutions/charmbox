#!/bin/bash
set -ex

# Bundletester and friends in tims ppa
sudo add-apt-repository -u -y ppa:tvansteenburgh/ppa

sudo apt-get update -qq
sudo apt-get install -qy  \
                     build-essential \
                     git \
                     juju-deployer \
                     libssl-dev \
                     make \
                     python-dev \
                     python-jujuclient \
                     python-pip \
                     python-virtualenv \
                     python3-dev \
                     python3-pip \
                     rsync  \
                     unzip

sudo apt install --no-install-recommends charm

sudo pip install --upgrade pip six
sudo pip install amulet flake8 bundletester tox
sudo pip3 install --upgrade pip
sudo pip3 install amulet flake8

# Install charm-tools from source
git clone https://github.com/juju/charm-tools /tmp/charm-tools
cd /tmp/charm-tools
sudo pip2 install .
cd ..
rm -rf charm-tools
git clone https://github.com/juju-solutions/matrix.git
cd matrix
sudo pip3 install . -f wheelhouse --no-index
cd ..
rm -rf matrix
