# Use Debian 10 as the base image
ARG BASE_IMAGE=main-image:red

FROM ${BASE_IMAGE} 

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    binutils \
    cmake \
    g++ \
    gcc \
    git \
    libgsl-dev \
    libpcap-dev \
    libncurses-dev \
    make \
    ninja-build \
    libsctp-dev \
    libssl-dev \
    libpcre3-dev \
    libncurses5-dev 


RUN curl -LO https://github.com/SIPp/sipp/releases/download/v3.7.1/sipp-3.7.1.tar.gz && \
    tar -xzf sipp-3.7.1.tar.gz && \
    cd sipp-3.7.1 && \
    cmake . -DUSE_SSL=1 -DUSE_SCTP=1 -DUSE_PCAP=1 -DUSE_GSL=1 && \
    make && \
    make install

    # ./configure && \
    # make && \
    # make install && \
    # cd .. && \
    # rm -rf sipp-3.7.1*

WORKDIR /sipp
COPY run_scripts run_scripts
COPY tests tests

CMD ["/sbin/init"]
# CMD ["sipp", "-v"]