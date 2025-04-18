FROM postgres:17-bookworm

RUN apt-get update && apt-get upgrade --no-install-recommends -y

COPY ./compose/db_postgres/pg_multi_db/create-multiple-postgresql-databases.sh /docker-entrypoint-initdb.d/
COPY ./compose/db_postgres/maintenance /usr/local/bin/maintenance

RUN chmod +x /usr/local/bin/maintenance/*

RUN mv /usr/local/bin/maintenance/* /usr/local/bin \
    && rmdir /usr/local/bin/maintenance