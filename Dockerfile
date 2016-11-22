FROM jujusolutions/jujubox:latest
MAINTAINER Charles Butler <charles.butler@canonical.com>

ARG JUJU_USER=ubuntu

ENV LAYER_PATH=/home/$JUJU_USER/charms/layers
ENV INTERFACE_PATH=/home/$JUJU_USER/charms/interfaces

ADD charmbox-setup.sh /charmbox-setup.sh
RUN /charmbox-setup.sh
