#!/bin/bash
set -e

sleep 5
# Wait for PostgreSQL to be ready
until pg_isready -h postgresql_cloudt -U homer_user; do
    echo "Waiting for PostgreSQL to start..."
    sleep 1
done

# Initialize Homer databases if they don't exist

if ! psql -h postgresql_cloudt -U homer_user -lqt | cut -d \| -f 1 | grep -qw homer_data && ! psql -h postgresql_cloudt -U homer_user -lqt | cut -d \| -f 1 | grep -qw homer_config; then
    homer-app -create-config-db -database-root-user=homer_user -database-host=postgresql_cloudt -database-root-password=homer -database-homer-user=homer_user
    homer-app -create-data-db -database-root-user=homer_user -database-host=postgresql_cloudt -database-root-password=homer -database-homer-user=homer_user
    homer-app -create-table-db-config 
    homer-app -populate-table-db-config 
    homer-app -upgrade-table-db-config 
    homer-app -update-ui-user=admin -update-ui-password=homer
fi


homer-app -show-db-users -database-root-user=homer_user -database-host=postgresql_cloudt -database-root-password=homer

# Start heplify-server and homer-app in the background
heplify-server -config /etc/heplify-server/heplify-server.toml &
HEPLIFY_PID=$!

homer-app &
HOMER_PID=$!

# Wait for both processes to finish
wait $HEPLIFY_PID $HOMER_PID