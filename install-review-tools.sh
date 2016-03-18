#!/bin/bash
set -e
HOME=/home/ubuntu

sudo apt-get update -qqy
sudo apt-get install -qy unzip \
                         build-essential\
                         charm-tools \
                         python-dev \
                         python-pip \
                         python-virtualenv \
                         python-tox \
                         rsync 
sudo pip install bundletester flake8 pyyaml --upgrade

chown -R ubuntu:ubuntu ${HOME}
