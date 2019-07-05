FROM ubuntu:bionic as buildrooter
LABEL maintainer="Prasad Tengse <tengsep@tf.uni-freiburg.de>"

# Add Essentials
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wget \
    curl \
    tar \
    git \
    zip \
    make \
    binutils \
    build-essential \
    gcc \
    g++ \
    bash \
    patch \
    gzip \
    perl \
    bzip2 \
    tar \
    cpio \
    python \
    file \
    rsync \
    unzip \
    bc \
    libncurses-dev \
    ca-certificates \
    && apt-get clean

# change to normal user for avoiding ownership issues
RUN useradd -rm -d /home/ubuntu -s /bin/bash -u 1000 ubuntu
USER ubuntu
WORKDIR /home/ubuntu
# Prep Buildroot
RUN git clone https://github.com/oscimp/PlutoSDR
RUN wget https://buildroot.org/downloads/buildroot-2019.02.tar.gz \
    && tar zxvf buildroot-2019.02.tar.gz \
    && mv buildroot-2019.02 buildroot-2019.02-pluto

ENV BR2_EXTERNAL=/home/ubuntu/PlutoSDR

RUN cd buildroot-2019.02-pluto \
    && make zynq_pluto_defconfig \
    && unset LD_LIBRARY_PATH \
    && make

USER root
RUN chown -R 1000:1000 {PlutoSDR, buildroot-2019.02-pluto} \
    && rm buildroot-2019.02.tar.gz
USER ubuntu