#!/bin/bash
set -ex

# Install the development tools on this image.

HOME=/home/ubuntu

# Add Tim's awesome PPA for the 2.0 bleeding edge tooling
sudo add-apt-repository -y ppa:tvansteenburgh/ppa
sudo apt-get update -qq --fix-missing -y

# Fix for CI choking on duplicate hosts if the host key has changed
# which is common.
mkdir -p $HOME/.ssh
echo 'Host *' > $HOME/.ssh/config
echo '  StrictHostKeyChecking no' >> $HOME/.ssh/config

# Chuck hates this
touch $HOME/.vimrc
echo "alias vim=vi" >> /home/ubuntu/.bashrc

sudo apt-get install -qy build-essential \
  charm \
  charm-tools \
  cython \
  git \
  make \
  python-dev \
  python-flake8 \
  python-jujuclient \
  python-pip \
  python-virtualenv \
  rsync \
  unzip

sudo -H pip install --upgrade pip
sudo -H pip install --upgrade bundletester pyyaml tox

chown -R ubuntu:ubuntu ${HOME}
