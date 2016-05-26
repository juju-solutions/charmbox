#!/bin/bash
set -e

export HOME=/home/ubuntu
cd $HOME
chown ubuntu:ubuntu $HOME/.juju
sudo -u ubuntu ssh-agent /bin/bash
