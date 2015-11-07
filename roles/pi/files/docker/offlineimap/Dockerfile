FROM armv7/armhf-ubuntu
MAINTAINER Lorenz Bischof, lorenzbischof@gmail.com

RUN apt-get update && \
    apt-get upgrade -y

RUN apt-get install -y offlineimap

RUN adduser --disabled-login --gecos '' mutt
WORKDIR /home/mutt

COPY offlineimaprc /home/mutt/.offlineimaprc

RUN mkdir -p /home/mutt/mail
RUN chown -R mutt:mutt /home/mutt/
RUN ls -al /home/mutt
USER mutt

ENTRYPOINT /usr/bin/offlineimap
