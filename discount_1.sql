select *
into #p1 -- drop table #p1
	from osiguranje.st_polr (nolock)
	where broj in (select broj from osiguranje.poli02 (nolock) where id_grpol = '1900002')
		and rata = 1 and tipd = 'D'
	order by broj

select *
	from #p1
	order by broj, rata, datum

select * -- , 201906260000 + row_number() over (order by polica) as novi
into #p2 -- drop table #p2
	from #p1

declare @iznos_pol decimal(12, 2), @posto_rd decimal(12,4)
set @iznos_pol = 2736.00
set @posto_rd = 0.37
--select @posto_rd
update #p2
	set rata = 13,
		iznos = @iznos_pol, izn_rd = round(@iznos_pol * @posto_rd, 2)

--insert into osiguranje.st_polr
select *
	from #p2
	order by broj, rata, datum
