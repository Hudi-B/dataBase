A feladatok megoldására elkészített SQL parancsokat illessze be a feladat sorszáma után!

1. feladat:

CREATE DATABASE papirgyujtes
CHAR SET utf8
COLLATE utf8_hungarian_ci

3. feladat:

SELECT `tanulok`.`nev`, `tanulok`.`osztaly`, `leadasok`.`idopont`, `leadasok`.`mennyiseg`
FROM `tanulok`
    INNER JOIN `leadasok` ON `leadasok`.`tanulo` = `tanulok`.`tazon`
WHERE (`tanulok`.`osztaly` LIKE "1%");

4. feladat:

SELECT `leadasok`.`idopont`, AVG(`leadasok`.`mennyiseg`) as "napi atlag"
FROM `leadasok`
GROUP BY 1;

5. feladat:

SELECT `tanulok`.`osztaly`
FROM `tanulok`
    LEFT JOIN `leadasok` ON `leadasok`.`tanulo` = `tanulok`.`tazon`
WHERE (`leadasok`.`idopont` LIKE "2016-10-28")
GROUP BY 1;

6. feladat:

SELECT `tanulok`.`osztaly`, SUM(`leadasok`.`mennyiseg`) / 10000 as "mazsa"
FROM `tanulok`
    INNER JOIN `leadasok` ON `leadasok`.`tanulo` = `tanulok`.`tazon`
GROUP BY 1
ORDER BY 2 DESC;

7. feladat:

SELECT `tanulok`.`nev`, `tanulok`.`osztaly`, SUM(`leadasok`.`mennyiseg`) AS "osszesen"
FROM `tanulok`
    INNER JOIN `leadasok` ON `leadasok`.`tanulo` = `tanulok`.`tazon`
GROUP BY 1
ORDER BY 3 DESC;

