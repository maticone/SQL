declare @broj char(10);
set @broj = '01'

select id_ps,razina from osiguranje.PRODSTRU where id_nad_ps in(
	select id_ps from osiguranje.PRODSTRU where id_nad_ps in(
	select id_ps from osiguranje.PRODSTRU where id_nad_ps in(
	select id_ps from osiguranje.PRODSTRU where id_nad_ps in(
	select id_ps from osiguranje.PRODSTRU where id_nad_ps = @broj   )
	or id_ps in(select id_ps from osiguranje.PRODSTRU where id_nad_ps = @broj  ))
	))
	or id_ps in(select id_ps from osiguranje.PRODSTRU where id_nad_ps in(
	select id_ps from osiguranje.PRODSTRU where id_nad_ps in(
	select id_ps from osiguranje.PRODSTRU where id_nad_ps in(
	select id_ps from osiguranje.PRODSTRU where id_nad_ps = @broj   )
	or id_ps in(select id_ps from osiguranje.PRODSTRU where id_nad_ps = @broj  ))
	or id_ps in(select id_ps from osiguranje.PRODSTRU where id_nad_ps in(
	select id_ps from osiguranje.PRODSTRU where id_nad_ps = @broj   )
	or id_ps in(select id_ps from osiguranje.PRODSTRU where id_nad_ps = @broj  )))
	or id_ps in(select id_ps from osiguranje.PRODSTRU where id_nad_ps in(
	select id_ps from osiguranje.PRODSTRU where id_nad_ps in(
	select id_ps from osiguranje.PRODSTRU where id_nad_ps = @broj   )
	or id_ps in(select id_ps from osiguranje.PRODSTRU where id_nad_ps = @broj  ))
	or id_ps in(select id_ps from osiguranje.PRODSTRU where id_nad_ps in(
	select id_ps from osiguranje.PRODSTRU where id_nad_ps = @broj   )
	or id_ps in(select id_ps from osiguranje.PRODSTRU where id_nad_ps = @broj or id_ps = @broj))))
order by 2