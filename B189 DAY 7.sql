--------------DAY'7---------------------
--JOINS--BİRLEŞTİRME
--JOIN:ilişkili tablolarda ortak bir sütun baz alınarak(tipik olarak PK ve FK)
--bir veya daha fazla tablodaki sütunların birleştirilmesini sağlar.


CREATE TABLE sirketler  (
sirket_id int,  
sirket_isim varchar(20)
);
INSERT INTO sirketler VALUES(100, 'IBM');
INSERT INTO sirketler VALUES(101, 'GOOGLE');
INSERT INTO sirketler VALUES(102, 'MICROSOFT');
INSERT INTO sirketler VALUES(103, 'APPLE');

CREATE TABLE siparis (
siparis_id int,
sirket_id int,
siparis_tarihi date
);
INSERT INTO siparis VALUES(11, 101, '2023-02-17');  
INSERT INTO siparis VALUES(22, 102, ' 2023-02-18');  
INSERT INTO siparis VALUES(33, 103, ' 2023-01-19');  
INSERT INTO siparis VALUES(44, 104, ' 2023-01-20');  
INSERT INTO siparis VALUES(55, 105, ' 2022-12-21');


SELECT * FROM sirketler;
SELECT * FROM siparis;



--33-INNER JOIN:baz aldığımız sütundaki sadece ortak değerleri gösterir.

--SORU: iki tablodaki şirket id'si aynı olanların şirket id,şirket ismi,
--sipariş tarihini,sipariş idsini  listeleyiniz.

SELECT sirketler.sirket_id,sirket_isim,siparis_id,siparis_tarihi
FROM sirketler INNER JOIN siparis
ON sirketler.sirket_id=siparis.sirket_id
--NOT: INNER JOIN ortak kayıtları birleştirdiği için tablo sırası önemli olmaz.


--34-LEFT JOIN:Sol tablodaki(ilk tablodaki) tüm verileri getirir.
   --RIGHT JOIN:Sağ tablodaki(ikinci tablodaki) tüm verileri getirir.

--SORU: şirketler tablosundaki tüm kayıtların şirrket id, şirket ismi, sipariş tarihini, sipariş idsini listeleyiniz.
SELECT sirketler.sirket_id,sirket_isim,siparis_id,siparis_tarihi
FROM sirketler LEFT JOIN siparis
ON sirketler.sirket_id=siparis.sirket_id

--SORU: sipariş tablosundaki tüm kayıtların şirket id, şirket ismi, sipariş tarihini, sipariş idsini listeleyiniz.
SELECT sirketler.sirket_id,sirket_isim,siparis_id,siparis_tarihi
FROM sirketler RIGHT JOIN siparis
ON sirketler.sirket_id=siparis.sirket_id

--NOT: LEFT VE RIGHT JOIN'I tablo sırasını değiştirerek alternatif olarak kullanabiliriz.

   
--35-FULL JOIN:iki tablodaki baz alınan sütundaki tüm kayıtları getirir.

--her iki tablodaki tüm kayıtların tüm bilgilerini listeleyiniz.

SELECT *
FROM sirketler FULL JOIN siparis
ON sirketler.sirket_id=siparis.sirket_id



--36-SELF JOIN : tablonun kendi içindeki bir sütunu baz alarak INNER JOIN yapılmasını sağlar. 


CREATE TABLE personeller  (
id int,
isim varchar(20),  
title varchar(60), 
yonetici_id int
);
INSERT INTO personeller VALUES(1, 'Ali Can', 'SDET',     2);
INSERT INTO personeller VALUES(2, 'Veli Cem', 'QA',      3);
INSERT INTO personeller VALUES(3, 'Ayse Gul', 'QA Lead', 4);  
INSERT INTO personeller VALUES(4, 'Fatma Can', 'CEO',    null);

SELECT * FROM personeller;

--her bir personelin ismi ile birlikte yöneticisinin ismini de veren bir sorgu oluşturunuz.


SELECT p.id,p.isim AS personel,m.id,m.isim AS yonetici
FROM personeller p
INNER JOIN personeller m
ON p.yonetici_id=m.id




--37-LIKE Cond.:WHERE komutu ile kullanılır, 
--Sorgular belirli bir karakter dizisini(desen-pattern) kullanarak filtreleme yapmamızı sağlar
--ILIKE:LIKE gibi ancak CASE INSENSITIVE dir.




CREATE TABLE words
( 
  word_id int UNIQUE,
  word varchar(50) NOT NULL,
  number_of_letters int
);

