**Data represents**

MusicBrainz dataset

**source**

[https://musicbrainz.org/doc/MusicBrainz_Database/Download](https://musicbrainz.org/doc/MusicBrainz_Database/Download)

**download on linux (docker)**

MusicBrainz dataset is updated twice a week. Hence, please update below timestamp. See mirrors within above website.

```bash
# mbdump-stats.tar.bz2
wget https://mirrors.dotsrc.org/MusicBrainz/data/fullexport/20210320-001657/mbdump-stats.tar.bz2
sha256sum mbdump-stats.tar.bz2
```

**run docker**

```bash
cd docker_base
make build

cd ../docker_musicbrainz
make build

cd ..
docker run -it -v /Users/arthur/git/um_project_knowledge_graph/data/musicbrainz/dump/:/tmp/project/dump -p 5432:5432 um.bmkg/musicbrainz
```

afterwards execute the commands in docker/musicbrainz/script one by one