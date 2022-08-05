INSERT INTO music (path, title, "time", id_albums) values ('postgresql/how-to-insert-data-into-a-postgresql-table-766', 'Останься', 105, 6);

INSERT INTO albums_members (id_members , id_albums) values (4, 6);

-- количество исполнителей в каждом жанре
SELECT DISTINCT gm.id_genre, COUNT(gm.id_members) FROM genre_members as gm
GROUP BY gm.id_genre;

-- количество исполнителей в каждом жанре
SELECT count(al.title) from albums al WHERE "year" >= '2019-01-01' AND "year" <= '2020-01-01';

 --средняя продолжительность треков по каждому альбому
SELECT DISTINCT m.title, avg(m.time) FROM music m gROUP BY m.title;

-- все исполнители, которые не выпустили альбомы в 2020 году
select  a.title, m.name, a."year" from albums_members am 
join albums a on a.id_albums = am.id_albums
join members m on am.id_members = m.id_members
where 'year' not LIKE '%2020';

-- названия сборников, в которых присутствует конкретный исполнитель (выберите сами);
select distinct c.title, m2."name" from collaction c 
join collaction_music cm on c.id_title = cm.id_title 
join music m on cm.id_music = m.id_music 
join albums a on m.id_albums = a.id_albums 
join albums_members am on a.id_albums = am.id_albums 
join members m2 on am.id_members = m2.id_members
where m2."name" = 'ЕГОР'

-- названия сборников, в которых присутствует конкретный исполнитель (выберите сами);
select a.title, m2."name", count( g.title) from albums a 
join albums_members am on a.id_albums = am.id_albums 
join members m2 on am.id_members = m2.id_members
join genre_members gm on m2.id_members = gm.id_members 
join genre g on gm.id_genre = g.id_genre 
group by a.title, m2."name"
having count( g.title) > 1;

-- наименование треков, которые не входят в сборники
select m.title, c.title from music m 
left join collaction_music cm on m.id_music = cm.id_music 
left join collaction c on cm.id_title = c.id_title 
where c.title IS null;

-- исполнителя(-ей), написавшего самый короткий по продолжительности трек (теоретически таких треков может быть несколько);
select m.name, m2.title, m2."time"  from members m
join albums_members am on m.id_members = am.id_members 
join albums a on am.id_albums = a.id_albums 
join music m2 on a.id_albums = m2.id_albums
where m2."time" = (select min(m2."time") from music m2)
group by m."name", m2.title, m2."time";

 -- название альбомов, содержащих наименьшее количество треков
select a2.title, a2.titl from (select a.title, count(a.title) titl from albums a 
join music m on a.id_albums = m.id_albums group by a.title)a2
where a2.titl = 1
group by a2.title, a2.titl;