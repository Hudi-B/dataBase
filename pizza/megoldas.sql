--1.
--Mi Szundi kedvenc pizzája?

SELECT p.pnev AS kedvenc_pizza
FROM vevo AS v
	JOIN rendeles AS r ON v.vazon = r.vazon
	JOIN tetel AS t ON r.razon = t.razon
	JOIN pizza AS p ON t.pazon = p.pazon
	WHERE v.vnev = 'Szundi'
	LIMIT 1;

--2
--Mely pizzák olcsóbbak a Capricciosa pizzánál?

SELECT p.pnev AS pizza_nev, p.par AS pizza_ar
FROM pizza AS p
	WHERE p.par < (SELECT par FROM pizza WHERE pnev = 'Capricciosa');

--3
--Mely pizzák drágábbak az átlagosnál?

SELECT pnev AS pizza_nev, par AS pizza_ar
FROM pizza
	WHERE par > (SELECT AVG(par) FROM pizza);

--4
--Mely pizza ára van legközelebb az átlagárhoz?

SELECT pnev AS pizza_nev, par AS pizza_ar
FROM pizza
	ORDER BY ABS(par - (SELECT AVG(par) FROM pizza))
	LIMIT 1;

--5
--Kik rendeltek legalább 5 Hawaii pizzát?

SELECT v.vnev AS vevo
FROM vevo AS v
	JOIN rendeles AS r ON v.vazon = r.vazon
	JOIN tetel AS t ON r.razon = t.razon
	JOIN pizza AS p ON t.pazon = p.pazon
	WHERE p.pnev = 'Hawaii'
	GROUP BY v.vnev
	HAVING SUM(t.db) >= 5;

--6
--Milyen pizzából nem rendelt soha Tudor?

SELECT pnev AS pizza_nev
FROM pizza
WHERE pnev NOT IN (
    SELECT DISTINCT p.pnev
    FROM vevo AS v
    JOIN rendeles AS r ON v.vazon = r.vazon
    JOIN tetel AS t ON r.razon = t.razon
    JOIN pizza AS p ON t.pazon = p.pazon
    WHERE v.vnev = 'Tudor'
);

--7
--Van-e olyan pizza, amelyből soha nem rendeltek?

SELECT p.pnev AS pizza_nev
FROM pizza AS p
	JOIN tetel AS t ON p.pazon = t.pazon
	WHERE t.pazon IS NULL;

--8
--Ki nem rendelt soha Vesuvio pizzát?

SELECT v.vnev AS vevo
FROM vevo AS v
WHERE v.vazon NOT IN (
    SELECT DISTINCT v.vazon
    FROM vevo AS v
    JOIN rendeles AS r ON v.vazon = r.vazon
    JOIN tetel AS t ON r.razon = t.razon
    JOIN pizza AS p ON t.pazon = p.pazon
    WHERE p.pnev = 'Vesuvio'
);