#!/usr/bin/env bash

set -e

if [ -z "$1" ]; then
  echo "Usage: $0 <env> (dev, local or prod)"
  exit 1
fi

ENV_NAME=$1
ENV_DIR="envs/$ENV_NAME"

set -a
. "$ENV_DIR/.env"
. "$ENV_DIR/secrets.env"
set +a

BACKUP_PATH=$DATA_DIR/dump

if [ -n "${BASTION_HOST}" ]; then
    ssh -L localhost:$SSH_PROXY_PORT:sqldb:$DB_PORT -p $BASTION_PORT -o ServerAliveInterval=60 $BASTION_USERNAME@$BASTION_HOST -N &
    pid=$!
    sleep 3
else
    SSH_PROXY_PORT=$DB_PORT
fi

$PGDUMP_EXEC_PATH -j 1 --dbname=postgresql://$DB_USERNAME:$PGPASSWORD@127.0.0.1:$SSH_PROXY_PORT/$DB_NAME -Fd -f $BACKUP_PATH

if [ -n "${BASTION_HOST}" ]; then
    kill $pid
fi
