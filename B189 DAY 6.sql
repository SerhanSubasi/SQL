--------------DAY'6---------------------
--29-GROUP BY clause:

CREATE TABLE manav
(
isim varchar(50),
urun_adi varchar(50),
urun_miktar int
);

INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
INSERT INTO manav VALUES( 'Veli', 'Elma', 2);  
INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);  
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);  
INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);  
INSERT INTO manav VALUES( 'Veli', 'Uzum', 5);  
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);  
INSERT INTO manav VALUES( 'Veli', 'Elma', 3);  
INSERT INTO manav VALUES( 'Ayse', 'Uzum', 2);


SELECT * FROM manav;

--Manav tablosundaki tüm isimleri ve her bir isim için toplam ürün miktarını görüntüleyiniz.
SELECT isim,SUM(urun_miktar)
FROM manav
GROUP BY isim

--Manav tablosundaki tüm isimleri ve her bir isim için toplam ürün miktarını görüntüleyiniz.
--toplam ürün miktarına göre AZALAN sıralayınız.

SELECT isim,SUM(urun_miktar) AS toplam_kg
FROM manav
GROUP BY isim	-- grupla
ORDER BY toplam_kg DESC --azalan şekilde sırala


--Her bir ismin aldığı her bir ürünün toplam miktarını isme göre sıralı görüntüleyiniz.
SELECT isim,urun_adi, SUM(urun_miktar) AS toplam_kg
FROM manav
GROUP BY isim,urun_adi
ORDER BY isim

--NOT: GROUP BY ile gruplama yapıldığında SELECT'den sonra sadece gruplanan sütun ya da AGGRAGATE kullanabiliriz. (tek olmalı yani değer)
SELECT isim,urun_miktar	-- şu an hata verir. urun_miktar birden fazla sonuç veriyor.
FROM manav
GROUP BY isim 

--ürün ismine göre her bir ürünü alan toplam kişi sayısı gösteriniz.
SELECT urun_adi,COUNT(DISTINCT isim) AS kisi_sayisi
FROM manav
GROUP BY urun_adi

--Isme göre alınan toplam ürün miktarı ve ürün çeşit miktarını bulunuz
SELECT isim, SUM(urun_miktar) AS urun_miktar, COUNT(DISTINCT urun_adi) AS urun_cesidi
FROM manav
GROUP BY isim

--Alinan ürün miktarina gore musteri sayisinı görüntüleyiniz.
--musteri sayisina göre artan sıralayınız.

SELECT urun_miktar,COUNT(DISTINCT isim) AS musteri_sayisi
FROM manav
GROUP BY urun_miktar
ORDER BY musteri_sayisi ASC


--30-HAVING clause: GROUP BY komutundan sonra filtrelemek için AGGRAGATION ile HAVING kullanırız. (Where yerine)

DROP TABLE personel;

CREATE TABLE personel  (
id int,
isim varchar(50),
sehir varchar(50), 
maas int,  
sirket varchar(20)
);

INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda'); 
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota'); 
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford'); 
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
INSERT INTO personel VALUES(678901245, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

SELECT * FROM personel;

--Her bir şirketin MIN maas bilgisini, bu bilgi eğer 4000 den fazla ise görüntüleyiniz.

SELECT sirket, MIN(maas) 
FROM personel
GROUP BY sirket
HAVING MIN(maas)>4000;

--Maaşı 4000 den fazla olan çalışanlardan, her bir şirketin MIN maas bilgisini görüntüleyiniz.

SELECT sirket, MIN(maas) min_maas
FROM personel
WHERE maas>4000
GROUP BY sirket

--NOT:gruplamadan sonra yapılan işlem sonucu ile ilgili bir koşul belirtmek için HAVING,
--gruplamadan önce kayıtları filtrelemek(koşul belirtmek) için WHERE kullanılır.


--Her bir ismin aldığı toplam gelir 10000 liradan fazla ise ismi ve toplam maasi gösteren sorgu yaziniz.
SELECT isim, SUM(maas)
FROM personel
GROUP BY isim
HAVING SUM(maas)>10000

--Eğer bir şehirde çalışan personel(id) sayısı 1’den çoksa sehir ismini ve personel sayısını veren sorgu yazınız
SELECT sehir,COUNT(DISTINCT id) personel_sayisi
FROM personel
GROUP BY sehir
HAVING COUNT(DISTINCT id)>1

--Eğer bir şehirde alınan MAX maas 5000’den düşükse sehir ismini ve MAX maasi veren sorgu yazınız.ÖDEV


--31-UNION: iki farklı sorgunun sonucunu tek bir sütunda görüntülemeyi sağlar.
-- 			Tekrar eden değerleri göstermez. 

-- UNION ALL: UNION gibi kullanılır, fakat tekrarlı olanları da gösterir. 









DROP TABLE developers;

CREATE TABLE developers(
id SERIAL PRIMARY KEY,
name varchar(50),
email varchar(50) UNIQUE,
salary real,
prog_lang varchar(20),
city varchar(50),
age int	
);

INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Abdullah Berk','abdullah@mail.com',4000,'Java','Ankara',28);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Mehmet Cenk','mehmet@mail.com',5000,'JavaScript','Istanbul',35);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Ayşenur Han ','aysenur@mail.com',5000,'Java','Izmir',38);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Kübra Han','kubra@mail.com',4000,'JavaScript','Istanbul',32);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Muhammed Demir','muhammed@mail.com',6000,'Java','Izmir',25);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Fevzi Kaya','fevzi@mail.com',6000,'Html','Istanbul',28);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Enes Can','enes@mail.com',5500,'Css','Ankara',28);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Tansu Han','tansu@mail.com',5000,'Java','Bursa',32);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Said Ran','said@mail.com',4500,'Html','Izmir',33);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Mustafa Pak','mustafa@mail.com',4500,'Css','Bursa',32);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Hakan Tek','hakan@mail.com',7000,'C++','Konya',38);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Deniz Çetin','deniz@mail.com',4000,'C#','Istanbul',30);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Betül Çetin','ummu@mail.com',4000,'C#','Bursa',29);


CREATE TABLE contact_info(
address_id int,
street varchar(30),
number int,	
city varchar(30),
FOREIGN KEY(address_id) REFERENCES developers(id)	
);

INSERT INTO contact_info VALUES(1,'Kaya Sok.',5,'Bursa');
INSERT INTO contact_info VALUES(2,'Kaya Sok.',3,'Ankara');
INSERT INTO contact_info VALUES(3,'Can Sok.',10,'Bursa');
INSERT INTO contact_info VALUES(4,'Gül Sok.',12,'Ankara');
INSERT INTO contact_info VALUES(5,'Can Sok.',4,'Afyon');
INSERT INTO contact_info VALUES(6,'Taş Sok.',6,'Bolu');
INSERT INTO contact_info VALUES(7,'Dev Sok.',6,'Sivas');
INSERT INTO contact_info VALUES(8,'Dev Sok.',8,'Van');


SELECT * FROM developers;
SELECT * FROM contact_info;

--Yaşı 25’den büyük olan developer isimlerini ve 
--yaşı 30'dan küçük developerların kullandığı prog. dillerini birlikte tekrarsız gösteren sorguyu yaziniz

SELECT name FROM developers WHERE age>25 --12 adet
UNION														--TEKRARSIZ VERDİ 16 ADET
SELECT prog_lang FROM developers WHERE age<30 --5 adet


--Yaşı 25’den büyük olan developer isimlerini ve 
--yaşı 30'dan küçük developerların kullandığı prog. dillerini birlikte TEKRARLI gösteren sorguyu yaziniz


SELECT name FROM developers WHERE age>25 --12 adet
UNION ALL													--TEKRARLI VERDİ 17 ADET
SELECT prog_lang FROM developers WHERE age<30 --5 adet

