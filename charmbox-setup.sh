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
                     python3-flake8 \
                     rsync  \
                     unzip

# Latest charm deb is in ppa:juju/stable, but our parent box (jujubox:devel)
# only includes ppa:juju/devel. Add the stable ppa and install charm.
sudo add-apt-repository -u -y ppa:juju/stable
sudo apt install --no-install-recommends charm

sudo pip install --upgrade pip six
sudo pip install amulet flake8 bundletester tox
sudo pip3 install --upgrade pip
sudo pip3 install amulet

# Install charm-tools from source
git clone https://github.com/juju/charm-tools /tmp/charm-tools
cd /tmp/charm-tools
sudo pip3 install .
cd ..
rm -rf charm-tools
git clone https://github.com/juju-solutions/matrix.git
cd matrix
sudo pip3 install . -f wheelhouse --no-index
cd ..
rm -rf matrix
