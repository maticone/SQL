with temp1 as(
				select p.id_sura as suradnik, sum(r.iznos) as iznos
				from osiguranje.POLI10 p
				inner join osiguranje.ST_POLR r
				on p.broj = r.broj
				where year(r.datum) = 2000 or year(r.datum) = (2000 - 1) 
				group by p.id_sura

),
temp2 as(
				select p.id_sura as suradnik, sum(r.iznos) as iznos
				from osiguranje.POLI03 p
				inner join osiguranje.ST_POLR r
				on p.broj = r.broj
				where year(r.datum) = 2000 or year(r.datum) = (2000 - 1) 
				group by p.id_sura
),
temp3 as(
				select  p.id_sura as suradnik, sum(r.iznos) as iznos
				from osiguranje.police_osn p
				inner join osiguranje.ST_POLR r
				on p.broj = r.broj
				where year(r.datum) = 2000 or year(r.datum) = (2000 - 1) and  r.proizvod <>  '10' and r.id_vrst <>  '03'
				group by p.id_sura

)


select p.id_sura as suradnik, p.imeipre , sum (t1.iznos) as  promet_10 , sum (t2.iznos) as  promet_03, sum (t3.iznos) as promez_bez_03_
			from osiguranje.SURADNCI p
						full join temp1 t1
						on p.id_sura = t1.suradnik
						full join temp2 t2
						on p.id_sura = t2.suradnik
						full join temp3 t3
						on p.id_sura = t3.suradnik
where p.id_sura = t1.suradnik or p.id_sura = t2.suradnik or p.id_sura = t3.suradnik
group by p.id_sura, p.imeipre
