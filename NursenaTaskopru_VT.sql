use ARAC_SATIS

select * from TblAraclar
select * from TblAracSahibi
select * from Tbl�l
select * from TblMarka
select * from TblModel
select * from TblVites

--1. Ara� sahibinin ad�-soyad�-cep telefonu, ara� markas�-modeli, arac�n vites t�r�, kilometresi ve fiyat bilgilerini getiren sorguyu yaz�n�z.

select TblAracSahibi.isim, TblAracSahibi.soyisim, TblAracSahibi.ceptel,TblMarka.isim as marka, TblModel.model, TblVites.tur, TblAraclar.km, TblAraclar.fiyat
from   TblAraclar
inner join TblMarka on TblMarka.id = TblAraclar.marka_id
inner join TblModel on TblModel.id = TblAraclar.model_id
inner join TblAracSahibi on TblAracSahibi.id = TblAraclar.sahip_id
inner join TblVites on TblVites.id = TblAraclar.vites_id

--2. Her ara� sahibinin ad�-soyad� ve ka� arac� oldu�unu getiren sorguyu yaz�n�z.

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

--3. Markalara g�re ara�lar�n ortalama fiyatlar�n� pahal�dan ucuza do�ru getiren sorguyu yaz�n�z.

select TblMarka.isim as MarkaIsmi, avg(TblAraclar.fiyat) as OrtalamaFiyat
from   TblAraclar
inner join TblMarka on TblMarka.id = TblAraclar.marka_id
inner join TblModel on TblModel.id = TblAraclar.model_id
inner join TblAracSahibi on TblAracSahibi.id = TblAraclar.sahip_id
inner join TblVites on TblVites.id = TblAraclar.vites_id
group by TblMarka.isim
order by avg(TblAraclar.fiyat) desc


--4. 100.000 km alt�ndaki d�z vites ara�lar�n marka, model, km, y�l ve fiyat bilgilerini getiren sorguyu yaz�n�z.

select TblMarka.isim markaIsim, TblModel.model, TblAraclar.km, TblAraclar.y�l, TblAraclar.fiyat
from   TblAraclar
inner join TblMarka on TblMarka.id = TblAraclar.marka_id
inner join TblModel on TblModel.id = TblAraclar.model_id
inner join TblAracSahibi on TblAracSahibi.id = TblAraclar.sahip_id
inner join TblVites on TblVites.id = TblAraclar.vites_id
where TblVites.tur = 'D�z' and TblAraclar.km < 100000

--5. Markalara g�re A'dan Z'ye ve fiyata g�re pahal�dan ucuza do�ru ara�lar� listeleyen sorguyu yaz�n�z.

select TblMarka.isim as MarkaIsmi, TblAraclar.fiyat as Fiyat
from   TblAraclar
inner join TblMarka on TblMarka.id = TblAraclar.marka_id
inner join TblModel on TblModel.id = TblAraclar.model_id
inner join TblAracSahibi on TblAracSahibi.id = TblAraclar.sahip_id
inner join TblVites on TblVites.id = TblAraclar.vites_id
order by TblMarka.isim,TblAraclar.fiyat desc

--6. D�z vites ve otomatik ara�lar�n ortalama fiyatlar�n� getiren sorguyu yaz�n�z.

select TblVites.tur as VitesTuru, avg(TblAraclar.fiyat) as OrtalamaFiyat
from TblAraclar
inner join TblMarka on TblMarka.id = TblAraclar.marka_id
inner join TblVites on TblVites.id = TblAraclar.vites_id
where TblVites.tur in ('Otomatik', 'D�z')
group by TblVites.tur

--ya da

select TblVites.tur as VitesTuru, avg(TblAraclar.fiyat) as OrtalamaFiyat
from TblAraclar
inner join TblMarka on TblMarka.id = TblAraclar.marka_id
inner join TblVites on TblVites.id = TblAraclar.vites_id
where TblVites.tur = 'D�z' or  TblVites.tur = 'Otomatik'
group by TblVites.tur


--7. Ara� sahiplerinin ad, soyad ve cep telefonlar� ile birlikte sahip olduklar� ara�lar�n toplam piyasa de�erine g�re �oktan aza do�ru listeleyen sorguyu yaz�n�z.

select TblAracSahibi.isim as isim, TblAracSahibi.soyisim as soyisim, TblAracSahibi.ceptel as ceptelefonu, sum(TblAraclar.fiyat) as toplam_piyasa_degeri
from TblAraclar
inner join TblMarka on TblMarka.id = TblAraclar.marka_id
inner join TblModel on TblModel.id = TblAraclar.model_id
inner join TblAracSahibi on TblAracSahibi.id = TblAraclar.sahip_id
inner join TblVites on TblVites.id = TblAraclar.vites_id
group by TblAracSahibi.isim, TblAracSahibi.soyisim, TblAracSahibi.ceptel
order by toplam_piyasa_degeri desc

--cevap yukar�daki ama do�rulu�unu g�remek i�in a�a��dakini de yaz�yorum

select TblAracSahibi.isim isim, TblAracSahibi.soyisim soyisim, TblAracSahibi.ceptel ceptelefonu, TblMarka.isim marka, TblModel.model model, TblAraclar.fiyat fiyat
from   TblAraclar
inner join TblMarka on TblMarka.id = TblAraclar.marka_id
inner join TblModel on TblModel.id = TblAraclar.model_id
inner join TblAracSahibi on TblAracSahibi.id = TblAraclar.sahip_id
inner join TblVites on TblVites.id = TblAraclar.vites_id
group by TblAracSahibi.isim, TblAracSahibi.soyisim, TblAracSahibi.ceptel, TblMarka.isim, TblModel.model, TblAraclar.fiyat
order by TblAraclar.fiyat desc


--8. Ara� sahiplerinin ad, soyad ve cep telefonlar�n� ve sahip olduklar� ara�lardan sadece en pahal� olan�n marka, model, vites, km ve fiyat bilgisini getiren sorguyu yaz�n�z.

select TblAracSahibi.isim, TblAracSahibi.soyisim, TblAracSahibi.ceptel, TblMarka.isim as marka, TblModel.model as model, TblVites.tur as vites, TblAraclar.km as km, TblAraclar.fiyat as fiyat
from TblAraclar
inner join TblMarka on TblMarka.id = TblAraclar.marka_id
inner join TblModel on TblModel.id = TblAraclar.model_id
inner join TblAracSahibi on TblAracSahibi.id = TblAraclar.sahip_id
inner join TblVites on TblVites.id = TblAraclar.vites_id
where TblAraclar.fiyat = (select max(aracFiyat.fiyat)
        from TblAraclar as aracFiyat
        where aracFiyat.sahip_id = TblAraclar.sahip_id)
