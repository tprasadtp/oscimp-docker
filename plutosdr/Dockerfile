FROM ubuntu:bionic as buildrooter
ENV BOARD="plutosdr"
ARG COMMIT_SHA="ea8e615bf95a5c1ba9c86639103c6ae7e904dc26"
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
    ca-certificates

# change to normal user for avoiding ownership issues
RUN useradd -rm -d /home/ubuntu -s /bin/bash -u 1000 ubuntu
USER ubuntu
WORKDIR /home/ubuntu

# Prep Buildroot
RUN git clone https://github.com/oscimp/PlutoSDR \
    && cd PlutoSDR \
    && git checkout ${COMMIT_SHA}
RUN wget https://buildroot.org/downloads/buildroot-2019.02.tar.gz \
    && tar zxvf buildroot-2019.02.tar.gz \
    && mv buildroot-2019.02 buildroot-2019.02-plutosdr

ENV BR2_EXTERNAL=/home/ubuntu/PlutoSDR

RUN cd buildroot-2019.02-plutosdr \
    && make zynq_plutosdr_defconfig \
    && unset LD_LIBRARY_PATH \
    && make

RUN tar -cvzf buildroot-2019.02-plutosdr.tar.gz /home/ubuntu/buildroot-2019.02-plutosdr \
    && sha1sum buildroot-2019.02-plutosdr.tar.gz > buildroot-2019.02-plutosdr.tar.gz.SHA1SUM \
    && sha256sum buildroot-2019.02-plutosdr.tar.gz > buildroot-2019.02-plutosdr.tar.gz.SHA256SUM \
    && mkdir -p /home/ubuntu/build \
    && mv buildroot-2019.02-plutosdr.tar.gz /home/ubuntu/build/buildroot-2019.02-plutosdr.tar.gz \
    && mv buildroot-2019.02-plutosdr.tar.gz /home/ubuntu/build/buildroot-2019.02-plutosdr.tar.gz \
    && mv buildroot-2019.02-plutosdr.tar.gz.* /home/ubuntu/build/