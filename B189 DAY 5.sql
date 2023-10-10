------------------ DAY 5 -----------------------

---Her iki ayda birden satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız

SELECT urun_isim,musteri_isim
FROM nisan AS n
WHERE EXISTS (SELECT urun_isim FROM mart AS m WHERE m.urun_isim=n.urun_isim)

--Martta satılıp Nisanda satilmayan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--MART ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.
SELECT musteri_isim,urun_isim
FROM mart as m
WHERE NOT EXISTS (SELECT urun_isim FROM nisan as n WHERE n.urun_isim= m.urun_isim )

------------DAY'5-------------
-- CREATE: INSERT
-- READ: SELECT
-- UPDATE:
--DELETE:DELETE


--26-UPDATE tablo_adı SET sütun_adı= yenideğer
--WHERE koşul  komutu: tablodaki koşulu sağlayan kayıtları günceller.



--idsi 123456789 olan çalışanın isyeri ismini 'Trendyol' olarak güncelleyeniz.

UPDATE calisanlar3
SET isyeri='Trendyol'
WHERE id=123456789;

-- id'si 567890123 olan çalışanın ismini 'Veli Yıldırım' ve sehirini 'Bursa' olarak güncelleyiniz.

UPDATE calisanlar3
SET isim='Veli Yıldırım',sehir='Bursa'
WHERE id=567890123;

--  markalar tablosundaki marka_id değeri 102 ye eşit veya büyük olanların marka_id'sini 2 ile çarparak değiştirin.
UPDATE markalar
SET marka_id=marka_id*2
WHERE marka_id>=102

-- markalar tablosundaki tüm markaların calisan_sayisi değerlerini marka_id ile toplayarak güncelleyiniz.

UPDATE markalar
SET calisan_sayisi=calisan_sayisi+marka_id;

--calisanlar3 tablosundan Ali Seker'in isyerini, 'Veli Yıldırım' ın isyeri ismi ile güncelleyiniz.
UPDATE calisanlar3
SET isyeri=(SELECT isyeri FROM calisanlar3 WHERE isim='Veli Yıldırım')
WHERE isim='Ali Seker';

--calisanlar3 tablosunda maasi 1500 olanların isyerini, markalar tablosunda
--calisan_sayisi 20000 den fazla olan markanın ismi ile değiştiriniz.

UPDATE calisanlar3
SET isyeri= (SELECT marka_isim FROM markalar WHERE calisan_sayisi > 20000)
WHERE maas=1500;

--calisanlar3 tablosundaki isyeri 'Vakko' olanların sehir bilgisinin sonuna ' Şubesi' ekleyiniz.

UPDATE calisanlar3
SET sehir=sehir || ' Şubesi'
WHERE isyeri='Vakko';


SELECT * FROM calisanlar3;
SELECT * FROM markalar;






--27-IS NULL condition  

CREATE TABLE people
(
ssn char(9),
name varchar(50),
address varchar(50)
);
INSERT INTO people VALUES(123456789, 'Ali Can', 'Istanbul');
INSERT INTO people VALUES(234567890, 'Veli Cem', 'Ankara');
INSERT INTO people VALUES(345678901, 'Mine Bulut', 'Izmir');
INSERT INTO people (ssn, address) VALUES(456789012, 'Bursa');
INSERT INTO people (ssn, address) VALUES(567890123, 'Denizli');
INSERT INTO people (ssn, name) VALUES(567890123, 'Veli Han');

SELECT * FROM people;

-- people tablsoundaki name sütununda NULL olan değerleri listeyeleyiniz.
SELECT *
FROM people
WHERE name IS NULL 	--Null değer olmadığı için = yazılmaz böyle yazılır.

--people tablosundaki adres sütununda NULL olmayan değerleri listleyiniz.
SELECT *
FROM people
WHERE address IS NOT NULL;


--people tablosunda name sütunu null olanların name değerini 
--'MISSING...' olarak güncelleyiniz..

UPDATE people
Set name='MISSING...'
WHERE name IS NULL;

UPDATE people
Set address='MISSING...'
WHERE address IS NULL;


--28-ORDER BY: kayıtları belirli bir fielda göre varsayılan olarak NATURAL şekilde sıralar.

CREATE TABLE person
(
ssn char(9),
isim varchar(50),
soyisim varchar(50),  
adres varchar(50)
);

INSERT INTO person VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO person VALUES(234567890, 'Veli','Cem', 'Ankara');  
INSERT INTO person VALUES(345678901, 'Mine','Bulut', 'Ankara');  
INSERT INTO person VALUES(256789012, 'Mahmut','Bulut', 'Istanbul'); 
INSERT INTO person VALUES (344678901, 'Mine','Yasa', 'Ankara');  
INSERT INTO person VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');
INSERT INTO person VALUES(256789018, 'Samet','Bulut', 'Izmir'); 
INSERT INTO person VALUES(256789013, 'Veli','Cem', 'Bursa'); 
INSERT INTO person VALUES(256789010, 'Samet','Bulut', 'Ankara');

SELECT * FROM person;

--person tablosundaki tüm kayıtları adrese göre (artan) sıralayarak listeleyiniz.
SELECT *
FROM person
ORDER BY adres ASC; --ASC yazmak artarak sıralamasıdır, ancak ORDER BY zaten böyle sıralar burada yazmaya gerek yok.

SELECT *
FROM person
ORDER by soyisim DESC; --DESCENDING: azalan demektir.

--person tablosundaki soyismi Bulut olanları isime göre (azalan) sıralayarak listeleyiniz.
SELECT *
FROM person
WHERE soyisim='Bulut'
ORDER BY isim DESC;

-- alternatif
SELECT *
FROM person
WHERE soyisim='Bulut'
ORDER BY 2 DESC; --sütun indeksi kullanıldı ancak tavsiye edilmez. 1 Okunabilir değil, 2 tablo değişirse indeks de değişir.

--person tablosundaki tum kayitlari isimler Natural sirali, Soyisimler ters sirali olarak listeleyiniz
SELECT * 
FROM person
ORDER BY isim ASC, soyisim DESC; --isimler aynıysa soyisime bakacak artık ve z-a sıralayacak.

--İsim ve soyisim değerlerini, soyisim kelime uzunluklarına göre sıralayarak listeleyiniz.

SELECT isim,soyisim,LENGTH(soyisim) AS karakter_sayısı
FROM person
ORDER BY LENGTH(soyisim);

--Tüm isim ve soyisim değerlerini aralarında bir boşluk ile aynı sutunda çağırarak her bir isim ve 
--soyisim değerinin toplam uzunluğuna göre sıralayınız.

SELECT isim||' '||soyisim AS ad_soyad, LENGTH(isim||soyisim)
FROM person
ORDER BY LENGTH(isim||soyisim);

--calisanlar3 tablosunda maaşı ortalama maaştan yüksek olan çalışanların
--isim,şehir ve maaşlarını maaşa göre artan sıralayarak listeleyiniz.

SELECT isim,sehir,maas
FROM calisanlar3
WHERE maas>(SELECT AVG(maas) FROM calisanlar3)
ORDER BY maas;



