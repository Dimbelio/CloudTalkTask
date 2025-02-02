ARG BASE_IMAGE=debian:buster-20230227-slim

FROM ${BASE_IMAGE} 
COPY apt/ /etc/apt/

RUN set -o nounset -o errexit -o xtrace -o verbose \
    && apt-get update \
    && apt-get install ca-certificates \
    && apt-get upgrade  \
    && apt-get install --no-install-recommends --no-install-suggests \
        software-properties-common \
        systemd-sysv \
        bsdmainutils \
        busybox-syslogd \
        curl \
        dnsutils \
        expect \
        haproxy \
        inotify-tools \
        iproute2 \
        iputils-ping \
        jq \
        mtr-tiny \
        netcat \
        openssl \
        procps \
        socat \
        telnet \
        traceroute \
        libssl-dev \
        zlib1g-dev \
        libbz2-dev \
        libreadline-dev \
        libsqlite3-dev \
        llvm \
        libncurses5-dev \
        libncursesw5-dev \
        xz-utils \
        tk-dev \
        libffi-dev \
        liblzma-dev \
        python3-openssl \
        git \
        wget \
        build-essential \
        ntp \
        ntpdate \
        tcpdump \
        vim \
        lsb-release \
        sudo \
        gnupg \
    && apt-get clean

####### INSTAL PYTHON3.11:
# Download Python 3.11 source code
RUN curl -O https://www.python.org/ftp/python/3.11.0/Python-3.11.0.tgz \
    && tar -xvf Python-3.11.0.tgz \
    && cd Python-3.11.0 \
    && ./configure --enable-optimizations \
    && make -j 4 > /tmp/make.log 2>&1 \
    && cat /tmp/make.log \
    && make altinstall


# Install pip for Python 3.11
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && python3.11 get-pip.py \
    && rm get-pip.py
######################################

RUN python3.11 -m pip install --upgrade pip

# Import MySQL APT repository GPG key
# Import MySQL APT repository GPG key for Debian

RUN curl -fsSL https://repo.mysql.com/RPM-GPG-KEY-mysql-2023 | gpg --dearmor -o /usr/share/keyrings/mysql-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/mysql-archive-keyring.gpg] http://repo.mysql.com/apt/debian/ $(lsb_release -c | awk '{print $2}') mysql-apt-config" > /etc/apt/sources.list.d/mysql.list \
    && echo "deb [signed-by=/usr/share/keyrings/mysql-archive-keyring.gpg] http://repo.mysql.com/apt/debian/ $(lsb_release -c | awk '{print $2}') mysql-8.0" >> /etc/apt/sources.list.d/mysql.list \
    && apt-get update

# Set environment variables for passwords (you can customize these)
ENV ROOT_PASSWORD=root
ENV SUDO_PASSWORD=root

# Set the root password
RUN echo "root:${ROOT_PASSWORD}" | chpasswd


# Allow the 'sudo' group to use sudo without a password prompt (optional)
RUN echo "%sudo ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/90-cloud-init-users

CMD ["/sbin/init"]

