FROM ubuntu
MAINTAINER Lorenz Bischof <lorenzbischof@gmail.com>

RUN apt-get update && \
    apt-get upgrade -y

RUN apt-get install -y \
        git \
        build-essential \
        automake \
        autoconf \
        libssl-dev \
        libexpat1-dev \
        libncursesw5-dev \
        libglib2.0-dev \
        libnotify-dev \
        libcurl3-dev \
        libxss-dev \
        libotr5-dev \
        libreadline-dev \
        libtool \
        libgpgme11-dev

RUN locale-gen en_US.UTF-8

ENV TERM=screen-256color
ENV LD_LIBRARY_PATH=/usr/local/lib
RUN git clone https://github.com/boothj5/libmesode /home/profanity/libmesode
WORKDIR /home/profanity/libmesode
RUN ./bootstrap.sh && ./configure && make && make install

RUN git clone https://github.com/boothj5/profanity /home/profanity/bin
WORKDIR /home/profanity/bin
#ENV LDFLAGS='-L/home/profanity/libs'
RUN ./bootstrap.sh && ./configure && make && make install

RUN adduser --disabled-password --gecos '' profanity
USER profanity

CMD ["/usr/local/bin/profanity"]
