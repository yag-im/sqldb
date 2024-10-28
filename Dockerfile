FROM postgres:16.1-bookworm

COPY init/ /docker-entrypoint-initdb.d/
