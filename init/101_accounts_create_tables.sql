\c yag;

CREATE TABLE accounts.users
(
    id        BIGSERIAL PRIMARY KEY NOT NULL,
    email     TEXT                  NULL,
    name      TEXT                  NULL,
    tz        TEXT                  NOT NULL DEFAULT 'UTC',
    apps_lib  JSONB                 NULL,  -- {"wishlist": [], "own": [], "completed": []}
    dob       DATE                  NOT NULL DEFAULT '1970-01-01',
    is_active BOOLEAN               NOT NULL DEFAULT TRUE
);

CREATE TABLE accounts.flask_dance_oauth
(
    id               BIGSERIAL PRIMARY KEY       NOT NULL,
    provider_user_id VARCHAR(256) UNIQUE,
    user_id          BIGINT REFERENCES accounts.users (id),
    provider         VARCHAR(50)                 NOT NULL,
    created_at       TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    token            JSON                        NOT NULL
);
