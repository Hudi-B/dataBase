A feladatok megoldására elkészített SQL parancsokat illessze be a feladat sorszáma után!

1. feladat:

CREATE DATABASE[IF NOT EXIST] ostermelo
DEFAULT CHAR SET utf-8
COLLATE utf8_hungarian_ci;

3. feladat:

SELECT `partnerek`.`telepules`
FROM `partnerek`
GROUP BY `partnerek`.`telepules`
ORDER BY `partnerek`.`telepules` ASC;

4. feladat:

SELECT `partnerek`.`telepules`, COUNT(`kiszallitasok`.`sorsz`) as "alkalmak"
FROM `partnerek`
    INNER JOIN `kiszallitasok` ON `kiszallitasok`.`partnerid` = `partnerek`.`id`
WHERE (`partnerek`.`telepules` like "Vác");

5. feladat:

SELECT `kiszallitasok`.`datum`, `kiszallitasok`.`karton` AS "legtobb"
FROM `kiszallitasok`
WHERE (`kiszallitasok`.`datum` like "2016-05%")
ORDER BY `kiszallitasok`.`karton` DESC
LIMIT 1;

6. feladat:

SELECT `partnerek`.`telepules`
FROM `partnerek`
GROUP BY `partnerek`.`telepules`
HAVING(COUNT(`partnerek`.`kontakt`) >= 2);

7. feladat:

SELECT `gyumolcslevek`.`gynev` AS "ital", SUM(`kiszallitasok`.`karton`) * 6 AS "doboz"
FROM `gyumolcslevek`
    INNER JOIN `kiszallitasok` ON `kiszallitasok`.`gyumleid` = `gyumolcslevek`.`id`
GROUP BY `kiszallitasok`.`gyumleid`
ORDER BY doboz DESC
LIMIT 3;