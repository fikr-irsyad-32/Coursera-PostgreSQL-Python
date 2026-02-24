-- Assignments 2.1a

In this exercise you will add a column to your pg4e_debug table. The column can be any type you like - like INTEGER. neon489.
The auto grader will run the folowing command:

SELECT neon489 FROM pg4e_debug LIMIT 1;

-- Answer 2.1a

alter table pg4e_debug add column neon489 varchar;

-- Assignments 2.1b

In this assignment you are to find the distinct values in the state column of the taxdata table in ascending order. 
Your query should only return these five rows (i.e. inclide a LIMIT clause):

-- Answer 2.1b

select distinct 
	state
from taxdata
order by state 
limit 5;

-- Assignments 2.1c

In this assignment you will create a table, and add a stored procedure to it.

CREATE TABLE keyvalue ( 
  id SERIAL,
  key VARCHAR(128) UNIQUE,
  value VARCHAR(128) UNIQUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY(id)
);

Add a stored procedure so that every time a record is updated, the updated_at variable is automatically set to the current time. 

-- Answer 2.1c

create function trigger_set_timestamp()
returns trigger as 
$$
begin
	new.updated_at = now ();
	return new;
end;
$$
language plpgsql;

create trigger set_timestamp
before update on keyvalue
for each row
execute procedure trigger_set_timestamp();

-- Assignments 2.2a

This application will read an iTunes library in comma-separated-values (CSV) format and produce properly normalized tables

CREATE TABLE album (
  id SERIAL,
  title VARCHAR(128) UNIQUE,
  PRIMARY KEY(id)
);

CREATE TABLE track (
    id SERIAL,
    title VARCHAR(128),
    len INTEGER, 
    rating INTEGER, 
    count INTEGER,
    album_id INTEGER REFERENCES album(id) ON DELETE CASCADE,
    UNIQUE(title, album_id),
    PRIMARY KEY(id)
);

CREATE TABLE track_raw (
	title TEXT, 
	artist TEXT, 
	album TEXT, 
	album_id INTEGER,
	count INTEGER, 
	rating INTEGER, 
	len INTEGER
);

-- Answer 2.2a

wget https://www.pg4e.com/tools/sql/library.csv

\copy track_raw (title, artist, album, count, rating, len) from 'library.csv' with delimiter ',' csv;

insert into album (title) select distinct album from track_raw;

UPDATE track_raw SET album_id = (SELECT album.id FROM album WHERE album.title = track_raw.album);

insert into track (title, len, rating, count, album_id) 
	select title, len, rating, count, album_id from track_raw;

-- Assignments 2.2b

In this assignment you will read some Unesco Heritage Site data in comma-separated-values (CSV) format 
and produce properly normalized tables 

CREATE TABLE unesco_raw (
	name TEXT, 
	description TEXT, 
	justification TEXT, 
	year INTEGER,
    longitude FLOAT, 
    latitude FLOAT, 
    area_hectares FLOAT,
    category TEXT, 
    category_id INTEGER, 
    state TEXT, 
    state_id INTEGER,
    region TEXT, 
	region_id INTEGER, 
	iso TEXT, 
	iso_id INTEGER);

CREATE TABLE category (
  id SERIAL,
  name VARCHAR(128) UNIQUE,
  PRIMARY KEY(id)
);

... More tables needed

Normalize the data in the unesco_raw table by adding the entries to each of the lookup tables (category, etc.) 
and then adding the foreign key columns to the unesco_raw table. 
Then make a new table called unesco that removes all of the un-normalized redundant text columns like category.


-- Answer 2.2b

wget https://www.pg4e.com/tools/sql/whc-sites-2018-small.csv

\copy unesco_raw(name,description,justification,year,longitude,latitude,area_hectares,category,state,region,iso) 
	FROM 'whc-sites-2018-small.csv' WITH DELIMITER ',' CSV HEADER;

CREATE TABLE state (
  id SERIAL,
  name VARCHAR(128) UNIQUE,
  PRIMARY KEY(id)
);

CREATE TABLE region (
  id SERIAL,
  name VARCHAR(128) UNIQUE,
  PRIMARY KEY(id)
);

CREATE TABLE iso (
  id SERIAL,
  name VARCHAR(128) UNIQUE,
  PRIMARY KEY(id)
);

insert into category (name) select distinct category from unesco_raw;
insert into state (name) select distinct state from unesco_raw;
insert into region (name) select distinct region from unesco_raw;
insert into iso (name) select distinct iso from unesco_raw;

UPDATE unesco_raw SET category_id = (SELECT category.id FROM category WHERE category.name = unesco_raw.category);
UPDATE unesco_raw SET state_id = (SELECT state.id FROM state WHERE state.name = unesco_raw.state);
UPDATE unesco_raw SET region_id = (SELECT region.id FROM region WHERE region.name = unesco_raw.region);
UPDATE unesco_raw SET iso_id = (SELECT iso.id FROM iso WHERE iso.name = unesco_raw.iso);

