# Use Debian 10 as the base image
ARG BASE_IMAGE=main-image:red

FROM ${BASE_IMAGE}

# Switch to the postgres user
# Install PostgreSQL
RUN sudo apt-get install -y postgresql postgresql-contrib && \
    sudo apt-get clean


# Configure PostgreSQL settings
# Configure PostgreSQL
RUN mkdir -p /var/lib/postgresql/data && \
    chown -R postgres:postgres /var/lib/postgresql && \
    chmod 700 /var/lib/postgresql/data



USER postgres
ENV PATH="/usr/lib/postgresql/11/bin:${PATH}"

RUN /usr/lib/postgresql/11/bin/initdb -D /var/lib/postgresql/data
COPY --chown=postgres:postgres conf_files/postgresql.conf /var/lib/postgresql/data/
COPY --chown=postgres:postgres conf_files/pg_hba.conf /var/lib/postgresql/data/

# Create an entrypoint script to set up the user and start PostgreSQL
COPY --chown=postgres:postgres  entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose PostgreSQL port
EXPOSE 5432

# Set the entrypoint script as the default command
ENTRYPOINT ["entrypoint.sh"]