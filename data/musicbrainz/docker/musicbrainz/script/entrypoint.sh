#!/usr/bin/bash

# Starting postgres server
pg_ctlcluster 12 main start

# Initialize musicbrainz database structure
su - postgres
createuser musicbrainz
createdb -l C -E UTF-8 -T template0 -O musicbrainz musicbrainz

psql musicbrainz -c 'CREATE EXTENSION cube;'
psql musicbrainz -c 'CREATE EXTENSION earthdistance;'

echo 'CREATE SCHEMA musicbrainz;' | mbslave psql -S
echo 'CREATE SCHEMA statistics;' | mbslave psql -S

mbslave psql -f CreateCollations.sql
mbslave psql -f CreateTables.sql
mbslave psql -f statistics/CreateTables.sql

# Make postgres accessable from outside the docker container
echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/12/main/pg_hba.conf
echo "listen_addresses='*'" >> /etc/postgresql/12/main/postgresql.conf
pg_ctlcluster 12 main restart


## in database
psql musicbrainz
GRANT USAGE ON SCHEMA musicbrainz, statistics TO musicbrainz;
GRANT SELECT ON ALL TABLES IN SCHEMA musicbrainz, statistics TO musicbrainz;
ALTER ROLE musicbrainz WITH PASSWORD 'it_works';

# Import MusicBrainz datasets
mbslave import /tmp/project/dump/mbdump-stats.tar.bz2
mbslave import /tmp/project/dump/mbdump.tar.bz2

# clean up
# psql musicbrainz
# select concat('DROP TABLE musicbrainz.', relname, ';') as query from pg_stat_user_tables where n_live_tup = 0 and schemaname = 'musicbrainz';