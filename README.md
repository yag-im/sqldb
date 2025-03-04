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

Finally, init `releases` table from the [ports](https://github.com/yag-im/ports) project:

    cd scripts
    python upsert_releases.sh {env}
