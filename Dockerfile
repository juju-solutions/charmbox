FROM jujusolutions/jujubox:latest

VOLUME ["/home/ubuntu/.juju", "/home/ubuntu/trusty", "/home/ubuntu/precise"]
RUN apt-get update -qy
RUN apt-get install -qy gcc cython git make
ADD install-review-tools.sh /install-review-tools.sh
RUN /install-review-tools.sh
CMD /run.sh
