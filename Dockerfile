FROM jujusolutions/jujubox:latest

VOLUME ["/home/ubuntu/.juju", "/home/ubuntu/trusty", "/home/ubuntu/precise"]
ADD install-review-tools.sh /install-review-tools.sh
RUN /install-review-tools.sh
CMD /run.sh
