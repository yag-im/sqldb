#!/bin/bash

set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
  CREATE DATABASE $YAG_DB WITH OWNER = "$POSTGRES_USER" ENCODING = 'UTF8';
  REVOKE ALL ON DATABASE $YAG_DB FROM public;

  CREATE USER $YAGSVC_USER WITH NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT ENCRYPTED PASSWORD '$YAGSVC_PASSWORD';
  GRANT CONNECT ON DATABASE $YAG_DB TO $YAGSVC_USER;

  CREATE USER $MCCSVC_USER WITH NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT ENCRYPTED PASSWORD '$MCCSVC_PASSWORD';
  GRANT CONNECT ON DATABASE $YAG_DB TO $MCCSVC_USER;

  CREATE USER $PORTSVC_USER WITH NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT ENCRYPTED PASSWORD '$PORTSVC_PASSWORD';
  GRANT CONNECT ON DATABASE $YAG_DB TO $PORTSVC_USER;

  CREATE USER $SESSIONSVC_USER WITH NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT ENCRYPTED PASSWORD '$SESSIONSVC_PASSWORD';
  GRANT CONNECT ON DATABASE $YAG_DB TO $SESSIONSVC_USER;

  CREATE USER $APPSVC_USER WITH NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT ENCRYPTED PASSWORD '$APPSVC_PASSWORD';
  GRANT CONNECT ON DATABASE $YAG_DB TO $APPSVC_USER;
EOSQL

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$YAG_DB" <<-EOSQL
  CREATE SCHEMA accounts;
  CREATE SCHEMA games;
  CREATE SCHEMA sessions;
  CREATE SCHEMA stats;
EOSQL
