FROM armv7/armhf-ubuntu
MAINTAINER Lorenz Bischof, lorenzbischof@gmail.com

RUN apt-get update && \
    apt-get upgrade -y

RUN adduser --disabled-login --gecos '' mutt
WORKDIR /home/mutt
USER mutt

VOLUME /home/mutt/mail

ENTRYPOINT /bin/echo "Mail data"
