A feladatok megoldására elkészített SQL parancsokat illessze be a feladat sorszáma után!


1. feladat:

CREATE DATABASE teke
CHAR SET utf-8
COLLATE utf8_hungarian_ci

3. feladat:

SELECT `versenyzok`.`nev`
FROM `versenyzok`
WHERE (`versenyzok`.`korcsop` like "A")
ORDER BY `versenyzok`.`nev` ASC

4. feladat:

SELECT `versenyzok`.`rajtszam`
FROM `versenyzok`
    INNER JOIN `eredmenyek` ON `eredmenyek`.`versenyzo` = `versenyzok`.`rajtszam`
WHERE eredmenyek.ures > 0
GROUP BY `versenyzok`.`rajtszam`;

5. feladat:

SELECT `versenyzok`.`nev`, AVG(`eredmenyek`.`tarolas`) as atlagpont
FROM `versenyzok`
    INNER JOIN `eredmenyek` ON `eredmenyek`.`versenyzo` = `versenyzok`.`rajtszam`
GROUP BY versenyzok.nev
ORDER BY atlagpont DESC;

6. feladat:

SELECT `egyesuletek`.`nev`
FROM `egyesuletek`
    INNER JOIN `versenyzok` ON `versenyzok`.`egyid` = `egyesuletek`.`id`
GROUP BY `egyesuletek`.`nev`
ORDER BY COUNT(`versenyzok`.`rajtszam`) DESC
LIMIT 1;

7. feladat:

SELECT `versenyzok`.`nev` , SUM(eredmenyek.teli)+SUM(eredmenyek.tarolas) as eredmeny, SUM(`eredmenyek`.`tarolas`) as tarolas , SUM(`eredmenyek`.`ures`) as ures
FROM `versenyzok`
    INNER JOIN `eredmenyek` ON `eredmenyek`.`versenyzo` = `versenyzok`.`rajtszam`
WHERE versenyzok.korcsop LIKE "B"
GROUP BY `versenyzok`.`nev`
ORDER BY eredmeny DESC, eredmenyek.tarolas DESC, eredmenyek.ures ASC;