#!/bin/bash
set -e
HOME=/home/ubuntu

# Add tims awesome PPA for the 2.0 bleeding edge tooling
sudo add-apt-repository -y ppa:tvansteenburgh/ppa
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
                        rsync \
                        unzip \
                        juju-deployer \
                        python-jujuclient \
                        make

sudo pip install tox --upgrade

echo "export LAYER_PATH=${HOME}/layers" >> /home/ubuntu/.bashrc
echo "export INTERFACE_PATH=${HOME}/interfaces" >> /home/ubuntu/.bashrc
# The builder defaults to pwd, this resets that behavior to output in  $HOME
echo "export JUJU_REPOSITORY=${HOME}" >> /home/ubuntu/.bashrc

chown -R ubuntu:ubuntu ${HOME}
