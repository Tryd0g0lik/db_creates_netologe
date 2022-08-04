CREATE TABLE IF NOT EXISTS collaction (id_title SERIAL PRIMARY KEY, title TEXT  NOT null, year DATE not NULL);

CREATE TABLE IF NOT EXISTS genre (id_genre SERIAL PRIMARY KEY, title TEXT NOT NULL UNIQUE);

CREATE TABLE IF NOT EXISTS members (id_members SERIAL PRIMARY KEY, name VARCHAR(100) NOT NULL, nickname VARCHAR(100) );

CREATE TABLE IF NOT EXISTS genre_members (constraint id_cnstr PRIMARY key (id_members, id_genre), id_members integer NOT NULL references members(id_members), id_genre INTEGER NOT NULL REFERENCES genre(id_genre));

CREATE TABLE IF NOT EXISTS albums (id_albums SERIAL PRIMARY key, title VARCHAR(100) not NULL, year DATE NOT null);

CREATE TABLE IF NOT EXISTS albums_members(CONSTRAINT id_cnst PRIMARY key (id_members, id_albums), id_members integer NOT NULL REFERENCES members(id_members), id_albums INTEGER NOT NULL references albums(id_albums));

CREATE TABLE IF NOT exists music (id_music SERIAL PRIMARY key, path TEXT NOT NULL UNIQUE, title varchar(100) NOT NULL unique, time INTEGER NOT NULL, id_albums INTEGER references albums(id_albums));

CREATE TABLE IF NOT EXISTS collaction_music(id_cnstr SERIAL PRIMARY key, id_music integer not null references music(id_music), id_title integer not null references collaction(id_title));

alter table collaction alter column title drop UNIQUE;