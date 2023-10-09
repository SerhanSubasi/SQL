------------------ DAY 3 DT-NT ---------------------------
-------------------  tekrar  -----------------------------

CREATE TABLE calisanlar(
id char(5) PRIMARY KEY,
isim varchar(50) UNIQUE,
maas int NOT NULL,
ise_baslama date
); --referenced table OR parent table

CREATE TABLE adresler(
adres_id char(5),
sokak varchar(30),
cadde varchar(30),
sehir varchar(20),
FOREIGN KEY(adres_id) REFERENCES calisanlar(id) 
);  --child

INSERT INTO calisanlar VALUES('10002', 'Donatello' ,12000, '2018-04-14'); 
INSERT INTO calisanlar VALUES('10003', null, 5000, '2018-04-14'); -- isim sütununda not null yok, kabul etti.
INSERT INTO calisanlar VALUES('10004', 'Donatello', 5000, '2018-04-14'); -- isim unique olmalıydı HATA
INSERT INTO calisanlar VALUES('10005', 'Michelangelo', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10006', 'Leonardo', null, '2019-04-12'); --maas not null yazıyor HATA
INSERT INTO calisanlar VALUES('10007', 'Raphael', '', '2018-04-14'); -- int tip yazıp string giremeyiz. HATA
INSERT INTO calisanlar VALUES('', 'April', 2000, '2018-04-14');
INSERT INTO calisanlar VALUES('', 'Ms.April', 2000, '2018-04-14'); -- 1 defa empty girildi, unique olmalı HATA 
INSERT INTO calisanlar VALUES('10002', 'Splinter' ,12000, '2018-04-14'); -- id:10002 zaten var HATA
INSERT INTO calisanlar VALUES( null, 'Fred' ,12000, '2018-04-14'); -- PK Not nUll'dır HATA
INSERT INTO calisanlar VALUES('10008', 'Barnie' ,10000, '2018-04-14');
INSERT INTO calisanlar VALUES('10009', 'Wilma' ,11000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', 'Betty' ,12000, '2018-04-14');

INSERT INTO adresler VALUES('10003','Ninja Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Kaya Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Taş Sok', '30.Cad.','Konya');

INSERT INTO adresler VALUES('10012','Taş Sok', '30.Cad.','Konya'); -- PK sütununda bulunmayan 10012'den dolayı HATA 


INSERT INTO adresler VALUES(NULL,'Taş Sok', '23.Cad.','Konya');
INSERT INTO adresler VALUES(NULL,'Taş Sok', '33.Cad.','Bursa');

SELECT * From calisanlar;
SELECT * From adresler;

--14 Where Condition

--calisanlar tablosundan ismi 'Donatello' olanların tüm bilgilerini listeleyelim
SELECT * FROM calisanlar WHERE isim='Donatello';

--calisanlar tablosundan maaşı 5000'den fazla olanların tüm bilgilerini listeleyelim
SELECT isim,maas FROM calisanlar WHERE maas>5000;

SELECT * FROM adresler WHERE sehir='Konya' AND adres_id='10002';
SELECT cadde,sehir from adresler where sehir='Bursa' OR sehir='Konya';

--15 DELETE FROM ... WHERE ... komutu: Tablodan koşulu sağlayan kayıtları siler
CREATE TABLE ogrenciler1
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int       
);

INSERT INTO ogrenciler1 VALUES(122, 'Kerem Can', 'Fatma',75);
INSERT INTO ogrenciler1 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler1 VALUES(124, 'Veli Han', 'Ayse',85);
INSERT INTO ogrenciler1 VALUES(125, 'Kemal Tan', 'Hasan',85);
INSERT INTO ogrenciler1 VALUES(126, 'Ahmet Ran', 'Ayse',95);
INSERT INTO ogrenciler1 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler1 VALUES(128, 'Mustafa Bak', 'Ali', 99);
INSERT INTO ogrenciler1 VALUES(129, 'Mehmet Bak', 'Alihan', 89);

SELECT * FROM ogrenciler1;

--id=123 olan kaydı silelim
DELETE FROM ogrenciler1 WHERE id=123;
--ismi Kemal Tan olan kaydı silelim
DELETE FROM ogrenciler1 WHERE isim='Ahmet Ran';
--ismi Ahmet Ran  veya Veli Han olan kayıtları silelim
DELETE FROM ogrenciler1 WHERE isim='Ahmet Ran' OR isim='Veli Han';

SELECT * FROM students;
SELECT * FROM doctors;

--16 Tablodaki tüm kayıtları silme: DELETE FROM ...: Koşul belirtmezsek tablodaki tüm kayıtları siler.
DELETE FROM students;
--16 v2 Tablodaki tüm kayıtları silme: TRUNCATE TABLE ...
TRUNCATE TABLE doctors; --Where komutu kullanılamaz

--17 aralarında parent child ilişkisi olan rablolarda silme işlemini gerçekleştirmek için
SELECT * FROM calisanlar; --parent
SELECT * FROM adresler; --child

--calisanlar tablosundaki tüm kayıtları silelim
DELETE FROM calisanlar; -- Bunu silmez çünkü önce childını silmek gerekir.
DELETE FROM calisanlar WHERE id='10002'; -- yine silmez.

DELETE FROM adresler WHERE adris_id='10002'; -- Child parenttaki 10002 noluyu sildik.
DELETE FROM calisanlar WHERE id='10002'; -- ilişki koparıldığı için artık siler.

DELETE FROM adresler;	--Child'ı tamamen sildik
DELETE FROM calisanlar; -- Calışanları tamamen sildik


--18 ON DELETE CASCADE: kademeli silme işlemini otomatikleştirir.
CREATE TABLE talebeler
(
id int primary key,  
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);--parent

CREATE TABLE notlar( 
talebe_id int,
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebeler(id) ON DELETE CASCADE	
);--child


INSERT INTO talebeler VALUES(122, 'Kerem Can', 'Fatma',75);
INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebeler VALUES(124, 'Veli Han', 'Ayse',85);
INSERT INTO talebeler VALUES(125, 'Kemal Tan', 'Hasan',85);
INSERT INTO talebeler VALUES(126, 'Ahmet Ran', 'Ayse',95);
INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO talebeler VALUES(128, 'Mustafa Bak', 'Ali', 99);
INSERT INTO talebeler VALUES(129, 'Mehmet Bak', 'Alihan', 89);

INSERT INTO notlar VALUES ('123','kimya',75);
INSERT INTO notlar VALUES ('124', 'fizik',65);
INSERT INTO notlar VALUES ('125', 'tarih',90);
INSERT INTO notlar VALUES ('126', 'Matematik',90);
INSERT INTO notlar VALUES ('127', 'Matematik',90);
INSERT INTO notlar VALUES (null, 'tarih',90);

SELECT * FROM talebeler;
SELECT * FROM notlar;

--notlar tablosundan id'si:123 olan kaydı silelim
DELETE FROM notlar WHERE talebe_id=123;

--talebeler tablosundan idsi:126 olan kaydı silmeliyiz
--parenttan referanslı bir kaydı silmek için aşamalı (cascade) silme yapmalıyız
-- on delete cascade önce notlar tablosundan ref. siler, sonra parenttan ref. silinen kaydı siler.

DELETE FROM talebeler WHERE id=126;

DELETE FROM talebeler; --notlar tablosundan da sadece ref. olan kayıtları siler.

--19 Tabloyu silme: tabloyu SCHEMAdan kaldırma
--sairler tablosunu silelim

DROP TABLE sairler; --DDL
--talebeler tablosunu silelim
DROP TABLE talebeler; --ilişki hala tanımlı olduğu için silmez
DROP TABLE talebeler CASCADE;

--talebeler1 tablosunu silelim
DROP TABLE IF EXISTS talebeler1; -- böyle bir tablo yok ve bu hatayı almamak için

--20 IN - NOT IN CONDITION : liste içindeyse true

CREATE TABLE musteriler  (
urun_id int,  
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');
INSERT INTO musteriler VALUES (20, 'John', 'Apple');
INSERT INTO musteriler VALUES (30, 'Amy', 'Palm');
INSERT INTO musteriler VALUES (20, 'Mark', 'Apple');
INSERT INTO musteriler VALUES (10, 'Adem', 'Orange');
INSERT INTO musteriler VALUES (40, 'John', 'Apricot');
INSERT INTO musteriler VALUES (20, 'Eddie', 'Apple');

SELECT * FROM musteriler;

--Müşteriler tablosundan ürün ismi 'Orange', 'Apple' veya 'Apricot' olan verileri listeleyiniz.

SELECT * FROM  musteriler WHERE urun_isim='Orange' OR  urun_isim='Apple' OR urun_isim='Apricot'

--2.yol
SELECT * FROM musteriler WHERE urun_isim IN('Orange', 'Apple', 'Apricot');

--Müşteriler tablosundan ürün ismi 'Orange', 'Apple' ve 'Apricot' olmayan verileri listeleyiniz.
SELECT * FROM musteriler WHERE urun_isim NOT IN('Orange', 'Apple', 'Apricot');

--21 BETWEEN ... AND ..

Select * From musteriler Where urun_id>=20 AND urun_id<=40

--2.yol
select * from musteriler where urun_id between 20 and 40;

--Müşteriler tablosunda urun_id 20 den küçük veya 30(dahil değil) dan büyük olan urunlerin tum bilgilerini listeleyiniz
SELECT * 
FROM musteriler
WHERE urun_id<20 OR urun_id>30;

--2.yol
SELECT * FROM musteriler WHERE urun_id NOT BETWEEN 20 AND 30;

--22 AGGREGATE FONKSİYON 

CREATE TABLE calisanlar3 (
id int, 
isim VARCHAR(50), 
sehir VARCHAR(50), 
maas int, 
isyeri VARCHAR(20)
);

INSERT INTO calisanlar3 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisanlar3 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO calisanlar3 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar3 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisanlar3 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar3 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar3 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');

CREATE TABLE markalar
(
marka_id int, 
marka_isim VARCHAR(20), 
calisan_sayisi int
);

INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);

SELECT * FROM markalar;
SELECT * FROM calisanlar3;

--calisanlar3 tablosundaki max maaşı görüntüleyiniz
SELECT MAX(maas) FROM calisanlar3;

--calisanlar3 tablosundaki min maaşı görüntüleyiniz
SELECT MIN(maas) FROM calisanlar3;

--calisanlar3 tablosundaki toplam maaşı görüntüleyiniz
SELECT SUM(maas) FROM calisanlar3;

--calisanlar3 tablosundaki ortalama maaşı görüntüleyiniz
SELECT AVG(maas) FROM calisanlar3;
SELECT ROUND (AVG(maas),2) FROM calisanlar3; --yuvarlayarak yazması için

--calisanlar3 tablosundaki kayıt sayısını görüntüleyiniz
SELECT COUNT(maas) FROM calisanlar3;

--calisanlar3 tablosundaki maaşı 2500 olanların sayısını görüntüleyiniz
SELECT COUNT(maas) FROM calisanlar3 WHERE maas=2500;



