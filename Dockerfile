FROM jujusolutions/jujubox:devel

VOLUME ["/home/ubuntu/.local/share/juju", "/home/ubuntu/trusty", "/home/ubuntu/xenial", "/home/ubuntu/layers", "/home/ubuntu/interfaces", "/home/ubuntu/builds"]
ADD install-review-tools.sh /install-review-tools.sh
RUN /install-review-tools.sh
CMD /run.sh
