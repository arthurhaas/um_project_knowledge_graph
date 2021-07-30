/*
todos:
workflow knowledge grpah conversion due to 1:n, n:m relations:
[x] countries
[] release_group
[] releases
[] realease countries & dates
[] artists
[] choose countries // or all? for final conversion (2019)
    criteria: Countries having gdp, happiness score, significant amount of songs
    usa, germany, netherlands, finnland/norway, brazil, russia...

what I need:
[x] country
[x] tracks released in 2019 (release, work, track)
    release-group
        1:n release
            1:n country & date
        n:m artist_credit
            n:m artist
[] for genre: need -> mbdump-derived.tar.bz2 (contains user tags, which include genre)

*/


-- Musicbrainz Queries for basic mappings
-- release_type
select * from release_group_primary_type;

-- release_status
select * from release_status;

-- release_language
select
	l.iso_code_3,
	l.name
from "language" l 
where l.id in (
	select "language" 
	from "release" r
	where id in (select release from release_country where date_year = 2019)
	group by "language"
);

-- artist type
select * from artist_type;

-- gender
select * from gender;


-- Musicbrainz Query 1
-- Countries
-- remarks:
---- Tables iso are not usable, because a 3 letter country code does not exist.
---- Which is needed due to the GDP dataset.
select
	a.id as country_id,
	a.name as country_name,
	i1.code as country_code
from musicbrainz.area a
left join iso_3166_1 i1 on i1.area = a.id
where
	-- Query for countries
	a.type = (select id from musicbrainz.area_type where name = 'Country')
	-- Countries that still existed in the year 2019
	and (a.end_date_year is null or a.end_date_year >= 2019)
	-- Countries with country_code. Two don't have: Kingdom of the Netherlands, Somaliland
	and i1.code is not null;


-- Musicbrainz Query 2
-- release_group
select
	rg.gid as gid,
	rg.name as name,
	rgpt."name" as type
from release_group rg
left join release_group_primary_type rgpt on rgpt.id = rg."type"
where
	-- only release_groups with releases in year 2019
	rg.id in (
		select r.release_group
		from "release" r
		where id in (select "release" from release_country rc where rc.date_year = 2019 group by "release")
	);


-- Musicbrainz Query 3
-- releases
select
	rg.gid as release_group_gid,
	r.gid as gid,
	r.name as name,
	rs.name as status,
	lang.iso_code_3 as language_iso_3,
	rc.countries as countries,
	rc.first_date as first_date,
	rc.last_date as last_date
from "release" r
left join release_group rg on rg.id = r.release_group
left join "language" lang on lang.id = r."language"
left join release_status rs on rs.id = r.status 
inner join (
	select
		"release",
		array_agg(i1.code) as countries,
		concat(coalesce(min(rc.date_year),1), '-', coalesce(min(rc.date_month),1), '-', coalesce(min(rc.date_day), 1)) as first_date,
		concat(coalesce(max(rc.date_year),1), '-', coalesce(max(rc.date_month),1), '-', coalesce(max(rc.date_day), 1)) as last_date
	from release_country rc
	left join iso_3166_1 i1 on i1.area = rc.country
	where date_year = 2019
	group by "release"
) rc on rc."release" = r.id

-- adding countries to releases, because RML functions didn't work out
select
	r.gid as gid,
	rc.country_code
from "release" r
inner join (
	select
		"release",
		i1.code as country_code
	from release_country rc
	left join iso_3166_1 i1 on i1.area = rc.country
	where date_year = 2019
	group by "release", country_code
) rc on rc."release" = r.id


-- Musicbrainz Query 4
-- artists
select
	rg.gid as release_group_gid,
	a.gid as gid,
	a.name as name,
	at2.name as type,
	g2.name as gender,
	a.comment as comment
from release_group rg
left join artist_credit_name acn on acn.artist_credit = rg.artist_credit
left join artist a on a.id = acn.artist 
left join artist_type at2 on at2.id = a."type"
left join gender g2 on g2.id = a.gender 
where
	-- only release_groups with releases in year 2019
	rg.id in (
		select r.release_group
		from "release" r
		where id in (select "release" from release_country rc where rc.date_year = 2019 group by "release")
	);











-- Helping queries for decision making

-- countries
select type, country, name, count(*) from (
select
	--r.gid as gid,
	rc.*
from "release" r
inner join (
	select
		rc.country,
		"release",
		i1.code as country_code,
		a2."type",
		a2."name" 
	from release_country rc
	left join iso_3166_1 i1 on i1.area = rc.country
	left join area a2 on a2.id = rc.country 
	where date_year = 2019
	group by 1,2,3,4,5
) rc on rc."release" = r.id
) sub
group by 1,2,3
order by 4 desc

-- Number releases by country
select
	id,
	name as country,
	releases.num_releases
from musicbrainz.area a
left join (
	select country, count(*) as num_releases
	from release_country rc
	where rc.date_year = 2019
	group by 1) as releases
on releases.country = a.id
where
	-- Query for countries
	a."type" = (select id from musicbrainz.area_type where name = 'Country')
	-- Countries that still existed in the year 2019
	and (a.end_date_year is null or a.end_date_year < 2019)
order by releases.num_releases desc


-- most releases by release_group
select
	r.release_group,
	count(distinct r.id)
from "release" r 
left join release_country rc on rc."release" = r.id 
where rc.date_year = 2019
group by 1
order by count desc;

-- details by release_group
select rg, r, rc
from release_group rg
left join "release" r on r.release_group = rg.id 
left join release_country rc on rc."release" = r.id 
where rg.id = 2180366
order by r.id asc;