FROM jujusolutions/jujubox:devel

VOLUME ["/home/ubuntu/.local/share/juju", "/home/ubuntu/trusty", "/home/ubuntu/xenial", "/home/ubuntu/layers", "/home/ubuntu/interfaces", "/home/ubuntu/builds"]
RUN apt-get update -qy && apt-get install -qy gcc cython git make 
ADD install-review-tools.sh /install-review-tools.sh
RUN /install-review-tools.sh && apt-get remove -y --purge gcc cython make
CMD /run.sh
