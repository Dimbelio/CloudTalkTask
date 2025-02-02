#!/bin/bash
set -e

# Start PostgreSQL in the background
/usr/lib/postgresql/11/bin/pg_ctl -D /var/lib/postgresql/data -o "-c listen_addresses='*'" -w start

# Create the user if it doesn't already exist
psql -v ON_ERROR_STOP=1 --username postgres --dbname postgres <<-EOSQL
    DO \$$
    BEGIN
        IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'homer_user') THEN
            CREATE USER homer_user WITH PASSWORD 'homer' SUPERUSER;
        END IF;
    END
    \$$;
EOSQL

# Create the Asterisk user and DB if it doesn't already exist
psql -v ON_ERROR_STOP=1 --username postgres --dbname postgres <<-EOSQL
    DO \$$
    BEGIN
        -- Create user if it does not exist
        IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'asterisk') THEN
            CREATE USER asterisk WITH PASSWORD 'root' SUPERUSER;
        END IF;
    END
    \$$;
EOSQL

# Create database separately (outside transaction block)
psql -v ON_ERROR_STOP=1 --username postgres --dbname postgres -tAc \
"SELECT 1 FROM pg_database WHERE datname = 'asterisk'" | grep -q 1 || \
psql -v ON_ERROR_STOP=1 --username postgres --dbname postgres -c "CREATE DATABASE asterisk;"

# Stop PostgreSQL gracefully
/usr/lib/postgresql/11/bin/pg_ctl -D /var/lib/postgresql/data -w stop

# Start PostgreSQL in the foreground (so the container stays running)
exec /usr/lib/postgresql/11/bin/postgres -D /var/lib/postgresql/data