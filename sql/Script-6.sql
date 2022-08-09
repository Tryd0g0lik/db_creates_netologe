-- название альбомов, содержащих наименьшее количество треков.; 
select m2.name from members m2
	where m2.name not in (
		select m.name from members m 
		join albums_members am on am.id_members = m.id_members
		join albums a on a.id_albums = am.id_albums
		where "year" in ('2018-01-01'));

-- название альбомов, содержащих наименьшее количество треков
select a3.titl, a3.title from 
	(
		select a.id_albums, a.title, count(a.title) titl 
		from albums a 
		join music m on a.id_albums = m.id_albums 
		group by a.id_albums
	) a3
	where a3.titl = (
		select min(a2.titl) from 
		(
			select a.id_albums, a.title, count(a.title) titl 
			from albums a 
			join music m on a.id_albums = m.id_albums 
			group by a.id_albums
		) a2
	)