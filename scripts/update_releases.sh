#!/usr/bin/env bash

for f_sql in ~/yag/src/sqldb/init/games_releases/*.sql
do
  psql -v ON_ERROR_STOP=1 --host localhost --port 2345 --username "$USERNAME" --dbname "$DBNAME" -f "$f_sql"
done;
