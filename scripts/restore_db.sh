#!/usr/bin/env bash

set -e

if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <env> <dump_timestamp> (env: dev, local or prod)"
  exit 1
fi

ENV_NAME=$1
DUMP_TIMESTAMP=$2
ENV_DIR="envs/$ENV_NAME"

set -a
. "$ENV_DIR/.env"
. "$ENV_DIR/secrets.env"
set +a

BACKUP_DIR=$DATA_DIR/dumps
BACKUP_FILE_PATH=$BACKUP_DIR/$DUMP_TIMESTAMP.dump

if [ ! -f "$BACKUP_FILE_PATH" ]; then
  echo "Dump file not found: $BACKUP_FILE_PATH"
  exit 1
fi

if [ -n "${BASTION_HOST}" ]; then
    ssh -L localhost:$SSH_PROXY_PORT:sqldb:$DB_PORT -p $BASTION_PORT -o ServerAliveInterval=60 $BASTION_USERNAME@$BASTION_HOST -N &
    pid=$!
    sleep 3
else
    SSH_PROXY_PORT=$DB_PORT
fi

# disable triggers so that restoring "sessions" table do not trigger writes to "sessions_logs" table
$PGRESTORE_EXEC_PATH \
  -j 1 \
  --data-only \
  --disable-triggers \
  --dbname=postgresql://$DB_USERNAME:$PGPASSWORD@127.0.0.1:$SSH_PROXY_PORT/$DB_NAME \
  "$BACKUP_FILE_PATH"

if [ -n "${BASTION_HOST}" ]; then
    kill $pid
fi
