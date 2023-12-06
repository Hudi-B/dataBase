-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2023. Nov 21. 08:53
-- Kiszolgáló verziója: 10.4.28-MariaDB
-- PHP verzió: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `kekosztriga`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `csoport`
--

CREATE TABLE `csoport` (
  `nev` varchar(50) NOT NULL,
  `nemzetiseg` varchar(25) NOT NULL,
  `pontszam` int(11) NOT NULL,
  `atlag_eletkor` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `tanc`
--

CREATE TABLE `tanc` (
  `tanc_neve` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `tancol`
--

CREATE TABLE `tancol` (
  `csoportid` varchar(25) NOT NULL,
  `zeneid` varchar(25) NOT NULL,
  `tancid` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `zene`
--

CREATE TABLE `zene` (
  `mufaj` varchar(15) NOT NULL,
  `cim` varchar(30) NOT NULL,
  `eloado` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `csoport`
--
ALTER TABLE `csoport`
  ADD PRIMARY KEY (`nemzetiseg`);

--
-- A tábla indexei `tanc`
--
ALTER TABLE `tanc`
  ADD PRIMARY KEY (`tanc_neve`);

--
-- A tábla indexei `tancol`
--
ALTER TABLE `tancol`
  ADD PRIMARY KEY (`csoportid`,`zeneid`,`tancid`),
  ADD KEY `tancid` (`tancid`),
  ADD KEY `zeneid` (`zeneid`);

--
-- A tábla indexei `zene`
--
ALTER TABLE `zene`
  ADD PRIMARY KEY (`cim`);

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `tancol`
--
ALTER TABLE `tancol`
  ADD CONSTRAINT `tancol_ibfk_1` FOREIGN KEY (`csoportid`) REFERENCES `csoport` (`nemzetiseg`),
  ADD CONSTRAINT `tancol_ibfk_2` FOREIGN KEY (`tancid`) REFERENCES `tanc` (`tanc_neve`),
  ADD CONSTRAINT `tancol_ibfk_3` FOREIGN KEY (`zeneid`) REFERENCES `zene` (`cim`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
