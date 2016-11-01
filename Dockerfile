FROM jujusolutions/jujubox:devel

ADD install-review-tools.sh /install-review-tools.sh
RUN /install-review-tools.sh
# Override jujubox run.sh
ADD run.sh /run.sh
CMD /run.sh

USER ubuntu
WORKDIR /home/ubuntu
