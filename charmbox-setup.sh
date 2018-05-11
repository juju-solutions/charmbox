#!/bin/bash
set -ex

# Bundletester and friends in tims ppa
sudo add-apt-repository -yu ppa:tvansteenburgh/ppa

sudo DEBIAN_FRONTEND=noninteractive apt-get install -qy  \
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
                     rsync \
                     unzip

sudo pip install --upgrade pip six
sudo pip install amulet flake8 bundletester tox
sudo pip3 install --upgrade pip
sudo pip3 install amulet

# Install charm
#sudo systemctl start snapd
sudo /usr/lib/snapd/snapd &
sleep 5
#sudo snap install charm
#sudo mv /usr/local/bin/systemctl /usr/local/bin/systemctl.shim
# Above will fail because /dev/fuse dosent exist, so this doesnt work:
#sudo squashfuse /var/lib/snapd/snaps/core_4571.snap /snap/core/4571
