--------------DAY 4-------------------
--23 ALIASES: Etiket/Rumuz demektir. Tabloya veya sütunlara sorgularımızda GEÇİCİ isim verebiliriz.

CREATE TABLE workers(
calisan_id char(9),
calisan_isim varchar(50),
calisan_dogdugu_sehir varchar(50)
);

INSERT INTO workers VALUES(123456789, 'Ali Can', 'Istanbul'); 
INSERT INTO workers VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO workers VALUES(345678901, 'Mine Bulut', 'Izmir');


SELECT * FROM workers;

--calisan_id ismine aliases olarak id etiketini verelim.
SELECT calisan_id AS id FROM workers;
SELECT calisan_id id FROM workers;
SELECT calisan_id AS id,calisan_isim AS isim FROM workers;

--id ve isim sütunundaki değerleri tek bir hücre içerisinde görüntüleme
SELECT calisan_id ||'  -  ' || calisan_isim AS id_isim  FROM workers; --JAva'daki or sembolü ile concat eder.

--tabloya geçici isim vermek
SELECT * FROM workers AS w; --kısaltmak için ilk harf kullanılır, veya bir kaç harf.


--24-SUBQUERY--NESTED QUERY
--24-a-SUBQUERY: WHERE ile kullanımı
SELECT * FROM calisanlar3;
SELECT * FROM markalar;

--marka_id si 100 olan markada çalışanları listeleyiniz. (2 adımda yapılacak)
SELECT marka_isim FROM markalar WHERE marka_id=100; --Vakko
SELECT * FROM calisanlar3 WHERE isyeri='Vakko';
-- 2.yol
SELECT * FROM calisanlar3 WHERE isyeri=(SELECT marka_isim FROM markalar WHERE marka_id=100); --(Vakko) parantez içindekine Subquery denir. Baştakine ise outerquery.

--INTERVİEW calısanlar3 tablosunda max maaşı alan çalışanın tüm fieldlarını listeleyiniz.
SELECT * FROM calisanlar3 WHERE maas=(SELECT MAX(maas) FROM calisanlar3);

--INTERVIEW QUESTİON: calisanlar3 tablsounda ikinci en yüksek maaşı gösteriniz. ÖDEV Max haric en yüsek maxı bul


--calisanlar3 tablosunda max veya min maaşı alan çalışanların
-- tüm fieldlarını gösteriniz.
SELECT * FROM calisanlar3 WHERE maas=(SELECT MIN(maas) FROM calisanlar3) OR maas=(SELECT MAX(maas) FROM calisanlar3);

SELECT * FROM calisanlar3 WHERE maas IN ( (SELECT MAX(maas) FROM calisanlar3),(SELECT MIN(maas) FROM calisanlar3) );


-- Ankara'da calisani olan markalarin marka id'lerini ve calisan sayilarini listeleyiniz.
SELECT marka_id,calisan_sayisi FROM markalar WHERE marka_isim IN ('Pierre Cardin','Adidas','Vakko'); -- hard codding
--subquery ile dinamik bir şekilde yazabiliriz.
SELECT marka_id,calisan_sayisi FROM markalar WHERE marka_isim IN (SELECT isyeri FROM calisanlar3 WHERE sehir='Ankara');

--marka_id'si 101’den büyük olan marka çalişanlarinin isim, maaş ve şehirlerini listeleyiniz.
SELECT isim,maas,sehir
FROM calisanlar3
WHERE isyeri IN (SELECT marka_isim FROM markalar WHERE marka_id>101);


-- Çalisan sayisi 15.000’den cok olan markalarin isimlerini ve 
--bu markada calisanlarin isimlerini ve maaşlarini listeleyiniz.

SELECT isim, maas,isyeri
FROM calisanlar3
WHERE isyeri IN (SELECT marka_isim FROM markalar WHERE calisan_sayisi>15000);

--24-b-SUBQUERY: SELECT komutundan sonra kullanımı

--Her markanın id'sini, ismini ve toplam kaç sehirde bulunduğunu listeleyen bir SORGU yazınız.

SELECT marka_id,marka_isim,(SELECT COUNT(DISTINCT(sehir)) FROM calisanlar3 WHERE isyeri=marka_isim) AS sehir_sayisi
FROM markalar;	--DISTINCT sadece farklı olanları say demek.

SELECT DISTINCT (sehir) FROM calisanlar3; -- GİBİ

-- GÖRÜNÜM OLUŞTURMAK İCİN
CREATE VIEW sehir_sayisi AS 
SELECT marka_id,marka_isim,(SELECT COUNT(DISTINCT(sehir)) FROM calisanlar3 WHERE isyeri=marka_isim) AS sehir_sayisi
FROM markalar;

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin maksimum maaşini ve minimum maasını listeleyen bir Sorgu yaziniz.
SELECT marka_isim, calisan_sayisi,
(SELECT MAX(maas) FROM calisanlar3 WHERE isyeri=marka_isim) AS max_maas, -- tek basına calıstıramadığımız sorgulara correlated subquery denilir.
(SELECT MIN(maas) FROM calisanlar3 WHERE isyeri=marka_isim)  AS min_maas
FROM markalar;

--25-EXISTS Cond.

CREATE TABLE mart
(     
urun_id int,      
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO mart VALUES (10, 'Mark', 'Honda');
INSERT INTO mart VALUES (20, 'John', 'Toyota');
INSERT INTO mart VALUES (30, 'Amy', 'Ford');
INSERT INTO mart VALUES (20, 'Mark', 'Toyota');
INSERT INTO mart VALUES (10, 'Adam', 'Honda');
INSERT INTO mart VALUES (40, 'John', 'Hyundai');
INSERT INTO mart VALUES (20, 'Eddie', 'Toyota');

CREATE TABLE nisan 
(     
urun_id int ,
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan VALUES (20, 'Mine', 'Toyota');

select * from mart;
select * from nisan;

-- Mart ayında'Toyota' satışı yapılmış ise Nisan ayındaki tüm ürünlerin bilgilerini listeleyiniz.
SELECT * FROM nisan
WHERE EXISTS (SELECT urun_isim FROM mart WHERE urun_isim='Toyota')


--25-EXISTS Cond.
--Bir SQL sorgusunda alt sorgunun sonucunun boş olup olmadığını kontrol etmek için kullanılır.
--Eğer alt sorgu sonucu boş değilse, koşul sağlanmış sayılır ve sorgunun geri kalanı işletilir.
--Alt sorgu en az bir satır döndürürse sonucu EXISTS doğrudur.
--Alt sorgunun satır döndürmemesi durumunda, sonuç EXISTS yanlıştır.


SELECT urun_id, musteri_isim 
FROM mart
WHERE EXISTS (SELECT urun_id FROM nisan WHERE nisan.urun_isim=mart.urun_isim)



