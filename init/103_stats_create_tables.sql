\c yag;

CREATE TABLE stats.webrtc_stats_logs
(
    id               BIGSERIAL PRIMARY KEY NOT NULL,
    session_id       TEXT NOT NULL, -- sessions.id
    user_id          BIGINT NOT NULL REFERENCES accounts.users (id),
    app_release_uuid TEXT NOT NULL, -- do not use FK here as it makes hard to refresh games.releases
    region           TEXT NOT NULL,
    created          TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    stats            JSONB
);
CREATE INDEX webrtc_stats_logs_idx ON stats.webrtc_stats_logs (created, user_id);

CREATE TABLE stats.users_dcs
(
    id               BIGSERIAL PRIMARY KEY NOT NULL,
    user_id          BIGINT NOT NULL UNIQUE REFERENCES accounts.users (id),
    dcs              JSONB NOT NULL, -- {"us-west-1": 1.23, "us-east-1": 2.23}
    created          TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated          TIMESTAMP NULL
);

CREATE OR REPLACE FUNCTION stats.update_users_dcs_timestamp()
    RETURNS TRIGGER AS
$$
BEGIN
    NEW.updated = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE OR REPLACE TRIGGER update_users_dcs_timestamp_trigger
    BEFORE UPDATE
    ON stats.users_dcs
    FOR EACH ROW
EXECUTE FUNCTION stats.update_users_dcs_timestamp();
