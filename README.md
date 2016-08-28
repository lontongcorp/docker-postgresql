PostgreSQL
----------

Mini version of PostgreSQL v9.5.4 Docker Images Ready-to-run – built on [Alpine Linux](https://alpinelinux.org/).

This is the postgresql ready-to-run version. If you want base version and create your own docker images (Dockerfile),
get [lontongcorp/postgresql-base](https://hub.docker.com/r/lontongcorp/postgresql-base/). Includes all `extension` contrib from original source code.

Removed most pgsql local command line and leave only template1 to shrink the size.


Run
---

    docker run -d --name postgresql --restart unless-stopped -it -p 5432:5432 lontongcorp/postgresql

Connect from host or remote:

    psql -U postgres -d template1 -h localhost -p 5432 -W

    psql~> CREATE DATABASE test;
    psql~> \c test
    psql~> CREATE EXTENSION hstore;
    psql~> CREATE EXTENSION dblink;

Credits
-------

Inspired by:

- https://hub.docker.com/r/anapsix/pgsql/ (small but exclude extensions)
- https://hub.docker.com/r/mhart/alpine-node/ (for idea building from source with alpine)
