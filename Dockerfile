FROM jujusolutions/jujubox:latest

VOLUME "/home/ubuntu/.juju"
VOLUME "/home/ubuntu/trusty"
VOLUME "/home/ubuntu/builds"
VOLUME "/home/ubuntu/layers"
VOLUME "/home/ubuntu/interfaces"
RUN apt-get update -qy
RUN apt-get install -qy gcc cython git make
ADD install-review-tools.sh /install-review-tools.sh
RUN /install-review-tools.sh
CMD /run.sh
