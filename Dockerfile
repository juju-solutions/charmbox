FROM ubuntu:16.04

# Shout out to https://github.com/ogra1/snapd-docker
ENV container docker
ENV PATH "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
RUN apt-get update &&\
 DEBIAN_FRONTEND=noninteractive\
 apt-get install -y fuse snapd snap-confine software-properties-common squashfuse sudo &&\
 apt-get clean &&\
 dpkg-divert --local --rename --add /sbin/udevadm &&\
 ln -s /bin/true /sbin/udevadm
VOLUME ["/sys/fs/cgroup"]
RUN systemctl enable snapd
STOPSIGNAL SIGRTMIN+3

# Normally come from jujubox, but we're FROMing ubuntu in this WIP
ARG JUJU_USER=ubuntu
ENV JUJU_DATA /home/$JUJU_USER/.local/share/juju
ENV JUJU_REPOSITORY /home/$JUJU_USER/charms
RUN useradd -m $JUJU_USER -s /bin/bash
RUN echo "${JUJU_USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/juju-users
RUN echo "$JUJU_USER:password" | chpasswd
RUN mkdir -p $JUJU_DATA
RUN mkdir -p $JUJU_REPOSITORY
RUN chown -R $JUJU_USER:$JUJU_USER /home/$JUJU_USER/.local
RUN chown -R $JUJU_USER:$JUJU_USER $JUJU_REPOSITORY

# charm specifics
ENV LAYER_PATH=/home/$JUJU_USER/charms/layers
ENV INTERFACE_PATH=/home/$JUJU_USER/charms/interfaces
# hack so we can snap install stuff (DOESNT WORK; needs /dev/fuse)
ADD systemctl /usr/local/bin/systemctl
ADD charmbox-setup.sh /charmbox-setup.sh
RUN /charmbox-setup.sh

CMD ["/sbin/init"]
