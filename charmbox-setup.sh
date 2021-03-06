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
                     wget  \
                     unzip

sudo pip install --upgrade pip six
sudo pip install amulet flake8 bundletester tox
sudo pip3 install --upgrade pip
sudo pip3 install amulet

# charmstore-client should be installed with snap, but docker can't do that.
# Live a little; let's GO!
mkdir -p /tmp/charm-go /tmp/charm-gopath
(
    cd /tmp/charm-go
    wget https://dl.google.com/go/go1.12.6.linux-amd64.tar.gz
    tar zxf go1.12.6.linux-amd64.tar.gz
)
export GOROOT=/tmp/charm-go/go
export GOPATH=/tmp/charm-gopath
export PATH=${GOPATH}/bin:${GOROOT}/bin:${PATH}

# NB: no go files in root, but we just need the source, so || true
go get github.com/juju/charmstore-client || true
(
    cd ${GOPATH}/src/github.com/juju/charmstore-client
    make deps install
    sudo mv ${GOPATH}/bin/charm* /usr/local/bin
)
# kthxbye
rm -rf /tmp/charm-go /tmp/charm-gopath

# Install charm-tools from source
git clone https://github.com/juju/charm-tools /tmp/charm-tools
cd /tmp/charm-tools
sudo pip3 install .
cd ..
rm -rf charm-tools
