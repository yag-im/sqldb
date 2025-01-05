#!/bin/bash

set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$YAG_DB" <<-EOSQL
  -- authsvc user
  GRANT USAGE                          ON SCHEMA accounts TO $AUTHSVC_USER;
  GRANT USAGE                          ON ALL SEQUENCES IN SCHEMA accounts TO $AUTHSVC_USER;
  GRANT SELECT                         ON ALL TABLES IN SCHEMA accounts TO $AUTHSVC_USER;
  GRANT INSERT, UPDATE                 ON TABLE accounts.users TO $AUTHSVC_USER;
  GRANT INSERT, UPDATE                 ON TABLE accounts.flask_dance_oauth TO $AUTHSVC_USER;

  -- mccsvc user
  GRANT USAGE                          ON SCHEMA accounts TO $MCCSVC_USER;
  GRANT USAGE                          ON ALL SEQUENCES IN SCHEMA accounts TO $MCCSVC_USER;
  GRANT ALL                            ON ALL TABLES IN SCHEMA accounts TO $MCCSVC_USER;

  GRANT USAGE                          ON SCHEMA sessions TO $MCCSVC_USER;
  GRANT USAGE                          ON ALL SEQUENCES IN SCHEMA sessions TO $MCCSVC_USER;
  GRANT ALL                            ON ALL TABLES IN SCHEMA sessions TO $MCCSVC_USER;

  -- sessionsvc user
  GRANT USAGE                          ON SCHEMA sessions TO $SESSIONSVC_USER;
  GRANT USAGE                          ON ALL SEQUENCES IN SCHEMA sessions TO $SESSIONSVC_USER;
  GRANT ALL                            ON ALL TABLES IN SCHEMA sessions TO $SESSIONSVC_USER;

  GRANT USAGE                          ON SCHEMA stats TO $SESSIONSVC_USER;
  GRANT USAGE                          ON SEQUENCE stats.webrtc_stats_logs_id_seq TO $SESSIONSVC_USER;
  GRANT INSERT, SELECT                 ON TABLE stats.webrtc_stats_logs TO $SESSIONSVC_USER;
  GRANT USAGE                          ON SEQUENCE stats.users_dcs_id_seq TO $SESSIONSVC_USER;
  GRANT INSERT, UPDATE, SELECT         ON TABLE stats.users_dcs TO $SESSIONSVC_USER;

  -- appsvc user
  GRANT USAGE                          ON SCHEMA games TO $APPSVC_USER;
  GRANT USAGE                          ON ALL SEQUENCES IN SCHEMA games TO $APPSVC_USER;
  GRANT SELECT                         ON ALL TABLES IN SCHEMA games TO $APPSVC_USER;
  GRANT USAGE                          ON SCHEMA stats TO $APPSVC_USER;
  GRANT SELECT                         ON TABLE stats.users_dcs TO $APPSVC_USER;

  -- portsvc user
  GRANT USAGE                          ON SCHEMA games TO $PORTSVC_USER;
  GRANT USAGE                          ON ALL SEQUENCES IN SCHEMA games TO $PORTSVC_USER;
  GRANT ALL                            ON ALL TABLES IN SCHEMA games TO $PORTSVC_USER;
EOSQL
