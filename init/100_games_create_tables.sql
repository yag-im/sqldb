\c yag;

CREATE TABLE games.regions
(
    id   INT PRIMARY KEY NOT NULL,
    name TEXT UNIQUE     NOT NULL
);

CREATE TABLE games.companies
(
    id   INT PRIMARY KEY NOT NULL,
    name TEXT --UNIQUE NOT NULL
    -- should be unique, but igdb contains many duplicates they can't remove for now
    -- see discord: igdb - duplicates-and-non-games
);

CREATE TABLE games.genres
(
    id   INT PRIMARY KEY NOT NULL,
    name TEXT UNIQUE     NOT NULL
);

CREATE TABLE games.platforms
(
    id               INT PRIMARY KEY NOT NULL,
    name             TEXT UNIQUE     NOT NULL,
    abbreviation     TEXT UNIQUE,
    alternative_name TEXT UNIQUE,
    slug             TEXT UNIQUE
);

CREATE TABLE games.games
(
    id                BIGSERIAL PRIMARY KEY NOT NULL,
    name              TEXT                  NOT NULL,
    alternative_names TEXT[],
    short_descr       TEXT,
    long_descr        TEXT,
    genres            INT[]                 NOT NULL,
    companies         JSONB,                          -- array of companies involved (devs, pubs etc)
    platforms         INT[]                 NULL,
    media_assets      JSONB                 NOT NULL, -- covers and screenshots refs
    addl_artifacts    JSONB,                          -- downloadable content (arts, soundtracks etc)
    esrb_rating       INT,
    igdb              JSONB,
    refs              JSONB
);

CREATE TABLE games.releases
(
    id              BIGSERIAL PRIMARY KEY NOT NULL,
    game_id         BIGINT                NOT NULL,              -- REFERENCES games.games (id), removing FK to be able to update two tables independently
    uuid            TEXT UNIQUE           NOT NULL,
    name            TEXT                  NOT NULL,              -- localized name
    lang            TEXT                  NOT NULL,              -- en, ru, multi etc
    platform_id     INT                   NOT NULL,              -- REFERENCES games.platforms (id),
    distro          JSONB                 NOT NULL,              -- format (e.g. 2CD), url, files
    year_released   INT                   NOT NULL,
    companies       JSONB                 NOT NULL,              -- array of companies involved and their roles (devs, pubs etc)
    runner          JSONB                 NOT NULL,
    app_reqs        JSONB                 NOT NULL,              -- app requirements: resolution, color_bits, midi, memory, cpu, dgpu, igpu etc
    media_assets    JSONB,                                       -- localized covers and screenshots refs
    is_visible      BOOL                  NOT NULL DEFAULT true, -- useful when copyright owners requested to remove
    ts_added        TIMESTAMP             NOT NULL DEFAULT CURRENT_TIMESTAMP
);
