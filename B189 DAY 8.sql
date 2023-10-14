-------------- DAY 8-----------------

-- 39 String Fonksiyonlar

SELECT name, LENGTH(name)
FROM developers 

UPDATE developers
SET name=REPLACE(name,'Ayşenur','Ayşe') -- REPLACE'DE 1. parametre hangi sütun, 2. parametre eski değer, 3.parametre yeni değer.)

SELECT * FROM developers;

--SORU developers tablosundaki tüm kayıtların name değerlerini büyük harfe 
--prog_lang değerlerinin küçük harfe çevirerek görüntüleyiniz.

SELECT UPPER(name), LOWER(prog_lang) 
FROM developers 


SELECT * FROM calisanlar3

UPDATE calisanlar3
SET sehir=SUBSTRING(sehir,1,LENGTH(sehir)-7) --Tek Şubesi olunca REPLACE yapılır, 2 tane olursa SUBSTRING daha mantıklı.
WHERE isyeri='Vakko' --Baştan -7 karaktere kadar tut gerisini sil demiş olduk.

--words tablosunda tüm kelimeleri(word) ilk harfini büyük diğerleri küçük harfe çevirerek görüntüleyiniz.
SELECT INITCAP(word) --Inicial cap (başlangıç harflerini büyük yapar)
FROM words;

--words tablosunda tüm kelimeleri, tüm kelimelerin(word) ilk iki 2 harfini görüntüleyiniz.
SELECT word, SUBSTRING(word,1,2)
FROM words;


--words tablosunda tüm kelimeleri, tüm kelimelerin(word) 2. indeksten itibaren görüntüleyiniz.
SELECT word, SUBSTRING(word,2)
FROM words;

--40-FETCH NEXT n ROW ONLY:sadece sıradaki ilk n satırı getirir
--                  LIMIT n:sadece sıradaki ilk n satırı getirir
--                  OFFSET n: n satırı atlayıp sonrakileri getirir

SELECT * 
FROM developers
FETCH NEXT 3 ROW ONLY;


SELECT * 
FROM developers
LIMIT 3;


--developers tablosundan maaşı en düşük ilk 3 kaydı getiriniz.
SELECT *
FROM developers
ORDER BY salary ASC
LIMIT 3;

--developers tablosundan maaşı en yüksek ilk 3 kaydı getiriniz.
SELECT *
FROM developers
ORDER BY salary DESC
LIMIT 3;

--developers tablosundan maaşı en yüksek 2. developerın tüm bilgilerini getiriniz.
SELECT *
FROM developers
ORDER BY salary DESC
OFFSET 1 --atla
LIMIT 1;


--41 ALTER TABLE: Tabloyu güncellemek için kullanılır: DDL Data Defination Language


/*
add column ==> yeni sutun ekler
drop column ==> mevcut olan sutunu siler
rename column.. to.. ==> sutunun ismini degistirir      
rename.. to.. ==> tablonun ismini degistirir
*/


--calisanlar3 tablosuna yas (int) seklinde yeni sutun ekleyiniz.
ALTER TABLE calisanlar3
ADD COLUMN yas INT


--calisanlar3 tablosuna remote (boolean) seklinde yeni sutun ekleyiniz.
--varsayılan olarak remote değeri TRUE olsun
ALTER TABLE calisanlar3
ADD COLUMN remote BOOLEAN DEFAULT TRUE

--calisanlar3 tablosunda yas sutununu siliniz.
ALTER TABLE calisanlar3
DROP COLUMN yas

--calisanlar3 tablosundaki maas sutununun data tipini real olarak güncelleyiniz.
ALTER TABLE calisanlar3
ALTER COLUMN maas TYPE REAL

--calisanlar3 tablosunun ismini employees olarak güncelleyiniz.
ALTER TABLE calisanlar3
RENAME TO employees

--calisanlar3 tablosundaki maas sutununun ismini gelir olarak güncelleyiniz.
ALTER TABLE calisanlar3
RENAME COLUMN maas TO gelir

--employees tablosunda id sütunun data tipini varchar(20) olarak güncelleyiniz.
ALTER TABLE employees
ALTER COLUMN id TYPE VARCHAR(20)