--NOT: UNION/ UNION ALL birleştirdiğimiz sorgular aynı sayıda sütünu göstermeli ve
-- alt alta gelecek olan sütunun data tipi aynı olmalı.


--SORU: Java kullananların maaşını ve prog. dilini ve 
--JavaScript kullananların yaşını ve prog. dilini
--tekrarsız gösteren sorguyu yaziniz

SELECT salary AS maas_yas,prog_lang FROM developers WHERE prog_lang='Java'
UNION
SELECT age,prog_lang FROM developers WHERE prog_lang='JavaScript'

--SORU: id si 8 olan developerın çalıştığı şehir ve maaşını
--iletişim adresindeki şehir ve kapı nosunu görüntüleyiniz.

Select city,salary AS maas_kapıNo FROM developers WHERE id=8
UNION
Select city,number FROM contact_info WHERE address_id=8

--developers tablosundaki şehirler ve
--calisanlar3 tablosunda sehirlerin
--tümünü tekrarsız olarak listeleyiniz


SELECT city FROM developers
UNION
SELECT sehir FROM calisanlar3


-- 32-INTERSECT: iki farklı sorgunun sonuçlarından ortak olanları (kesişimi) tekrarsız olarak gösterir.


--SORU: developers tablosundaki şehirler ve calisanlar3 tablosunda sehirlerin
--aynı olanlarını tekrarsız olarak listeleyiniz


SELECT city FROM developers
INTERSECT
SELECT sehir FROM calisanlar3

--Not: Unıon ile iki farklı sorgunun sonucunu elde ediyoruz.
--Not: Intersect ile iki farklı sorgunun kesişimlerini elde ediyoruz.


--SORU: developers tablosunda Java kullananların çalıştıkları şehirler ve calisanlar3 tablosunda maaşı 1000 den fazla olanların sehirlerinden 
--ortak olanlarını listeleyiniz.

SELECT city FROM developers WHERE prog_lang='Java'
INTERSECT
SELECT sehir FROM calisanlar3 Where maas>1000

--33-EXCEPT: Bir sorgunun sonuçlarından, diğer bir sorgunun sonuçlarından farklı olanlarını gösterir. (birinde olup diğerlerinde olmayanları)


--SORU: developers tablosundaki şehirleri calisanlar3 tablosunda sehirler hariç olarak listeleyiniz
SELECT city FROM developers
EXCEPT
SELECT sehir FROM calisanlar3


--SORU: calisanlar3 tablosundaki şehirleri developers tablosunda sehirler hariç olarak listeleyiniz
SELECT sehir FROM calisanlar3
EXCEPT
SELECT city FROM developers

----developers tablosundaki maaşı 4000 den büyük olanların idlerinden
--contact_info tablosunda olmayanları listeleyiniz.

SELECT id FROM developers WHERE salary>4000
EXCEPT
SELECT address_id FROM contact_info


 --Eğer bir şehirde alınan MAX maas 5000’den düşükse sehir ismini ve MAX maasi veren sorgu yazınız.ÖDEV
 SELECT sehir, MAX(maas)
 FROM personel
 GROUP BY sehir
 HAVING MAX(maas)<5000
 
  --ÖDEV:mart ve nisan tablolarındaki tüm ürünlerin isimlerini tekrarsız listeleyiniz.  
 SELECT urun_isim FROM mart
 UNION
 SELECT urun_isim FROM nisan
 
  --ÖDEV:mart ve nisan tablolarındaki ortak ürünlerin isimlerini listeleyiniz.
  SELECT urun_isim FROM mart
  INTERSECT
  SELECT urun_isim FROM nisan
  
 --ÖDEV:mart ayında satılıp nisan ayında satılmayan ürünlerin isimlerini listeleyiniz. 
  SELECT urun_isim FROM mart
  EXCEPT
  SELECT urun_isim FROM nisan
 
 
 
 