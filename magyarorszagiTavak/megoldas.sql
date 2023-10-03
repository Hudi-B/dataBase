--1.

CREATE DATABASE tavak
DEFAULT CHARACTER SET utf8
COLLATE utf8_hungarian_ci;

CREATE TABLE IF NOT EXISTS `tavak`.`helykapcs` (`allovizid` int(3), `gpsid` int(4)) 
DEFAULT CHARACTER SET utf8 
COLLATE utf8_general_ci;
ALTER TABLE `helykapcs` 
ADD PRIMARY KEY(`allovizid`, `gpsid`);

CREATE TABLE IF NOT EXISTS `tavak`.`alloviz` (`id` int(3), `nev` varchar(89), `tipus` varchar(11), `terulet` varchar(6), `vizgyujto` varchar(5)) 
DEFAULT CHARACTER SET utf8 
COLLATE utf8_general_ci;
ALTER TABLE `alloviz` 
ADD PRIMARY KEY(`id`);

CREATE TABLE IF NOT EXISTS `tavak`.`telepulesgps` (`id` int(4), `nev` varchar(20), `hosszusag` varchar(7), `szelesseg` varchar(7)) 
DEFAULT CHARACTER SET utf8 
COLLATE utf8_general_ci;
ALTER TABLE `telepulesgps` 
ADD PRIMARY KEY(`id`);

ALTER TABLE alloviz
ADD FOREIGN KEY (id) REFERENCES helykapcs(allovizid);
ALTER TABLE telepulesgps
ADD FOREIGN KEY (id) REFERENCES helykapcs(gpsid);

UPDATE alloviz
SET terulet = REPLACE(terulet, ',', '.')
ALTER TABLE `alloviz` CHANGE `terulet` `terulet` FLOAT(6) NULL DEFAULT NULL;

--2

SELECT `alloviz`.`tipus`, `alloviz`.`nev`, `alloviz`.`terulet`
FROM `alloviz`
WHERE (`alloviz`.`tipus` LIKE '%morotva%')
ORDER BY 3 DESC;

--3

SELECT SUM(`alloviz`.`terulet`) / 93036 AS 'vizarany'
FROM `alloviz`;

--4

SELECT `alloviz`.`nev`, `alloviz`.`tipus`, `alloviz`.`terulet`
FROM `alloviz`
WHERE(`alloviz`.`terulet` BETWEEN 3 AND 10 AND (`alloviz`.`vizgyujto` / 10) > `alloviz`.`terulet`);

--5

SELECT `alloviz`.`nev`, `telepulesgps`.`id`
FROM `telepulesgps`
    INNER JOIN `helykapcs` ON `helykapcs`.`gpsid` = `telepulesgps`.`id`
    INNER JOIN `alloviz` ON `helykapcs`.`allovizid` = `alloviz`.`id`
GROUP BY 1
HAVING(COUNT(`telepulesgps`.`id`) >= 3);

--6

SELECT `alloviz`.`nev`
FROM `telepulesgps`
    INNER JOIN `helykapcs` ON `helykapcs`.`gpsid` = `telepulesgps`.`id`
    INNER JOIN `alloviz` ON `helykapcs`.`allovizid` = `alloviz`.`id`
GROUP BY 1
ORDER BY (MAX(`telepulesgps`.`hosszusag`)-MIN(`telepulesgps`.`szelesseg`)) DESC
LIMIT 1;