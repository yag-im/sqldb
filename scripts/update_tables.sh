#!/usr/bin/env bash

set -e

set -a
. .env
. secrets.env
set +a

SSH_PROXY_PORT=2345

if [ -n "${BASTION_HOST}" ]; then
    ssh -L localhost:$SSH_PROXY_PORT:sqldb:$DB_PORT -p $BASTION_PORT -o ServerAliveInterval=60 $BASTION_USERNAME@$BASTION_HOST -N &
    pid=$!
    sleep 3
else
    SSH_PROXY_PORT=$DB_PORT
fi

psql -v ON_ERROR_STOP=1 --host localhost --port $SSH_PROXY_PORT --username "$DB_USERNAME" --dbname "$DB_NAME" <<-EOSQL
    BEGIN;
    TRUNCATE games.releases, games.games RESTART IDENTITY;
    \copy games.games(name,alternative_names,short_descr,long_descr,genres,companies,platforms,media_assets,esrb_rating,igdb) \
        FROM '~/yag/data/scrapers/igdb/games.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',');
    COMMIT;
EOSQL

TABLES=("age_ratings_categories" "age_ratings_content_descr_categories" "age_ratings_ratings" "companies" "genres" "platforms")
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
