#!/bin/bash

set -e

# init tables based on the igdb data
TABLES=("age_ratings_categories" "age_ratings_content_descr_categories" "age_ratings_ratings" "companies" "genres" "platforms")

for t in "${TABLES[@]}"
do
  psql -v ON_ERROR_STOP=1 --username "$PORTSVC_USER" --dbname "$YAG_DB" -c \
    "\copy games.$t FROM '/docker-entrypoint-initdb.d/igdb/$t.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',');"
done

psql -v ON_ERROR_STOP=1 --username "$PORTSVC_USER" --dbname "$YAG_DB" -c \
    "\copy games.games(name,alternative_names,short_descr,long_descr,genres,companies,platforms,media_assets,esrb_rating,igdb) FROM '/docker-entrypoint-initdb.d/igdb/games.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',');"
