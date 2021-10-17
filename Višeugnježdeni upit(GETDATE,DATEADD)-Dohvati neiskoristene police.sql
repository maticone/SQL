Declare @JMBG VARCHAR(13);
set @JMBG='2506977177004'


SELECT DISTINCT   broj, ranija, ugo_id,osi_id,ugo_naz, p1.datum , poc_dat, ist_dat, marka,vrsta, br_sasije 
FROM 
	(
				SELECT broj, ranija, ugo_id, osi_id,ugo_naz, p.datum , poc_dat, ist_dat, marka,vrsta, br_sasije 
				FROM 
							(
								SELECT  broj, ranija, ugo_id, ugo_naz ,osi_id, datum , poc_dat, ist_dat, marka,vrsta,br_sasije 
								from osiguranje.POLI10 
								WHERE ugo_id =@JMBG and datum between (DATEADD(DAY, -1095, GETDATE())) and (GETDATE()) 
								and broj not in (SELECT ranija 
												 FROM osiguranje.POLI10  
												 WHERE  datum between (DATEADD(DAY, -1095, GETDATE())) and (GETDATE()))
							) AS p
				WHERE p.datum <=(DATEADD(DAY, -330, GETDATE())) or p.ugo_id <> p.osi_id )as p1
left join osiguranje.unx_log u on
p1.broj = u.kljuc
WHERE p1.broj not in   (SELECT  kljuc 
						FROM osiguranje.unx_log 
						WHERE trans_id ='6460' or trans_id='6472' or trans_id ='5492')
