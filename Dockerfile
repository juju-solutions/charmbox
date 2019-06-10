FROM jujusolutions/jujubox:latest
LABEL maintainer="kevin.monroe@canonical.com"

ARG JUJU_USER=ubuntu

ENV CHARM_LAYERS_DIR=/home/$JUJU_USER/charms/layers
ENV CHARM_INTERFACES_DIR=/home/$JUJU_USER/charms/interfaces

RUN mkdir -p /home/$JUJU_USER/.cache
RUN chown -R $JUJU_USER:$JUJU_USER /home/$JUJU_USER/.cache

ADD charmbox-setup.sh /charmbox-setup.sh
RUN /charmbox-setup.sh
