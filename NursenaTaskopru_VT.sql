use ARAC_SATIS

select * from TblAraclar
select * from TblAracSahibi
select * from TblÝl
select * from TblMarka
select * from TblModel
select * from TblVites

--1. Araç sahibinin adý-soyadý-cep telefonu, araç markasý-modeli, aracýn vites türü, kilometresi ve fiyat bilgilerini getiren sorguyu yazýnýz.

select TblAracSahibi.isim, TblAracSahibi.soyisim, TblAracSahibi.ceptel,TblMarka.isim as marka, TblModel.model, TblVites.tur, TblAraclar.km, TblAraclar.fiyat
from   TblAraclar
inner join TblMarka on TblMarka.id = TblAraclar.marka_id
inner join TblModel on TblModel.id = TblAraclar.model_id
inner join TblAracSahibi on TblAracSahibi.id = TblAraclar.sahip_id
inner join TblVites on TblVites.id = TblAraclar.vites_id

--2. Her araç sahibinin adý-soyadý ve kaç aracý olduðunu getiren sorguyu yazýnýz.

select TblAracSahibi.id, TblAracSahibi.isim, TblAracSahibi.soyisim, count(TblAraclar.arac_id) as AracAdedi
from   TblAraclar
inner join TblMarka on TblMarka.id = TblAraclar.marka_id
inner join TblModel on TblModel.id = TblAraclar.model_id
inner join TblAracSahibi on TblAracSahibi.id = TblAraclar.sahip_id
inner join TblVites on TblVites.id = TblAraclar.vites_id
group by TblAracSahibi.isim, TblAracSahibi.soyisim,TblAracSahibi.id
order by count(TblAraclar.arac_id) desc

--ya da

select TblAracSahibi.id, TblAracSahibi.isim, TblAracSahibi.soyisim, count(TblAracSahibi.id) as AracAdedi
from   TblAraclar
inner join TblMarka on TblMarka.id = TblAraclar.marka_id
inner join TblModel on TblModel.id = TblAraclar.model_id
inner join TblAracSahibi on TblAracSahibi.id = TblAraclar.sahip_id
inner join TblVites on TblVites.id = TblAraclar.vites_id
group by TblAracSahibi.isim, TblAracSahibi.soyisim,TblAracSahibi.id
order by count(TblAraclar.arac_id) desc

--3. Markalara göre araçlarýn ortalama fiyatlarýný pahalýdan ucuza doðru getiren sorguyu yazýnýz.

select TblMarka.isim as MarkaIsmi, avg(TblAraclar.fiyat) as OrtalamaFiyat
from   TblAraclar
inner join TblMarka on TblMarka.id = TblAraclar.marka_id
inner join TblModel on TblModel.id = TblAraclar.model_id
inner join TblAracSahibi on TblAracSahibi.id = TblAraclar.sahip_id
inner join TblVites on TblVites.id = TblAraclar.vites_id
group by TblMarka.isim
order by avg(TblAraclar.fiyat) desc


--4. 100.000 km altýndaki düz vites araçlarýn marka, model, km, yýl ve fiyat bilgilerini getiren sorguyu yazýnýz.

select TblMarka.isim markaIsim, TblModel.model, TblAraclar.km, TblAraclar.yýl, TblAraclar.fiyat
from   TblAraclar
inner join TblMarka on TblMarka.id = TblAraclar.marka_id
inner join TblModel on TblModel.id = TblAraclar.model_id
inner join TblAracSahibi on TblAracSahibi.id = TblAraclar.sahip_id
inner join TblVites on TblVites.id = TblAraclar.vites_id
where TblVites.tur = 'Düz' and TblAraclar.km < 100000

--5. Markalara göre A'dan Z'ye ve fiyata göre pahalýdan ucuza doðru araçlarý listeleyen sorguyu yazýnýz.

