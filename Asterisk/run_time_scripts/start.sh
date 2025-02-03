#!/bin/bash


# Exit on any error
set -e

# Wait for PostgreSQL to be ready
until pg_isready -h postgresql_cloudt -U asterisk; do
    echo "Waiting for PostgreSQL to start..."
    sleep 1
done

# Log function to print messages with timestamp
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

# Start logging
log "Starting the start.sh script..."

# Change to the directory containing Alembic migrations
log "Changing directory to /home/asterisk/src/asterisk-20.10.0/contrib/ast-db-manage"
cd /home/asterisk/src/asterisk-20.10.0/contrib/ast-db-manage

# Run Alembic database migration
log "Running Alembic database migration..."
alembic -c ./config.ini upgrade head

log "Database migration completed successfully!"

### Provision specific test user

psql -h postgresql_cloudt -U asterisk -d asterisk -f /home/asterisk/src/provision_user.sql

# Start Asterisk in the foreground
exec asterisk -f -U asterisk