FROM armv7/armhf-ubuntu
MAINTAINER Lorenz Bischof, lorenzbischof@gmail.com

RUN apt-get update && \
    apt-get upgrade -y

# Set the locale (I want to use German Umlauts)
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV TERM=screen-256color

# Set the timezone (change this to your local timezone)
RUN echo "Europe/Zurich" | tee /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get update
RUN apt-get install -y \
    msmtp \
    mutt \
    vim

RUN adduser --disabled-login --gecos '' mutt
WORKDIR /home/mutt

COPY muttrc /home/mutt/.muttrc
COPY msmtprc /home/mutt/.msmtprc
COPY signature /home/mutt/

RUN mkdir /home/mutt/mail
RUN chown -R mutt:mutt /home/mutt/
RUN ls -al /home/mutt
USER mutt

ENTRYPOINT /usr/bin/mutt
