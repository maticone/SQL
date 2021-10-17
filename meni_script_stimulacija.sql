USE kvig_sql_new

-- varijable
DECLARE @user VARCHAR(10) = 'MANCE1' -- korisnik
DECLARE @naziv VARCHAR(15) = 'Prometx' -- objekt
DECLARE @opis VARCHAR(35) = 'Prometx' -- naziv objekta
DECLARE @webparam VARCHAR(100) = ''
DECLARE @tip VARCHAR(1) = 'P' -- tip objekta
DECLARE @webtip VARCHAR(1) = 'P' -- webtip objekta
DECLARE @ins INT = 1 -- insert
DECLARE @upd INT = 1 -- update
DECLARE @del INT = 1 -- delete
DECLARE @dtl INT = 1 -- pregled
DECLARE @rbr INT -- redni broj
DECLARE @radno_m VARCHAR(15) -- radno mjesto

-- radno mjesto
;WITH radno_mjesto AS
(
	SELECT (CASE WHEN WEBROOT <> '' THEN WEBROOT ELSE root END) AS radno_mjesto 
	FROM osiguranje.unx_user WHERE abcuser = @user
)
SELECT @radno_m = radno_mjesto FROM radno_mjesto
SELECT @radno_m

-- redni broj
SELECT @rbr = (max(rbr) + 10) FROM osiguranje.unx_meni WHERE nazivnad = @radno_m AND rbr < 900

-- insert into unx_rtm
BEGIN
	IF NOT EXISTS (SELECT * FROM osiguranje.unx_rtm WHERE naziv = @naziv and oznaka = @naziv)
	BEGIN
		INSERT INTO osiguranje.unx_rtm (naziv, opis, tip, oznaka, webtip, webparam) VALUES (@naziv, @opis, @tip, @naziv, @webtip, @webparam)
	END
END

-- insert into unx_rm
BEGIN
	IF NOT EXISTS (SELECT * FROM osiguranje.unx_rm WHERE radno_m = @radno_m and objekt = @naziv)
	BEGIN
		INSERT INTO osiguranje.unx_rm (radno_m, objekt, ins, upd, del, dtl, poziv) VALUES (@radno_m, @naziv, @ins, @upd, @del, @dtl, @naziv)
	END
END

-- insert into unx_meni
BEGIN
	IF NOT EXISTS (SELECT * FROM osiguranje.unx_meni WHERE nazivnad = @radno_m and naziv = @naziv and opis = @opis)
	BEGIN
		INSERT INTO osiguranje.unx_meni (nazivnad, naziv, opis, rbr) VALUES (@radno_m, @naziv, @opis, @rbr)
	END
END