INSERT INTO words VALUES (1001, 'hot', 3);
INSERT INTO words VALUES (1002, 'hat', 3);
INSERT INTO words VALUES (1003, 'Hit', 3);
INSERT INTO words VALUES (1004, 'hbt', 3);
INSERT INTO words VALUES (1008, 'hct', 3);
INSERT INTO words VALUES (1005, 'adem', 4);
INSERT INTO words VALUES (1006, 'selim', 6);
INSERT INTO words VALUES (1007, 'yusuf', 5);
INSERT INTO words VALUES (1009, 'hAt', 3);
INSERT INTO words VALUES (1010, 'yaf', 5);
INSERT INTO words VALUES (1011, 'ahata', 3);

SELECT * FROM words;

SELECT * FROM developers WHERE name='Enes Can'

--wildcard(%) 0 veya daha fazla karakteri temsil eder. 
SELECT *
FROM developers
WHERE name LIKE 'E%' --E'li bişeyler işte diyoruz.

--a harfi ile biten şehirde çalışan dev isimlerini ve şehirlerini yazdiran QUERY yazin
SELECT name,city
FROM developers
WHERE city LIKE '%a';

--Ismi T ile başlayıp n harfi ile biten dev isimlerini ve maaşlarını yazdiran QUERY yazin
SELECT name,salary
FROM developers
WHERE name LIKE 'T%n';

--Ismi içinde 'an' olan dev isimlerini ve maaşlarını yazdiran QUERY yazin
SELECT *
FROM developers
WHERE name LIKE '%a%' AND name LIKE '%e%';

--al?
--underscore(_): sadece 1 karakteri temsil eder.

--Isminin ikinci harfi ü olan devlerin tum bilgilerini yazdiran QUERY yazin. ('_ü%')
SELECT *
FROM developers
WHERE name LIKE '_ü%'

--Kullandığı prog. dili 4 harfli ve üçüncü harfi v olan devlerin tum bilgilerini yazdiran QUERY yazin
SELECT *
FROM developers
WHERE name LIKE '__v_'


--Kullandığı prog. dili en az 5 harfli ve ilk harfi J olan devlerin tum bilgilerini yazdiran QUERY yazin.ÖDEVVV 'j___%'
--HINT:sadece JavaScript olacak
--Isminin 2. harfi e,4. harfi y olan devlerin tum bilgilerini yazdiran QUERY yazin. ÖDEVV
--ismi boşluk içeren devlerin tum bilgilerini yazdiran QUERY yazin:ÖDEVVVV


--38-REGEXP_LIKE(~): belirli karakter deseni içerek dataları regex kullanarak filtrelememizi sağlar.
--[]: içerisindeki harflerden en az birini temsil eder.

--h harfinden sonra a veya i harfini sonra ise t harfini içeren kelimelerin tum bilgilerini yazdiran QUERY yaziniz.
SELECT *
FROM words
WHERE word ~'h[ai]t' --hat or hit


SELECT *
FROM words
WHERE word ~* 'h[ai]t' --case insensitive oldu. 

--küçük/büyük harf hassasiyeti olmasın istiyorsak asterix de ekleriz.
--[a-h] iki harf arasındaki harfleri alır.

SELECT *
FROM words
WHERE word ~* 'h[a-i]t'


-- Icinde m veya i olan kelimelerin tum bilgilerini yazdiran QUERY yazin

SELECT *
FROM words
WHERE word ~*'[m,i]'

-- ^: başlangıcını gösterir
-- $: bitişini gösterir

--a ile baslayan kelimelerin tum bilgilerini yazdiran QUERY yazin
SELECT *
FROM words
WHERE word ~*'^a'

--a veya s ile baslayan kelimelerin tum bilgilerini yazdiran QUERY yazin
SELECT *
FROM words
WHERE word ~*'^[as]'

--m biten kelimelerin tum bilgilerini yazdiran QUERY yazin
SELECT *
FROM words
WHERE word ~*'m$'

-- (.*): --> Wildcard burada da var. 0 veya daha fazla kararkter
-- .: -->1 karakter anlamına gelir. _ yani.

--y ile başlayıp f ile biten kelimelerin tum bilgilerini yazdiran QUERY yazin
SELECT *
FROM words
WHERE word ~*'^y.*f$'


--NOT LIKE: verilen karakter desenine benzemeyenleri filtreler
-- !~     : verilen karakter desinene benzemeyenleri filtreler

--ilk harfi h veya H olmayan kelimelerin tüm bilgileirini yazdıran QUERY yazınız.

SELECT *
FROM words
WHERE word NOT ILIKE 'h%' --ILIKE insensitive

--ilk harfi h veya H olmayan kelimelerin tüm bilgileirini yazdıran QUERY yazınız. REGEX version
SELECT *
FROM words
WHERE word !~* '^h'

--2. harfi e,i veya o olmayan kelimelerin tum bilgilerini yazdiran QUERY yazin.ÖDEV

