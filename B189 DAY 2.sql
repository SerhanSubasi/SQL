--------------DAY 2 DT---------------
---------TEKRAR---------------
CREATE TABLE sairler(
id int,
name varchar(50),
email varchar(50) 
);

insert into sairler values(1001,'Can Yücel','sair@gmail.com');
insert into sairler values (1001,'Didem Madak','sair@email.com');
insert into sairler values (1002,'','sair@email.com');
insert into sairler(name) values ('Necip Fazıl');

Select * from sairler;
--------------------------------------------------

-- 9 Tabloya Unique Constraint Ekleme
create table it_persons(
id serial,
name varchar(50),
email varchar(50) unique,
salary real,
programming_language varchar(20)
);

insert into it_persons(name,email,salary,programming_language) values('Safa Gök','qa@mail.com',15000,'Java');
insert into it_persons(name,email,salary,programming_language) values('Yusuf Arslan','qa2@mail.com',15000,'Java');
insert into it_persons(email,salary,programming_language) values('qa3@mail.com',15000,'Java');

select * from it_persons;

--10 Tabloya Nut Null Constrainti Ekleme
create table doctors(
id serial,
name varchar(50) not null,
email varchar(50) unique,
salary real
);

select * from doctors;

insert into doctors(name,email,salary) values('Dr. Gregory House', 'dr@email.com',8000);
insert into doctors(email,salary) values('doctor@email.com',8000);--Hata null olamaz
insert into doctors(name,email,salary) values('','doctor@email.com',8000);


--11 Tabloya Primary Key(PK) Constraiti Ekleme
create table students2 (
id int primary key,	--Not null, unique, başka bir tablo ile ilişkilendirmek için kullanılacak.
name varchar(50),
grade real,
register_date date
);

select * from students2;

--11 Tabloya Primary Key(PK) Constraiti Ekleme 2.YÖNTEM
create table students3 (
id int,	--Not null, unique, başka bir tablo ile ilişkilendirmek için kullanılacak.
name varchar(50),
grade real,
register_date date,
Constraint std_pk primary key(id)	--kendimiz isimlendirmek istersek ve composite yapmak istersek böyle yaparız.
);

select * from students3;

--Composite Key
create table students4 (
id int,	
name varchar(50),
grade real,
register_date date,
Constraint std4_pk primary key(id,name)	
);
select * from students4;

--12 Tabloya Foreign Key (FK) Constraiti Ekleme

create table address3(
address_id int,
street varchar(50),
city varchar(50),
student_id int, --FK, null kabul eder, duplicate kabul eder.
constraint add_fk FOREIGN KEY(student_id) references students3(id)
);

--13 Tabloya Check constraintini Ekleme

create table personel(
id int,
name varchar(50),
salary real not null check(salary>5000),
age int CHECK(age>0 AND age<50) --negatif kabul etmez
);

insert into personel values(11,'Ali Can',2000,35); --salary_check
insert into personel values(11,'Ali Can',7000,55); -- age check
insert into personel values(11,'Ali Can',7000,25);

select * from personel;





