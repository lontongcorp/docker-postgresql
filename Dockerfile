FROM lontongcorp/postgresql-base

ENV LANG en_US.utf8
ENV PGDATA /var/lib/postgresql
ENV PGPASS 'mySecretP4ssword'

RUN su - postgres -c "/usr/bin/initdb -D ${PGDATA}" >> /dev/null $2>1 && \
    su - postgres -c "/usr/bin/pg_ctl -D ${PGDATA} start" >> /dev/null $2>1 && \
    sleep 2s && \
    psql -U postgres -d template1 -c "UPDATE pg_database SET datistemplate='false' WHERE datname IN ('template0', 'postgres');" >> /dev/null $2>1 && \
    psql -U postgres -d template1 -c "DROP DATABASE template0;" >> /dev/null $2>1 && \
    psql -U postgres -d template1 -c "DROP DATABASE postgres;" >> /dev/null $2>1 && \
    psql -U postgres -d template1 -c "ALTER ROLE postgres WITH PASSWORD '${PGPASS}'" >> /dev/null $2>1 && \
    su - postgres -c "/usr/bin/pg_ctl -D ${PGDATA} stop" >> /dev/null $2>1 && \
    echo "local  all  all            md5" > ${PGDATA}/pg_hba.conf && \
    echo "host   all  all  0.0.0.0/0 md5" >> ${PGDATA}/pg_hba.conf && \
    echo "listen_addresses='*'" >> ${PGDATA}/postgresql.conf && \
    cd /usr/bin && \
    rm -rf pg* clusterdb createdb createlang createuser dropdb \
           droplang dropuser ecpg initdb reindexdb vacuumdb


EXPOSE 5432

USER postgres

CMD ["/usr/bin/postgres"]
