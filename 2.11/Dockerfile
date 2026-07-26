FROM debian:bookworm

RUN apt-get update -y && \
  apt-get upgrade -y && \
  apt-get install -y \
  curl \
  git \
  unzip \
  expect \
  vim \
  simh

WORKDIR /root

RUN git clone --depth=1 https://github.com/bsdimp/mk211bsd mk211bsd

WORKDIR /root/mk211bsd/195

RUN curl -lO https://www.tuhs.org/Archive/Distributions/UCB/2.11BSD-pl195.tar
RUN tar xvf 2.11BSD-pl195.tar
RUN gunzip *.gz
RUN perl mk211p195tape.pl
RUN expect 211bsd-195.expect

#COPY 2.11bsd-195.ini 2.11bsd-195.ini

CMD pdp11 ./211bsd-195-run.ini
