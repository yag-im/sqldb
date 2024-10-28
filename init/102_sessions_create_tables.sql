\c yag;

CREATE TYPE sessions.session_status AS ENUM ('pending', 'active', 'paused', 'closed');

CREATE TABLE sessions.sessions
(
    id               TEXT PRIMARY KEY        NOT NULL,
    app_release_uuid TEXT                    NOT NULL, -- do not use FK here as it makes hard to refresh games.releases
    container        JSONB                   NULL,     -- id, node_id, region; this field is populated after container has been created
    status           sessions.session_status NOT NULL,
    updated          TIMESTAMP               NOT NULL DEFAULT CURRENT_TIMESTAMP, -- updates in the update_sessions_timestamp trigger
    user_id          BIGINT                  UNIQUE NOT NULL REFERENCES accounts.users (id),
    ws_conn          JSONB                   NOT NULL -- id, consumer_id, producer_id
);

CREATE TABLE sessions.sessions_logs
(
    id               BIGSERIAL PRIMARY KEY   NOT NULL,
    app_release_uuid TEXT                    NOT NULL,
    container        JSONB                   NULL,
    created          TIMESTAMP               NOT NULL DEFAULT CURRENT_TIMESTAMP,
    session_id       TEXT                    NOT NULL, -- sessions.id
    status           sessions.session_status NOT NULL,
    user_id          BIGINT                  NOT NULL REFERENCES accounts.users (id),
    ws_conn          JSONB                   NOT NULL
);

CREATE OR REPLACE FUNCTION sessions.update_sessions_timestamp()
    RETURNS TRIGGER AS
$$
BEGIN
    NEW.updated = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE OR REPLACE TRIGGER update_sessions_timestamp_trigger
    BEFORE UPDATE
    ON sessions.sessions
    FOR EACH ROW
EXECUTE FUNCTION sessions.update_sessions_timestamp();

CREATE OR REPLACE FUNCTION sessions.update_sessions_logs()
    RETURNS TRIGGER AS
$$
BEGIN
    IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
        INSERT INTO sessions.sessions_logs (session_id, user_id, app_release_uuid, ws_conn, container, status)
        VALUES (NEW.id, NEW.user_id, NEW.app_release_uuid, NEW.ws_conn, NEW.container, NEW.status);
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO sessions.sessions_logs (session_id, user_id, app_release_uuid, ws_conn, container, status)
        VALUES (OLD.id, OLD.user_id, OLD.app_release_uuid, OLD.ws_conn, OLD.container, 'closed');
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER update_sessions_logs_trigger
    AFTER INSERT OR UPDATE OR DELETE
    ON sessions.sessions
    FOR EACH ROW
EXECUTE FUNCTION sessions.update_sessions_logs();
