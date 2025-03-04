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

if [ -n "${BASTION_HOST}" ]; then
    ssh -L localhost:$SSH_PROXY_PORT:sqldb:$DB_PORT -p $BASTION_PORT -o ServerAliveInterval=60 $BASTION_USERNAME@$BASTION_HOST -N &
    pid=$!
    sleep 3
else
    SSH_PROXY_PORT=$DB_PORT
fi

psql -v ON_ERROR_STOP=1 --host localhost --port $SSH_PROXY_PORT --username "$DB_USERNAME" --dbname "$DB_NAME" <<-EOSQL
    BEGIN;
    TRUNCATE games.games RESTART IDENTITY;
    \copy games.games(name,alternative_names,short_descr,long_descr,genres,companies,platforms,media_assets,esrb_rating,igdb) \
        FROM '~/yag/data/scrapers/igdb/games.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',');
    COMMIT;
EOSQL

TABLES=("companies" "genres" "platforms")
for t in "${TABLES[@]}"
do
psql -v ON_ERROR_STOP=1 --host localhost --port $SSH_PROXY_PORT --username "$DB_USERNAME" --dbname "$DB_NAME" <<-EOSQL
  BEGIN;
  TRUNCATE games.$t RESTART IDENTITY;
  \copy games.$t FROM '~/yag/data/scrapers/igdb/$t.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',');
  COMMIT;
EOSQL
done

for f_sql in patches/*.sql
do
  psql -v ON_ERROR_STOP=1 --host localhost --port $SSH_PROXY_PORT --username "$DB_USERNAME" --dbname "$DB_NAME" -f "$f_sql"
done;

if [ -n "${BASTION_HOST}" ]; then
    kill $pid
fi
