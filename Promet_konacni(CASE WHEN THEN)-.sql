; with priprema1 as (
select p.id_sura,
    sum(case when year(r.datum) = (2000 - 1) and r.id_vrst like '10%' then r.iznos else 0.00 end) as premija_ao0,
    sum(case when year(r.datum) = (2000 + 0) and r.id_vrst like '10%' then r.iznos else 0.00 end) as premija_ao,
    sum(case when year(r.datum) = (2000 - 1) and r.id_vrst like '03%' then r.iznos else 0.00 end) as premija_ak0,
    sum(case when year(r.datum) = (2000 + 0) and r.id_vrst like '03%' then r.iznos else 0.00 end) as premija_ak,
    sum(case when year(r.datum) = (2000 - 1) and not (r.id_vrst like '10%' or r.id_vrst like '03%') then r.iznos else 0.00 end) as premija_on0,
    sum(case when year(r.datum) = (2000 + 0) and not (r.id_vrst like '10%' or r.id_vrst like '03%') then r.iznos else 0.00 end) as premija_on 
	
	from osiguranje.police_osn p
		inner join osiguranje.st_polr r
		on p.broj = r.broj
	where year(r.datum) = 2000 or year(r.datum) = (2000 - 1) 
	group by p.id_sura
)

select p.id_sura,
    z.imeipre as ime,
    y.opis as prod_mjesto,
    p.premija_ao0,
    p.premija_ao,
    case when p.premija_ao0 is not null and p.premija_ao0 <> 0
        then (p.premija_ao - p.premija_ao0) / p.premija_ao0 * 100.0
        end as amerus_ao,
    p.premija_ak0,
    p.premija_ak,
    case when p.premija_ak0 is not null and p.premija_ak0 <> 0
        then (p.premija_ak - p.premija_ak0) / p.premija_ak0 * 100.0
        end as amerus_ak,
    p.premija_on0,
    p.premija_on,
    case when p.premija_on0 is not null and p.premija_on0 <> 0
        then (p.premija_on - p.premija_on0) / p.premija_on0 * 100.0
        end as amerus_on
from priprema1 p
    left outer join osiguranje.suradnci z
        left outer join osiguranje.prodstru y
        on z.prodstru = y.id_ps
    on p.id_sura = z.id_sura
