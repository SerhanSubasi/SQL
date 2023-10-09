--Yorum satırı
/* Çoklu yorum satırı */

-------------------------DAY 1 DT----------------------------
--1 Database Oluşturma
CREATE DATABASE serhan; --SQL komutlarında küçük/büyük harf duyarlılığı yoktur.
--2 Database Silme
DROP DATABASE serhan;
DROP DATABASE techproed;
--3 Tablo Oluşturma
CREATE TABLE students(
id CHAR(4),
name VARCHAR(20),
grade REAL,
register_date DATE
);
-- 4 Mevcut Bulunan Bir Tablodan Yeni Tablo Oluşturma
CREATE TABLE grades AS SELECT name,grade FROM students;
--5 Tabloya Data Ekleme 
INSERT INTO students VALUES('1001', 'Sherlock Holmes',99.5,'2023-10-04');
INSERT INTO students VALUES('1002', 'Frodo Baggins', 99.9, now());
--6 Tablodaki Tüm Dataları Görüntüleme
SELECT * FROM students;
--7 Tablonun Belirli Sütunlarına Data Ekleme
INSERT INTO students(name,grade) VALUES('Harry Potter',88.8);
--8 Tablodaki tüm kayıtların sadece belirli sütunlarını görüntüleme
SELECT name,grade FROM students;

--practice
--tabloyu silelim
--4. query'i tekrar çalıştıralım
SELECT * FROM grades;

/*------------------------------------
ÖDEVV:)
1) Tablo Oluşturma

"tedarikciler" isminde bir tablo olusturun,
"tedarikci_id", "tedarikci_ismi", "tedarikci_adres"
ve "ulasim_tarihi"	field'lari olsun. 

2) Var olan tablodan yeni tablo olusturmak 
 "tedarikci_info" isminde bir tabloyu  "tedarikciler" tablosundan olusturun.
Icinde "tedarikci_ismi", "ulasim_tarihi" field'lari olsun

3) Data ekleme
" ogretmenler" isminde tablo olusturun.
 Icinde "kimlik_no", "isim", "brans" ve "cinsiyet" field'lari olsun.
"ogretmenler" tablosuna bilgileri asagidaki gibi olan kisileri ekleyin.
kimlik_no: 234431223, isim: Ayse Guler, brans : Matematik, cinsiyet: kadin.
kimlik_no: 234431224, isim: Ali Guler, brans : Fizik, cinsiyet: erkek.

4) bazı fieldları olan kayıt ekleme
"ogretmenler" tablosuna bilgileri asagidaki gibi olan bir kisi ekleyin.
kimlik_no: 567597624, isim: Veli Guler
-------------------------------------*/


