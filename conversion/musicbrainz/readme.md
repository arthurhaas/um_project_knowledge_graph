# commands

```bash
time java -jar ../rmlmapper-4.9.2.jar -m mapping00.basics.rml.ttl -o output.mapping00.basics.ttl -s turtle

time java -jar ../rmlmapper-4.9.2.jar -m mapping01.country.rml.ttl -o output.mapping01.country.ttl -s turtle

time java -jar ../rmlmapper-4.9.2.jar -m mapping02.release_group.rml.ttl -o output.mapping02.release_group.ttl -s turtle

time java -jar ../rmlmapper-4.9.2.jar -m mapping03.releases.rml.ttl -o output.mapping03.releases.ttl -s turtle

time java -jar ../rmlmapper-4.9.2.jar -m mapping04.artists.rml.ttl -o output.mapping04.artists.ttl -s turtle
```


# output

(rdf) arthur@Arthurs-Machine musicbrainz % time java -jar ../rmlmapper-4.9.2.jar -m mapping00.basics.rml.ttl -o output.mapping00.basics.ttl -s turtle
java -jar ../rmlmapper-4.9.2.jar -m mapping00.basics.rml.ttl -o  -s turtle  2.16s user 0.29s system 24% cpu 9.883 total

(rdf) arthur@Arthurs-Machine musicbrainz % time java -jar ../rmlmapper-4.9.2.jar -m mapping01.country.rml.ttl -o output.mapping01.country.ttl -s turtle
java -jar ../rmlmapper-4.9.2.jar -m mapping01.country.rml.ttl -o  -s turtle  8.24s user 0.64s system 76% cpu 11.558 total

(rdf) arthur@Arthurs-Machine musicbrainz % time java -jar ../rmlmapper-4.9.2.jar -m mapping02.release_group.rml.ttl -o output.mapping02.release_group.ttl -s turtle
java -jar ../rmlmapper-4.9.2.jar -m mapping02.release_group.rml.ttl -o  -s   13.57s user 1.27s system 68% cpu 21.616 total

(rdf) arthur@Arthurs-Machine musicbrainz % time java -jar ../rmlmapper-4.9.2.jar -m mapping03.releases.rml.ttl -o output.mapping03.releases.ttl -s turtle
java -jar ../rmlmapper-4.9.2.jar -m mapping03.releases.rml.ttl -o  -s turtle  50.36s user 4.54s system 82% cpu 1:06.89 total

(rdf) arthur@Arthurs-Machine musicbrainz % time java -jar ../rmlmapper-4.9.2.jar -m mapping04.artists.rml.ttl -o output.mapping04.artists.ttl -s turtle
java -jar ../rmlmapper-4.9.2.jar -m mapping04.artists.rml.ttl -o  -s turtle  23.51s user 2.04s system 77% cpu 33.149 total