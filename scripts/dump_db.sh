#!/usr/bin/env bash

set -e

set -a
. .env
. secrets.env
set +a

BACKUP_PATH=$DATA_DIR/dump

SSH_PROXY_PORT=2345

if [ -n "${BASTION_HOST}" ]; then
    ssh -L localhost:$SSH_PROXY_PORT:sqldb:$DB_PORT -p $BASTION_PORT -o ServerAliveInterval=60 $BASTION_USERNAME@$BASTION_HOST -N &
    pid=$!
    sleep 3
else
    SSH_PROXY_PORT=$DB_PORT
fi

# TODO: fix pg_dump path
/usr/lib/postgresql/16/bin/pg_dump -j 1 --dbname=postgresql://$DB_USERNAME:$PGPASSWORD@127.0.0.1:$SSH_PROXY_PORT/$DB_NAME -Fd -f $BACKUP_PATH

if [ -n "${BASTION_HOST}" ]; then
    kill $pid
fi
