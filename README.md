Copy tables init data (csv):
    
    cd /ara/devel/acme/yag/sqldb/init/igdb
    cp -r /ara/devel/acme/yag/scrapers/data/igdb/*.csv .

Refresh dev db:
    
    cd scripts
    ./update_games.sh        

Clear pgdata folder and rebuild docker image:

    make docker-build

Run docker container locally:

    make docker-run

Publish changes:

    make docker-pub TAG=0.0.7