CREATE TABLE unesco (
	id SERIAL,
	name TEXT, 
	description TEXT, 
	justification TEXT, 
	year INTEGER,
    longitude FLOAT, 
    latitude FLOAT, 
    area_hectares FLOAT,
    category TEXT, 
    category_id INTEGER REFERENCES category(id) ON DELETE CASCADE,
    state TEXT, 
    state_id INTEGER REFERENCES state(id) ON DELETE CASCADE,
    region TEXT, 
	region_id INTEGER REFERENCES region(id) ON DELETE CASCADE, 
	iso TEXT, 
	iso_id INTEGER REFERENCES iso(id) ON DELETE CASCADE,
    PRIMARY KEY(id)
);
    
insert into unesco (name,description,justification,year,longitude,latitude,area_hectares,
	category,category_id,state,state_id,region,region_id,iso,iso_id) 
	select name,description,justification,year,longitude,latitude,area_hectares,
	category,category_id,state,state_id,region,region_id,iso,iso_id from unesco_raw;

-- Assignments 2.2c

This application will read an iTunes library in comma-separated-values (CSV) and produce properly normalized tables 

We will do some things differently in this assignment. We will not use a separate "raw" table, 
we will just use ALTER TABLE statements to remove columns after we dont need them (i.e. we converted them into foreign keys).

This time we will build a many-to-many relationship using a junction/through/join table between tracks and artists.

In this assignment we will give you a partial script with portions of some of the commands replaced by three dots...

DROP TABLE album CASCADE;
CREATE TABLE album (
    id SERIAL,
    title VARCHAR(128) UNIQUE,
    PRIMARY KEY(id)
);

DROP TABLE track CASCADE;
CREATE TABLE track (
    id SERIAL,
    title TEXT, 
    artist TEXT, 
    album TEXT, 
    album_id INTEGER REFERENCES album(id) ON DELETE CASCADE,
    count INTEGER, 
    rating INTEGER, 
    len INTEGER,
    PRIMARY KEY(id)
);

DROP TABLE artist CASCADE;
CREATE TABLE artist (
    id SERIAL,
    name VARCHAR(128) UNIQUE,
    PRIMARY KEY(id)
);

DROP TABLE tracktoartist CASCADE;
CREATE TABLE tracktoartist (
    id SERIAL,
    track VARCHAR(128),
    track_id INTEGER REFERENCES track(id) ON DELETE CASCADE,
    artist VARCHAR(128),
    artist_id INTEGER REFERENCES artist(id) ON DELETE CASCADE,
    PRIMARY KEY(id)
);

\copy track(title,artist,album,count,rating,len) FROM 'library.csv' WITH DELIMITER ',' CSV;

-- Answer 2.2c

INSERT INTO album (title) SELECT DISTINCT album FROM track;
UPDATE track SET album_id = (SELECT album.id FROM album WHERE album.title = track.album);

INSERT INTO tracktoartist (track, artist) SELECT DISTINCT title, artist from track;
INSERT INTO artist (name) SELECT distinct artist from track;

UPDATE tracktoartist SET track_id = (select track.id from track where track.title = tracktoartist.track);
UPDATE tracktoartist SET artist_id = (select artist.id from artist where artist.name = tracktoartist.artist);

We are now done with these text fields

ALTER TABLE track DROP COLUMN album;
ALTER TABLE tracktoartist DROP COLUMN track;
ALTER TABLE tracktoartist DROP column artist;

-- Assignments 2.3a

In this assignment you will write a simple hashing function that uses addition and multiplication 
and then find a pair of strings that will return the same hash value for different strings 

The algorithm uses multiplication based on the position of a letter in the hash 
to avoid a hash collision when two letters are transposed like in 'ABCDE' and 'ABDCE'. 
Your strings need to be at least three characters long and no more than 10 characters long.

Here is the code that computes your hash:

while True:
    txt = input("Enter a string: ")
    if len(txt) < 1 : break

    hv = 0
    pos = 0
    for let in txt:
        pos = ( pos % 3 ) + 1  
        hv = (hv + (pos * ord(let))) % 1000000
        print(let, pos, ord(let), hv)

    print(hv, txt)
    
For simplicity we will only use upper and lower case ASCII letters in our text strings.

Enter a string: ABCDE
A 1 65 65
B 2 66 197
C 3 67 398
D 1 68 466
E 2 69 604
604 ABCDE

Enter a string: BACDE
B 1 66 66
A 2 65 196
C 3 67 397
D 1 68 465
E 2 69 603
603 BACDE

-- Answer 2.3a

ABCDE

DECAB

-- Assignments 2.3b

In this assignment you will create a table named bigtext with a single TEXT column named content. 
Insert 100000 records with numbers starting at 100000 and going through 199999 into the table 
as shown below:

This is record number 100000 of quite a few text records.
This is record number 100001 of quite a few text records.
...
This is record number 199998 of quite a few text records.
This is record number 199999 of quite a few text records.


-- Answer 2.3b

create table bigtext (
	content text
);

insert into bigtext (content) 
	select (
	'This is record number ' || generate_series(100000, 199999) || ' of quite a few text records'
	);


-- Assignments 2.4

In this assignment you will create a regular expression to retrieve a subset data from the purpose column of the taxdata table 
in the readonly database (access details below). Write a regular expressions to retrieve that meet the following criteria:

Lines that end with a period (.) (dont forget to escape)

-- Answer 2.4

select purpose from taxdata where purpose ~ '.*\.$';






















	











	