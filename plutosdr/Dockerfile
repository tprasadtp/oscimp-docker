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

FROM debian:9.9
RUN apt-get update && apt-get install -y --no-install-recommends passwd dumb-init samba smbclient
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
WORKDIR /srv/buildroot-pluto
COPY --from=buildrooter /home/ubuntu/buildroot-2019.02-pluto .
VOLUME ["/etc/samba", "/var/cache/samba", "/var/lib/samba", "/var/log/samba",\
"/run/samba"]

COPY smb.conf /etc/samba/smb.conf
EXPOSE 137/udp 138/udp 139 445
HEALTHCHECK --interval=60s --timeout=15s \
            CMD smbclient -L '\\localhost' -U '%' -m SMB3

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["smbd", "--foreground", "--log-stdout"]