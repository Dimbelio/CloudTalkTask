# Use Debian 10 as the base image
ARG BASE_IMAGE=main-image:red

FROM ${BASE_IMAGE} 


### From ASTERISK BOOK:
RUN set -o nounset -o errexit -o xtrace -o verbose \
        && apt-get install --no-install-recommends --no-install-suggests \
        unixodbc \
        unixodbc-dev \
        python3-mysqldb \
        libjansson-dev \
        dnsutils \
        ufw \
        libxml2-dev \
        uuid-dev \
        libasound2-dev \
        libncurses-dev \
        libogg-dev \
        libtool \
        pkg-config \
        autoconf \
        automake \
        mysql-community-client-plugins \
        libmysqlclient-dev \
        odbc-postgresql


# Download the MySQL ODBC Connector package
RUN curl -LO "https://dev.mysql.com/get/Downloads/Connector-ODBC/mysql-connector-odbc_8.0.33-1debian10_amd64.deb" \
    && dpkg -i mysql-connector-odbc_8.0.33-1debian10_amd64.deb


RUN pip install mysqlclient alembic
ENV USER_NAME=asterisk

# Create a new user with a password and add to sudo group
RUN useradd -m -s /bin/bash ${USER_NAME} && \
    echo "${USER_NAME}:root" | chpasswd && \
    usermod -aG sudo ${USER_NAME}

USER asterisk

# Create the src directory and navigate into it
RUN mkdir -p ~/src

# Set the working directory to ~/src
WORKDIR /home/asterisk/src/

# Download the latest Asterisk 20 tarball
RUN curl -O https://downloads.asterisk.org/pub/telephony/asterisk/old-releases/asterisk-20.10.0.tar.gz

RUN tar zxvf asterisk-20.10.0.tar.gz

WORKDIR asterisk-20.10.0
RUN sudo ./contrib/scripts/install_prereq install


COPY menuselect/* /home/asterisk/src/asterisk-20.10.0
RUN sudo make clean
RUN sudo ./configure --with-jansson-bundled
RUN sudo make
RUN sudo make install \
    && sudo make config 

RUN sudo chown -R asterisk:asterisk /etc/asterisk && \
    sudo chown -R asterisk:asterisk /var/lib/asterisk && \
    sudo chown -R asterisk:asterisk /var/spool/asterisk && \
    sudo chown -R asterisk:asterisk /var/log/asterisk && \
    sudo chown -R asterisk:asterisk /var/run/asterisk && \
    sudo chmod -R 766 /etc/asterisk

USER root

### Move these upper on next build:
    RUN set -o nounset -o errexit -o xtrace -o verbose \
    && apt-get install postgresql-client
RUN pip install psycopg2-binary

COPY etc/asterisk/* /etc/asterisk/
COPY etc/tmpfiles.d/* /etc/tmpfiles.d/
COPY asterisk-20.10.0/contrib/ast-db-manage/config.ini /home/asterisk/src/asterisk-20.10.0/contrib/ast-db-manage/
COPY run_time_scripts/start.sh /home/asterisk/src/
COPY run_time_scripts/provision_user.sql /home/asterisk/src/
# # Configure ODBC
COPY etc/odbc.ini /etc/
RUN chmod +x /home/asterisk/src/start.sh

EXPOSE 5060
# Command to keep the container running
# CMD ["/sbin/init"]
CMD ["/home/asterisk/src/start.sh"]


