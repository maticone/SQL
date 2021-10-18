select *
into #p1 -- drop table #p1
	from osiguranje.st_prem (nolock)
	where polica in (select broj from osiguranje.poli02 (nolock) where id_grpol = '1900002')
		and rata = 1
	order by polica

select *
	from #p1
	order by polica

select *, 201906260000 + row_number() over (order by polica) as novi
into #p2 -- drop table #p2
	from #p1

--update #p2
--	set rata = 13, iznos = 2880.00 - 144.00, dofakt = 1, alt_vrsta = ''

update #p2
	set serial = novi

--alter table #p2
--	drop column novi

update osiguranje.st_prem
	set iznos = 0
	where polica in (select polica from #p1)

--insert into osiguranje.st_prem
select *
	from #p2
	order by polica
