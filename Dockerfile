#
# thelonious/ubuntu
#

ARG BASE_VERSION=18.04

FROM ubuntu:${BASE_VERSION}

# setup ubuntu user
RUN groupadd -r -g 1000 ubuntu
RUN useradd -r -u 1000 -g ubuntu ubuntu
RUN usermod -s /bin/bash ubuntu
RUN usermod -a -G www-data ubuntu
RUN mkdir -p /home/ubuntu
RUN chown -R ubuntu:ubuntu /home/ubuntu

# upgrade system
RUN apt-get update && apt-get -y upgrade

# install packages
RUN apt-get install -y --no-install-recommends \
	locales \
	tzdata \
	ca-certificates \
	apt-transport-https \
	wget \
	curl \
	unzip \
	lsb-release \
	vim \
	jq

# set locale
RUN locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8

# set terminal
ENV TERM xterm-256color

# setup build environment info
ENV REPO_NAME ubuntu-base
ENV REPO_TAG 0.0.1

# set timezone
RUN rm /etc/localtime && \
	ln -s /usr/share/zoneinfo/America/Los_Angeles /etc/localtime && \
	dpkg-reconfigure --frontend noninteractive tzdata

# switch to default user and their home directory
USER ubuntu
WORKDIR "/home/ubuntu"

# run bash by default
CMD "/bin/bash"
