

select a.sifra , a.naziv, s.proizvod from osiguranje.SKUP_OS a , osiguranje.stim_vrst s where s.PROIZVOD like '%' + a.sifra  + '%'

