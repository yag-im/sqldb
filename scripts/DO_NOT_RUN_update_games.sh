#!/usr/bin/env bash

USERNAME=postgres
DBNAME=yag

echo -n Enter postgres password:
read -s PGPASSWORD
echo
export PGPASSWORD

ssh -L localhost:2345:sqldb:5432 -p 2207 -o ServerAliveInterval=60 infra@bastion.dev.yag.im -N &
pid=$!
sleep 3

psql -v ON_ERROR_STOP=1 --host localhost --port 2345 --username "$USERNAME" --dbname "$DBNAME" <<-EOSQL
    BEGIN;
    DELETE FROM games.releases;
    DELETE FROM games.games;
    DELETE FROM games.companies;
    \copy games.companies FROM '/ara/devel/acme/yag/sqldb/init/igdb/companies.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',');
    \copy games.games(name,alternative_names,short_descr,long_descr,genres,companies,platforms,media_assets,age_ratings,igdb) FROM '/ara/devel/acme/yag/sqldb/init/igdb/games.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',');
    COMMIT;
EOSQL

for f_sql in /ara/devel/acme/yag/sqldb/init/games_releases/*.sql
do
  psql -v ON_ERROR_STOP=1 --host localhost --port 2345 --username "$USERNAME" --dbname "$DBNAME" -f "$f_sql"
done;

kill $pid
