# sqldb

## Development

### Prerequisite

Create `secrets.env` file in the project directory (where .evn file resides):

    APPSVC_PASSWORD=***VALUE***
    AUTHSVC_PASSWORD=***VALUE***
    PORTSVC_PASSWORD=***VALUE***
    POSTGRES_PASSWORD=***VALUE***
    SESSIONSVC_PASSWORD=***VALUE***

Create scripts/env/{env}/secrets.env files:

    PGPASSWORD=***VALUE***

Make sure PGPASSWORD coincides with POSTGRES_PASSWORD from `secrets.env` in the project's folder.

Create DB structure and run the SQL server instance:

    make docker-build
    make docker-run

You'll need `psql` tool to be installed to proceed with init DB tables.

### Init DB tables

This procedure should be run periodically (after scraper's generated data (e.g. igdb) updates):

    cd scripts
    ./update_tables.sh {env}

At that point,  any existing records in `games.releases` table will become invaliated, so you need to refresh
`games.releases` table from the [ports](https://github.com/yag-im/ports) project:

    cd scripts
    ./upsert_releases.sh {env}

TODO: Never delete entries from the prod games.releases table — doing so will break all existing public external links!

TODO: Switch to ID-agnostic URLs. The challenge with this approach is that, for example, the slug typically refers to a
group of games, whereas yag.im focuses on individual releases (year/OS) identified by unique IDs.
Using UUIDs might be a viable path forward, but URLs will look ugly.
