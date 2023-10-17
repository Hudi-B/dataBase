--1.

SELECT `bank`.`vezeteknev`, `bank`.`keresztnev`
FROM `bank`
WHERE bank.egyenleg < (SELECT AVG(`bank`.`egyenleg`) FROM `bank`);

--2

SELECT `bank`.`vezeteknev`, `bank`.`keresztnev`
FROM `bank`
WHERE `bank`.`egyenleg` > (SELECT MAX(`bank`.`egyenleg`) FROM `bank` WHERE `bank`.`varos` LIKE "Veszprém");

--3

SELECT `bank`.`vezeteknev`, `bank`.`keresztnev`, `bank`.`szamlaszam`
FROM `bank`
WHERE NOT EXISTS(SELECT `utalo_fel_szamlaszama` FROM `auto` WHERE `bank`.`szamlaszam` = `auto`.`utalo_fel_szamlaszama`);

--4

SELECT *
FROM `bank`
WHERE(SELECT `auto`.`ajtok_szama` FROM `auto` WHERE( `bank`.`szamlaszam` LIKE `auto`.`utalo_fel_szamlaszama` AND `auto`.`ajtok_szama` NOT LIKE 2));

--5

SELECT *
FROM `bank`
WHERE(SELECT * FROM `auto` WHERE DATEDIFF(year, eladas_datuma, gyartas_datuma) LIKE 1)