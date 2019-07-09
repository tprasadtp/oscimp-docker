FROM ubuntu:bionic as buildrooter
ENV BOARD="redpitaya"
ARG COMMIT_SHA="c6b1d46a2429feb9c7ad4908b8ff642a50fcff84"
LABEL maintainer="Prasad Tengse <tengsep@tf.uni-freiburg.de>"
LABEL buildroot.commit=$COMMIT_SHA
LABEL buildroot.board=$BOARD

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
RUN git clone hhttps://github.com/trabucayre/redpitaya \
    && cd redpitaya \
    && git checkout ${COMMIT_SHA}
RUN wget https://buildroot.org/downloads/buildroot-2019.02.tar.gz \
    && tar zxvf buildroot-2019.02.tar.gz \
    && mv buildroot-2019.02 buildroot-2019.02-redpitaya

ENV BR2_EXTERNAL=/home/ubuntu/redpitaya

RUN cd buildroot-2019.02-redpitaya\
    && make make redpitaya_defconfig \
    && unset LD_LIBRARY_PATH \
    && make

RUN tar -cvzf buildroot-2019.02-redpitaya.tar.gz /home/ubuntu/buildroot-2019.02-redpitaya \
    && sha1sum buildroot-2019.02-redpitaya.tar.gz > buildroot-2019.02-redpitaya.tar.gz.SHA1SUM \
    && sha256sum buildroot-2019.02-redpitaya.tar.gz > buildroot-2019.02-redpitaya.tar.gz.SHA256SUM \
    && mkdir -p /home/ubuntu/build \
    && mv buildroot-2019.02-redpitaya.tar.gz /home/ubuntu/build/buildroot-2019.02-redpitaya.tar.gz \
    && mv buildroot-2019.02-redpitaya.tar.gz.* /home/ubuntu/build/
