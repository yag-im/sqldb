# sqldb

## Development

### Prerequisite

Create `secrets.env` file in the project directory:

    APPSVC_PASSWORD=***VALUE***
    MCCSVC_PASSWORD=***VALUE***
    PORTSVC_PASSWORD=***VALUE***
    POSTGRES_PASSWORD=***VALUE***
    SESSIONSVC_PASSWORD=***VALUE***
    YAGSVC_PASSWORD=***VALUE***

Create scripts/.env file:

    DB_NAME=yag
    DB_USERNAME=postgres
    DB_PORT=5432

Create scripts/secrets.env file:

    PGPASSWORD=***VALUE***

Make sure PGPASSWORD coincides with POSTGRES_PASSWORD from `secrets.env` in the project's folder.

Create DB structure and run the SQL server instance:

    make docker-build
    make docker-run

Init DB tables (should be run periodically after live scraper's data updates):

    cd scripts
    ./update_tables.sh

Finally, init `releases` table from `ports` project (TODO: this is ugly):

    cd scripts
    python post_all_releases.py
