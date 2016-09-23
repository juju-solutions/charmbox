FROM jujusolutions/jujubox:devel

VOLUME "/home/ubuntu/.local/share/juju"
VOLUME "/home/ubuntu/trusty"
VOLUME "/home/ubuntu/builds"
VOLUME "/home/ubuntu/layers"
VOLUME "/home/ubuntu/interfaces"
ADD install-review-tools.sh /install-review-tools.sh
RUN /install-review-tools.sh
# Override jujubox run.sh
ADD run.sh /run.sh
CMD /run.sh