select TblMarka.isim as MarkaIsmi, TblAraclar.fiyat as Fiyat
from   TblAraclar
inner join TblMarka on TblMarka.id = TblAraclar.marka_id
inner join TblModel on TblModel.id = TblAraclar.model_id
inner join TblAracSahibi on TblAracSahibi.id = TblAraclar.sahip_id
inner join TblVites on TblVites.id = TblAraclar.vites_id
order by TblMarka.isim,TblAraclar.fiyat desc

--6. Düz vites ve otomatik araçlarýn ortalama fiyatlarýný getiren sorguyu yazýnýz.

select TblVites.tur as VitesTuru, avg(TblAraclar.fiyat) as OrtalamaFiyat
from TblAraclar
inner join TblMarka on TblMarka.id = TblAraclar.marka_id
inner join TblVites on TblVites.id = TblAraclar.vites_id
where TblVites.tur in ('Otomatik', 'Düz')
group by TblVites.tur

--ya da

select TblVites.tur as VitesTuru, avg(TblAraclar.fiyat) as OrtalamaFiyat
from TblAraclar
inner join TblMarka on TblMarka.id = TblAraclar.marka_id
inner join TblVites on TblVites.id = TblAraclar.vites_id
where TblVites.tur = 'Düz' or  TblVites.tur = 'Otomatik'
group by TblVites.tur


--7. Araç sahiplerinin ad, soyad ve cep telefonlarý ile birlikte sahip olduklarý araçlarýn toplam piyasa deðerine göre çoktan aza doðru listeleyen sorguyu yazýnýz.

select TblAracSahibi.isim as isim, TblAracSahibi.soyisim as soyisim, TblAracSahibi.ceptel as ceptelefonu, sum(TblAraclar.fiyat) as toplam_piyasa_degeri
from TblAraclar
inner join TblMarka on TblMarka.id = TblAraclar.marka_id
inner join TblModel on TblModel.id = TblAraclar.model_id
inner join TblAracSahibi on TblAracSahibi.id = TblAraclar.sahip_id
inner join TblVites on TblVites.id = TblAraclar.vites_id
group by TblAracSahibi.isim, TblAracSahibi.soyisim, TblAracSahibi.ceptel
order by toplam_piyasa_degeri desc

--cevap yukarýdaki ama doðruluðunu göremek için aþaðýdakini de yazýyorum

select TblAracSahibi.isim isim, TblAracSahibi.soyisim soyisim, TblAracSahibi.ceptel ceptelefonu, TblMarka.isim marka, TblModel.model model, TblAraclar.fiyat fiyat
from   TblAraclar
inner join TblMarka on TblMarka.id = TblAraclar.marka_id
inner join TblModel on TblModel.id = TblAraclar.model_id
inner join TblAracSahibi on TblAracSahibi.id = TblAraclar.sahip_id
inner join TblVites on TblVites.id = TblAraclar.vites_id
group by TblAracSahibi.isim, TblAracSahibi.soyisim, TblAracSahibi.ceptel, TblMarka.isim, TblModel.model, TblAraclar.fiyat
order by TblAraclar.fiyat desc


--8. Araç sahiplerinin ad, soyad ve cep telefonlarýný ve sahip olduklarý araçlardan sadece en pahalý olanýn marka, model, vites, km ve fiyat bilgisini getiren sorguyu yazýnýz.

select TblAracSahibi.isim, TblAracSahibi.soyisim, TblAracSahibi.ceptel, TblMarka.isim as marka, TblModel.model as model, TblVites.tur as vites, TblAraclar.km as km, TblAraclar.fiyat as fiyat
from TblAraclar
inner join TblMarka on TblMarka.id = TblAraclar.marka_id
inner join TblModel on TblModel.id = TblAraclar.model_id
inner join TblAracSahibi on TblAracSahibi.id = TblAraclar.sahip_id
inner join TblVites on TblVites.id = TblAraclar.vites_id
where TblAraclar.fiyat = (select max(aracFiyat.fiyat)
        from TblAraclar as aracFiyat
        where aracFiyat.sahip_id = TblAraclar.sahip_id)
