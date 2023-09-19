A feladatok megoldására elkészített SQL parancsokat illeszd be a feladat sorszáma után!

1. feladat:

CREATE DATABASE mvk
CHAR SET utf8
COLLATE utf8_hungarian_ci;

3. feladat:

SELECT `viszonylatadatok`.`viszonylatazon`, `viszonylatok`.`irveg`, `viszonylatok`.`kulsoveg`, `viszonylatok`.`fordtav`
FROM `viszonylatok`
    INNER JOIN `viszonylatadatok` ON `viszonylatadatok`.`viszonylatazon` = `viszonylatok`.`viszonylatjelzes`
WHERE (`viszonylatadatok`.`viszonylatazon` like 53);

4. feladat:

DELETE FROM viszonylatadatok WHERE `viszonylatadatok`.`viszonylatazon` = '430'
DELETE FROM viszonylatok WHERE `viszonylatok`.`viszonylatjelzes` = '430';

5. feladat:

SELECT `viszonylatok`.`viszonylatjelzes`, `viszonylatok`.`kulsoveg`
FROM `viszonylatok`
WHERE (`viszonylatok`.`irveg` like 'Búza tér')
GROUP BY 1
ORDER BY 1 ASC;


6. feladat:

SELECT `viszonylatok`.`viszonylatjelzes`, `viszonylatok`.`irveg`, `viszonylatok`.`kulsoveg`
FROM `viszonylatok`
    LEFT JOIN `viszonylatadatok` ON `viszonylatadatok`.`viszonylatazon` = `viszonylatok`.`viszonylatjelzes`
WHERE (`viszonylatadatok`.`jszamnyar` LIKE 0)
GROUP BY 1
ORDER BY 1 ASC;


7. feladat:

SELECT COUNT(`viszonylatok`.`irveg`) as 'Búza tér'
FROM `viszonylatok`
WHERE (`viszonylatok`.`irveg` LIKE 'Búza tér');

8. feladat:

SELECT `viszonylatok`.`fordtav`, `viszonylatok`.`viszonylatjelzes`, `viszonylatok`.`irveg`, `viszonylatok`.`kulsoveg`
FROM `viszonylatok`
ORDER BY 1 DESC
LIMIT 1;

9. feladat:

SELECT `viszonylatok`.`viszonylatjelzes` as 'husszú vonalak'
FROM `viszonylatok`
WHERE (`viszonylatok`.`fordtav` > 20)
GROUP BY 1;

10. feladat:

SELECT SUM(`utasszamok`.`utasszam`) as 'összutasszam'
FROM `utasszamok`


11. feladat:

SELECT `viszonylatok`.`viszonylatjelzes`, `viszonylatadatok`.`jszamtel` * `viszonylatok`.`fordtav` as 'kocsikm_35'
FROM `viszonylatok`
    INNER JOIN `viszonylatadatok` ON `viszonylatadatok`.`viszonylatazon` = `viszonylatok`.`viszonylatjelzes`
WHERE (`viszonylatok`.`viszonylatjelzes` LIKE '35');

12. feladat:

SELECT `viszonylatok`.`viszonylatjelzes`
FROM `viszonylatok`
    INNER JOIN `utasszamok` ON `utasszamok`.`viszonylatazon` = `viszonylatok`.`viszonylatjelzes`
WHERE (utasszamok.utasszam > (SELECT AVG(utasszamok.utasszam) FROM utasszamok));

13. feladat:

SELECT `viszonylatok`.`viszonylatjelzes`, IF(viszonylatadatok.elsojarat>viszonylatadatok.utolsojarat, ADDTIME(viszonylatadatok.utolsojarat, "24:00:00"), TIMEDIFF(viszonylatadatok.utolsojarat, viszonylatadatok.elsojarat)) AS 'uzemido'
FROM `viszonylatok`
    INNER JOIN `viszonylatadatok` ON `viszonylatadatok`.`viszonylatazon` = `viszonylatok`.`viszonylatjelzes`;

14. feladat:

COUNT(CASE WHEN viszonylatadatok.jszamtel>viszonylatadatok.jszamnyar OR viszonylatadatok.jszamtel>viszonylatadatok.jszamnyar THEN 1 ELSE 0 END)

15. feladat:









