# Use Debian 10 as the base image
ARG BASE_IMAGE=main-image:red

FROM ${BASE_IMAGE}

# Install Homer dependencies
RUN curl -s https://packagecloud.io/install/repositories/qxip/sipcapture/script.deb.sh?any=true | sudo bash && \
    apt-get update && \
    apt-get install -y heplify heplify-server homer-app postgresql-client && \
    apt-get clean

# Copy the Homer initialization script
COPY etc/webapp_config.json /usr/local/homer/etc/
COPY etc/heplify-server.toml /etc/heplify-server/

COPY init-homer.sh /usr/local/bin/init-homer.sh
RUN chmod +x /usr/local/bin/init-homer.sh

# Expose Homer port
EXPOSE 9060
EXPOSE 9080

# Set the entrypoint script as the default command
ENTRYPOINT ["init-homer.sh"]