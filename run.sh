#!/bin/bash
set -e

export HOME=/home/ubuntu

cd $HOME
chown ubuntu:ubuntu $HOME/.local/share/juju
cp $HOME/.bashrc $HOME/.bash_profile
sudo -u ubuntu ssh-agent /bin/bash