ALTER TABLE employees
ALTER COLUMN id TYPE INT USING id::INT --başta hata verdi, sonra bu using id kısmını verdi sorumluluk sendeyse yap dedi.


--employees tablosunda isim sütununa NOT NULL constrainti ekleyiniz.
ALTER TABLE employees
ALTER COLUMN isim SET NOT NULL --Null varsa içerisinde, bu kod çalışmaz. Hiç biri değilse çalışır.

SELECT * FROM employees;

--NOT:içinde kayıtlar bulunan bir tabloyu güncellerken bir sütuna 
--NOT NULL,PK,FK,UNIQUE vs constraintleri ekleyebilmek için önce
--bu sütunların değerleri ilgili const.  sağlıyor olmalı.


--sirketler tablosunda sirket_id sütununa PRIMARY KEY constrainti ekleyiniz.
ALTER TABLE sirketler 
ADD PRIMARY KEY(sirket_id);

--sirketler tablosunda sirket_isim sütununa UNIQUE constrainti ekleyiniz.
ALTER TABLE sirketler
ADD UNIQUE(sirket_isim);

--siparis tablosunda id sütununa FK constrainti ekleyiniz.
ALTER TABLE siparis
ADD FOREIGN KEY(sirket_id) REFERENCES sirketler(sirket_id);

DELETE FROM siparis WHERE sirket_id IN(104,105) --karşılığı olmayan kayıtları sildik ki hata vermesin.

-- siparis tablosundaki FK constraintini kaldırınız.
ALTER TABLE siparis
DROP CONSTRAINT siparis_sirket_id_fkey


--employees tablosunda isim sütununa NOT NULL constraintini kaldırınız.
ALTER TABLE employees
ALTER COLUMN isim DROP NOT NULL

SELECT * FROM siparis;

-- 42 TRANSACTION: Data Base'deki en küçük işlem birimidir. 
--		BEGIN: Transaction'ı başlatır.
--		COMMIT: Transaction'ı onaylar ve sonlandırır.
--		SAVEPOINT: Kayıt noktası oluşturur.
--		ROLLBACK: Yapılan değişiklikleri geriye döndürür ve sonlandırır.


CREATE TABLE hesaplar
(
hesap_no int UNIQUE,
isim VARCHAR(50),
bakiye real       
);

INSERT INTO hesaplar VALUES(1234,'Harry Potter',10000.3);
INSERT INTO hesaplar VALUES(5678,'Jack Sparrow',5000.5);


SELECT * FROM hesaplar;


UPDATE hesaplar SET bakiye=bakiye-1000 WHERE hesap_no=1234;
--sistemde hata oluştu
UPDATE hesaplar SET bakiye=bakiye+1000 WHERE hesap_no=5678;
--veriler tutarsız

SELECT * FROM hesaplar;

-------------------------------------------------

BEGIN;
CREATE TABLE hesaplar
(
hesap_no int UNIQUE,
isim VARCHAR(50),
bakiye real       
);
COMMIT;

BEGIN;
INSERT INTO hesaplar VALUES(1234,'Harry Potter',10000.3);
INSERT INTO hesaplar VALUES(5678,'Jack Sparrow',5000.5);

SAVEPOINT x;

SELECT * FROM hesaplar;

--try{
UPDATE hesaplar SET bakiye=bakiye-1000 WHERE hesap_no=1234;

--sistemde hata oluştu, catch bloğundan devam

UPDATE hesaplar SET bakiye=bakiye+1000 WHERE hesap_no=5678;--bu işlem başarısız
--veriler tutarsız

COMMIT;
--}catch(hata){
ROLLBACK TO x;
--}

-----------------------------------pozitif senaryo
--try{
UPDATE hesaplar SET bakiye=bakiye-1000 WHERE hesap_no=1234;--başarılı

UPDATE hesaplar SET bakiye=bakiye+1000 WHERE hesap_no=5678;--başarılı

COMMIT;

--}catch(hata){
ROLLBACK TO x;
--}

SELECT * FROM hesaplar;









