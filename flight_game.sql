-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.9.3-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for flight_game
CREATE DATABASE IF NOT EXISTS `flight_game` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `flight_game`;

-- Dumping structure for table flight_game.airport
CREATE TABLE IF NOT EXISTS `airport` (
  `id` int(11) DEFAULT NULL,
  `ident` varchar(200) NOT NULL,
  `type` varchar(200) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `latitude_deg` double DEFAULT NULL,
  `longitude_deg` double DEFAULT NULL,
  `elevation_ft` int(11) DEFAULT NULL,
  `continent` varchar(200) DEFAULT NULL,
  `iso_country` varchar(200) DEFAULT NULL,
  `iso_region` varchar(200) DEFAULT NULL,
  `municipality` varchar(200) DEFAULT NULL,
  `scheduled_service` varchar(200) DEFAULT NULL,
  `gps_code` varchar(200) DEFAULT NULL,
  `iata_code` varchar(200) DEFAULT NULL,
  `local_code` varchar(200) DEFAULT NULL,
  `home_link` varchar(200) DEFAULT NULL,
  `wikipedia_link` varchar(200) DEFAULT NULL,
  `keywords` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`ident`),
  KEY `iso_country` (`iso_country`) USING BTREE,
  CONSTRAINT `airport_ibfk_1` FOREIGN KEY (`iso_country`) REFERENCES `country` (`iso_country`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table flight_game.airport: ~50 rows (approximately)
/*!40000 ALTER TABLE `airport` DISABLE KEYS */;
INSERT INTO `airport` (`id`, `ident`, `type`, `name`, `latitude_deg`, `longitude_deg`, `elevation_ft`, `continent`, `iso_country`, `iso_region`, `municipality`, `scheduled_service`, `gps_code`, `iata_code`, `local_code`, `home_link`, `wikipedia_link`, `keywords`) VALUES
	(41841, 'AD-ALV', 'heliport', 'Andorra la Vella  Heliport', 42.511228, 1.533651, 3450, 'EU', 'AD', 'AD-08', 'Escaldes-Engordany', 'no', '', 'ALV', '', '', 'http://pl.wikipedia.org/wiki/Heliport_Andorra_la_Vella', ''),
	(125, 'BIRK', 'medium_airport', 'Reykjavik Airport', 64.1299972534, -21.9405994415, 48, 'EU', 'IS', 'IS-1', 'Reykjavik', 'yes', 'BIRK', 'RKV', '', '', 'https://en.wikipedia.org/wiki/Reykjav%C3%ADk_Airport', 'REK'),
	(4614, 'BKPR', 'medium_airport', 'Prishtina Adem Jashari International Airport', 42.5728, 21.035801, 1789, 'EU', 'XK', 'XK-01', 'Prishtina', 'yes', 'BKPR', 'PRN', '', 'http://www.airportpristina.com/', 'https://en.wikipedia.org/wiki/Pristina_International_Airport', 'LYPR, Pristina, Slatina Air Base'),
	(2155, 'EBBR', 'large_airport', 'Brussels Airport', 50.901401519800004, 4.48443984985, 184, 'EU', 'BE', 'BE-BRU', 'Brussels', 'yes', 'EBBR', 'BRU', '', 'http://www.brusselsairport.be/en/', 'https://en.wikipedia.org/wiki/Brussels_Airport', ''),
	(301881, 'EDDB', 'large_airport', 'Berlin Brandenburg Airport', 52.351389, 13.493889, 157, 'EU', 'DE', 'DE-BR', 'Berlin', 'yes', 'EDDB', 'BER', '', 'https://ber.berlin-airport.de/', 'https://en.wikipedia.org/wiki/Berlin_Brandenburg_Airport', ''),
	(2301, 'EETN', 'large_airport', 'Lennart Meri Tallinn Airport', 59.41329956049999, 24.832799911499997, 131, 'EU', 'EE', 'EE-37', 'Tallinn', 'yes', 'EETN', 'TLL', '', 'http://www.tallinn-airport.ee/eng', 'https://en.wikipedia.org/wiki/Tallinn_Airport', ''),
	(2307, 'EFHK', 'large_airport', 'Helsinki Vantaa Airport', 60.3172, 24.963301, 179, 'EU', 'FI', 'FI-18', 'Helsinki', 'yes', 'EFHK', 'HEL', '', 'http://www.finavia.fi/en/helsinki-airport', 'https://en.wikipedia.org/wiki/Helsinki_Airport', ''),
	(2425, 'EGJB', 'medium_airport', 'Guernsey Airport', 49.435001, -2.60197, 336, 'EU', 'GG', 'GG-U-A', 'Saint Peter Port', 'yes', 'EGJB', 'GCI', '', '', 'https://en.wikipedia.org/wiki/Guernsey_Airport', 'Channel Islands'),
	(2426, 'EGJJ', 'medium_airport', 'Jersey Airport', 49.20790100097656, -2.195509910583496, 277, 'EU', 'JE', 'JE-U-A', 'Saint Helier', 'yes', 'EGJJ', 'JER', '', 'http://www.jerseyairport.com/', 'https://en.wikipedia.org/wiki/Jersey_Airport', 'Channel Islands'),
	(2434, 'EGLL', 'large_airport', 'London Heathrow Airport', 51.4706, -0.461941, 83, 'EU', 'GB', 'GB-ENG', 'London', 'yes', 'EGLL', 'LHR', '', 'http://www.heathrowairport.com/', 'https://en.wikipedia.org/wiki/Heathrow_Airport', 'LON, Londres'),
	(2447, 'EGNS', 'medium_airport', 'Isle of Man Airport', 54.08330154418945, -4.623889923095703, 52, 'EU', 'IM', 'IM-U-A', 'Castletown', 'yes', 'EGNS', 'IOM', '', 'http://www.iom-airport.com/', 'https://en.wikipedia.org/wiki/Isle_of_Man_Airport', 'Ronaldsway, Douglas'),
	(2513, 'EHAM', 'large_airport', 'Amsterdam Airport Schiphol', 52.308601, 4.76389, -11, 'EU', 'NL', 'NL-NH', 'Amsterdam', 'yes', 'EHAM', 'AMS', '', 'http://www.schiphol.nl/', 'https://en.wikipedia.org/wiki/Amsterdam_Airport_Schiphol', ''),
	(2533, 'EIDW', 'large_airport', 'Dublin Airport', 53.421299, -6.27007, 242, 'EU', 'IE', 'IE-D', 'Dublin', 'yes', 'EIDW', 'DUB', '', 'http://www.dublinairport.com/', 'https://en.wikipedia.org/wiki/Dublin_Airport', 'Aerfort Bhaile Ãtha Cliath'),
	(2542, 'EKCH', 'large_airport', 'Copenhagen Kastrup Airport', 55.617900848389, 12.656000137329, 17, 'EU', 'DK', 'DK-84', 'Copenhagen', 'yes', 'EKCH', 'CPH', '', 'http://www.cph.dk/en/', 'https://en.wikipedia.org/wiki/Copenhagen_Airport', 'KÃ¸benhavn, MalmÃ¶'),
	(2559, 'EKVG', 'medium_airport', 'Vagar Airport', 62.063599, -7.27722, 280, 'EU', 'FO', 'FO-U-A', 'Vagar', 'yes', 'EKVG', 'FAE', '', 'http://www.floghavn.fo/', 'https://en.wikipedia.org/wiki/V%C3%A1gar_Airport', 'Faroes'),
	(2563, 'ELLX', 'large_airport', 'Luxembourg-Findel International Airport', 49.6233333, 6.2044444, 1234, 'EU', 'LU', 'LU-L', 'Luxembourg', 'yes', 'ELLX', 'LUX', '', 'http://www.lux-airport.lu/en/', 'https://en.wikipedia.org/wiki/Luxembourg-Findel_International_Airport', ''),
	(2578, 'ENGM', 'large_airport', 'Oslo Airport, Gardermoen', 60.193901, 11.1004, 681, 'EU', 'NO', 'NO-30', 'Oslo', 'yes', 'ENGM', 'OSL', '', 'https://avinor.no/en/airport/oslo-airport', 'https://en.wikipedia.org/wiki/Oslo_Airport,_Gardermoen', ''),
	(2637, 'EPWA', 'large_airport', 'Warsaw Chopin Airport', 52.1656990051, 20.967100143399996, 362, 'EU', 'PL', 'PL-MZ', 'Warsaw', 'yes', 'EPWA', 'WAW', '', 'http://www.lotnisko-chopina.pl/?lang=en', 'https://en.wikipedia.org/wiki/Warsaw_Frederic_Chopin_Airport', 'Ok?cie'),
	(2701, 'ESSA', 'large_airport', 'Stockholm-Arlanda Airport', 59.651901245117, 17.918600082397, 137, 'EU', 'SE', 'SE-AB', 'Stockholm', 'yes', 'ESSA', 'ARN', '', 'http://www.swedavia.se/arlanda/', 'https://en.wikipedia.org/wiki/Stockholm-Arlanda_Airport', ''),
	(2758, 'EVRA', 'large_airport', 'Riga International Airport', 56.92359924316406, 23.971099853515625, 36, 'EU', 'LV', 'LV-RIX', 'Riga', 'yes', 'EVRA', 'RIX', '', 'http://www.riga-airport.com/', 'https://en.wikipedia.org/wiki/Riga_International_Airport', ''),
	(2766, 'EYVI', 'large_airport', 'Vilnius International Airport', 54.634102, 25.285801, 648, 'EU', 'LT', 'LT-VL', 'Vilnius', 'yes', 'EYVI', 'VNO', '', 'http://www.vilnius-airport.lt/en/', 'https://en.wikipedia.org/wiki/Vilnius_International_Airport', ''),
	(3972, 'LATI', 'large_airport', 'Tirana International Airport Mother Teresa', 41.4146995544, 19.7206001282, 126, 'EU', 'AL', 'AL-11', 'Tirana', 'yes', 'LATI', 'TIA', '', 'http://www.tirana-airport.com/', 'https://en.wikipedia.org/wiki/Tirana_International_Airport_N%C3%ABn%C3%AB_Tereza', 'Rinas International Airport, Aeroporti NÃ«nÃ« Tereza'),
	(3977, 'LBSF', 'large_airport', 'Sofia Airport', 42.696693420410156, 23.411436080932617, 1742, 'EU', 'BG', 'BG-23', 'Sofia', 'yes', 'LBSF', 'SOF', '', 'http://sofia-airport.bg', 'https://en.wikipedia.org/wiki/Sofia_Airport', ''),
	(3993, 'LDZA', 'large_airport', 'Zagreb Airport', 45.7429008484, 16.0687999725, 353, 'EU', 'HR', 'HR-21', 'Zagreb', 'yes', 'LDZA', 'ZAG', '', '', 'https://en.wikipedia.org/wiki/Zagreb_Airport', 'Pleso'),
	(4019, 'LEMD', 'large_airport', 'Adolfo Suarez Madrid Barajas Airport', 40.471926, -3.56264, 1998, 'EU', 'ES', 'ES-M', 'Madrid', 'yes', 'LEMD', 'MAD', '', 'https://www.aena.es/en/adolfo-suarez-madrid-barajas.html', 'https://en.wikipedia.org/wiki/Adolfo_Su%C3%A1rez_Madrid%E2%80%93Barajas_Airport', 'LeganÃ©s, Madrid Barajas International Airport'),
	(4185, 'LFPG', 'large_airport', 'Charles de Gaulle International Airport', 49.012798, 2.55, 392, 'EU', 'FR', 'FR-IDF', 'Paris', 'yes', 'LFPG', 'CDG', '', 'http://www.aeroportsdeparis.fr/', 'https://en.wikipedia.org/wiki/Charles_de_Gaulle_Airport', 'PAR, AÃ©roport Roissy-Charles de Gaulle, Roissy Airport'),
	(4251, 'LGAV', 'large_airport', 'Athens Eleftherios Venizelos International Airport', 37.936401, 23.9445, 308, 'EU', 'GR', 'GR-A1', 'Athens', 'yes', 'LGAV', 'ATH', '', 'http://www.aia.gr', 'https://en.wikipedia.org/wiki/Athens_International_Airport', ''),
	(4296, 'LHBP', 'large_airport', 'Budapest Liszt Ferenc International Airport', 47.42976, 19.261093, 495, 'EU', 'HU', 'HU-PE', 'Budapest', 'yes', 'LHBP', 'BUD', '', 'http://www.bud.hu/english', 'https://en.wikipedia.org/wiki/Budapest_Ferenc_Liszt_International_Airport', 'Ferihegyi nemzetkÃ¶zi repÃ¼l?tÃ©r, Budapest Liszt Ferenc international Airport'),
	(46548, 'LIKD', 'small_airport', 'Torraccia Airfield', 43.948895, 12.511411, 787, 'EU', 'SM', 'SM-03', 'Domagnano', 'no', 'LIKD', '', 'RSM01', '', 'https://it.wikipedia.org/wiki/Aviosuperficie_ed_elisuperficie_di_Torraccia', 'Torraccia'),
	(4372, 'LIRF', 'large_airport', 'Romea Fiumicino Leonardo da Vinci International Airport', 41.804532, 12.251998, 13, 'EU', 'IT', 'IT-62', 'Rome', 'yes', 'LIRF', 'FCO', 'RM11', 'http://www.adr.it/portal/portal/adr/Fiumicino/Leonardo_da_vinci/Header_Window?action=2', 'https://en.wikipedia.org/wiki/Leonardo_da_Vinci%E2%80%93Fiumicino_Airport', 'ROM, Rome Fiumicino Airport, Fiumicino Airport'),
	(4386, 'LJLJ', 'large_airport', 'Ljubljana Joze Puknik Airport', 46.223701, 14.4576, 1273, 'EU', 'SI', 'SI-061', 'Ljubljana', 'yes', 'LJLJ', 'LJU', '', 'http://www.lju-airport.si/', 'https://en.wikipedia.org/wiki/Ljubljana_Jo%C5%BEe_Pu%C4%8Dnik_Airport', 'Ljubljana, Brnik, Kranj'),
	(4408, 'LKPR', 'large_airport', 'Vaclav Havel Airport Prague', 50.1008, 14.26, 1247, 'EU', 'CZ', 'CZ-PR', 'Prague', 'yes', 'LKPR', 'PRG', '', 'http://www.prg.aero', 'https://en.wikipedia.org/wiki/Ruzyn%C4%9B_International_Airport', 'LetiÅ¡t? Praha-Ruzyn?, Ruzyn? International Airport, LetiÅ¡t? VÃ¡clava Havla Praha'),
	(4427, 'LMML', 'large_airport', 'Malta International Airport', 35.857498, 14.4775, 300, 'EU', 'MT', 'MT-25', 'Valletta', 'yes', 'LMML', 'MLA', '', 'http://www.maltairport.com/en/home.htm', 'https://en.wikipedia.org/wiki/Malta_International_Airport', 'Luqa Airport,Valletta,Gudja,RAF Luqa'),
	(30153, 'LNMC', 'heliport', 'Monaco Heliport', 43.725798, 7.419673, 20, 'EU', 'MC', 'MC-U-A', 'Fontvieille', 'yes', 'LNMC', 'MCM', '', '', 'https://en.wikipedia.org/wiki/Monaco_Heliport', 'Monte Carlo Heliport, Heli Air Monaco'),
	(4434, 'LOWW', 'large_airport', 'Vienna International Airport', 48.110298, 16.5697, 600, 'EU', 'AT', 'AT-9', 'Vienna', 'yes', 'LOWW', 'VIE', '', 'http://www.viennaairport.com/en/', 'https://en.wikipedia.org/wiki/Vienna_International_Airport', ''),
	(4461, 'LPPT', 'large_airport', 'Humberto Delgado Airport (Lisbon Portela Airport)', 38.7813, -9.13592, 374, 'EU', 'PT', 'PT-11', 'Lisbon', 'yes', 'LPPT', 'LIS', '', 'http://www.ana.pt/en-US/Aeroportos/lisboa/Lisboa/Pages/HomeLisboa.aspx', 'https://en.wikipedia.org/wiki/Lisbon_Portela_Airport', 'Lisboa'),
	(4469, 'LQSA', 'medium_airport', 'Sarajevo International Airport', 43.8246, 18.331499, 1708, 'EU', 'BA', 'BA-BIH', 'Sarajevo', 'yes', 'LQSA', 'SJJ', '', 'http://www.sarajevo-airport.ba/', 'https://en.wikipedia.org/wiki/Sarajevo_International_Airport', ''),
	(4482, 'LROP', 'large_airport', 'Henri Coanda International Airport', 44.5711111, 26.085, 314, 'EU', 'RO', 'RO-B', 'Bucharest', 'yes', 'LROP', 'OTP', '', 'http://www.bucharestairports.ro/en/', 'https://en.wikipedia.org/wiki/Henri_Coand%C4%83_International_Airport', 'BUH, Otopeni Airport, RoAF 90th Airlift Base'),
	(43075, 'LSXB', 'heliport', 'Balzers Heliport', 47.067908, 9.480774, 1585, 'EU', 'LI', 'LI-01', 'Balzers', 'no', 'LSXB', '', '', 'http://www.heli.li/sites/heliports-balzers-lsxb.php', '', ''),
	(4503, 'LSZB', 'medium_airport', 'Bern Belp Airport', 46.914100647, 7.497149944309999, 1674, 'EU', 'CH', 'CH-BE', 'Bern', 'yes', 'LSZB', 'BRN', '', 'http://www.flughafenbern.ch/', 'https://en.wikipedia.org/wiki/Berne_Airport', ''),
	(4571, 'LUKK', 'medium_airport', 'Chisinau International Airport', 46.92770004272461, 28.930999755859375, 399, 'EU', 'MD', 'MD-C', 'Chisinau', 'yes', 'LUKK', 'KIV', '', 'http://www.airport.md/', 'https://en.wikipedia.org/wiki/Chi%C5%9Fin%C4%83u_International_Airport', ''),
	(4573, 'LWSK', 'large_airport', 'Skopje International Airport', 41.961601, 21.621401, 781, 'EU', 'MK', 'MK-004', 'Skopje', 'yes', 'LWSK', 'SKP', '', 'http://skp.airports.com.mk/', 'https://en.wikipedia.org/wiki/Skopje_Airport', ''),
	(4574, 'LXGB', 'medium_airport', 'Gibraltar Airport', 36.151199, -5.34966, 12, 'EU', 'GI', 'GI-U-A', 'Gibraltar', 'yes', 'LXGB', 'GIB', '', '', 'https://en.wikipedia.org/wiki/Gibraltar_Airport', ''),
	(4610, 'LYBE', 'large_airport', 'Belgrade Nikola Tesla Airport', 44.8184013367, 20.3090991974, 335, 'EU', 'RS', 'RS-00', 'Belgrade', 'yes', 'LYBE', 'BEG', '', 'http://www.beg.aero/', 'https://en.wikipedia.org/wiki/Belgrade_Nikola_Tesla_Airport', 'Beograd, Sur?in Airport'),
	(4613, 'LYPG', 'large_airport', 'Podgorica Airport / Podgorica Golubovci Airbase', 42.359402, 19.2519, 141, 'EU', 'ME', 'ME-16', 'Podgorica', 'yes', 'LYPG', 'TGD', '', 'http://www.montenegroairports.com/?menu=2', 'https://en.wikipedia.org/wiki/Podgorica_Airport', 'Podgorica Airbase, Golubovci Airbase, ???????? ?????????, Aerodrom Podgorica'),
	(4617, 'LZIB', 'large_airport', 'M. R. Stefanik Airport', 48.17020034790039, 17.21269989013672, 436, 'EU', 'SK', 'SK-BL', 'Bratislava', 'yes', 'LZIB', 'BTS', '', '', 'https://en.wikipedia.org/wiki/M._R._%C5%A0tef%C3%A1nik_Airport', ''),
	(6478, 'UKKK', 'medium_airport', 'Kiev Zhuliany International Airport', 50.40194, 30.45194, 587, 'EU', 'UA', 'UA-32', 'Kiev', 'yes', 'UKKK', 'IEV', '', 'https://iev.aero/', 'https://en.wikipedia.org/wiki/Kyiv_International_Airport_(Zhuliany)', '??????????? ???????? "????"'),
	(6501, 'UMMS', 'large_airport', 'Minsk National Airport', 53.888071, 28.039964, 670, 'EU', 'BY', 'BY-MI', 'Minsk', 'yes', 'UMMS', 'MSQ', '', 'http://airport.by/en', 'https://en.wikipedia.org/wiki/Minsk_National_Airport', '??????????? ????????, Minsk 2 Airport'),
	(26394, 'UUDD', 'large_airport', 'Domodedovo International Airport', 55.40879821777344, 37.90629959106445, 588, 'EU', 'RU', 'RU-MOS', 'Moscow', 'yes', 'UUDD', 'DME', '', 'http://www.domodedovo.ru/en/', 'https://en.wikipedia.org/wiki/Domodedovo_International_Airport', 'MOW, ???????? ???????????'),
	(44551, 'VA-0001', 'heliport', 'Vatican City Heliport', 41.9019775391, 12.4461307526, 221, 'EU', 'VA', 'VA-U-A', 'Vatican', 'no', '', '', '', '', 'https://en.wikipedia.org/wiki/Vatican_City_Heliport', '');
/*!40000 ALTER TABLE `airport` ENABLE KEYS */;

-- Dumping structure for table flight_game.country
CREATE TABLE IF NOT EXISTS `country` (
  `iso_country` varchar(10) NOT NULL,
  `name` varchar(40) DEFAULT NULL,
  `continent` varchar(40) DEFAULT NULL,
  `wikipedia_link` varchar(40) DEFAULT NULL,
  `keywords` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`iso_country`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table flight_game.country: ~50 rows (approximately)
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` (`iso_country`, `name`, `continent`, `wikipedia_link`, `keywords`) VALUES
	('AD', 'Andorra', 'EU', 'https://en.wikipedia.org/wiki/Andorra', '\r'),
	('AL', 'Albania', 'EU', 'https://en.wikipedia.org/wiki/Albania', '\r'),
	('AT', 'Austria', 'EU', 'https://en.wikipedia.org/wiki/Austria', 'FlughÃ¤fen in Ã–sterreich\r'),
	('BA', 'Bosnia and Herzegovina', 'EU', 'https://en.wikipedia.org/wiki/Bosnia_and', '\r'),
	('BE', 'Belgium', 'EU', 'https://en.wikipedia.org/wiki/Belgium', 'AÃ©roports de Belgique'),
	('BG', 'Bulgaria', 'EU', 'https://en.wikipedia.org/wiki/Bulgaria', '\r'),
	('BY', 'Belarus', 'EU', 'https://en.wikipedia.org/wiki/Belarus', 'Belarussian'),
	('CH', 'Switzerland', 'EU', 'https://en.wikipedia.org/wiki/Switzerlan', 'AÃ©roports de la Suisse'),
	('CZ', 'Czech Republic', 'EU', 'https://en.wikipedia.org/wiki/Czech_Repu', 'LetiÅ¡t? ?eskÃ© republiky'),
	('DE', 'Germany', 'EU', 'https://en.wikipedia.org/wiki/Germany', 'FlughÃ¤fen in Deutschland\r'),
	('DK', 'Denmark', 'EU', 'https://en.wikipedia.org/wiki/Denmark', 'Lufthavnene i Danmark\r'),
	('EE', 'Estonia', 'EU', 'https://en.wikipedia.org/wiki/Estonia', '\r'),
	('ES', 'Spain', 'EU', 'https://en.wikipedia.org/wiki/Spain', 'Aeropuertos de EspaÃ±a\r'),
	('FI', 'Finland', 'EU', 'https://en.wikipedia.org/wiki/Finland', 'LentokentÃ¤t'),
	('FO', 'Faroe Islands', 'EU', 'https://en.wikipedia.org/wiki/Faroe_Isla', '\r'),
	('FR', 'France', 'EU', 'https://en.wikipedia.org/wiki/France', 'AÃ©roports de France\r'),
	('GB', 'United Kingdom', 'EU', 'https://en.wikipedia.org/wiki/United_Kin', 'Great Britain\r'),
	('GG', 'Guernsey', 'EU', 'https://en.wikipedia.org/wiki/Guernsey', '\r'),
	('GI', 'Gibraltar', 'EU', 'https://en.wikipedia.org/wiki/Gibraltar', '\r'),
	('GR', 'Greece', 'EU', 'https://en.wikipedia.org/wiki/Greece', '?????????? ???? ??????\r'),
	('HR', 'Croatia', 'EU', 'https://en.wikipedia.org/wiki/Croatia', '\r'),
	('HU', 'Hungary', 'EU', 'https://en.wikipedia.org/wiki/Hungary', 'RepÃ¼l?terek MagyarorszÃ¡g\r'),
	('IE', 'Ireland', 'EU', 'https://en.wikipedia.org/wiki/Ireland', 'Eire\r'),
	('IM', 'Isle of Man', 'EU', 'https://en.wikipedia.org/wiki/Isle_of_Ma', '\r'),
	('IS', 'Iceland', 'EU', 'https://en.wikipedia.org/wiki/Iceland', '\r'),
	('IT', 'Italy', 'EU', 'https://en.wikipedia.org/wiki/Italy', 'Aeroporti d\'Italia\r'),
	('JE', 'Jersey', 'EU', 'https://en.wikipedia.org/wiki/Jersey', '\r'),
	('LI', 'Liechtenstein', 'EU', 'https://en.wikipedia.org/wiki/Liechtenst', '\r'),
	('LT', 'Lithuania', 'EU', 'https://en.wikipedia.org/wiki/Lithuania', '\r'),
	('LU', 'Luxembourg', 'EU', 'https://en.wikipedia.org/wiki/Luxembourg', '\r'),
	('LV', 'Latvia', 'EU', 'https://en.wikipedia.org/wiki/Latvia', '\r'),
	('MC', 'Monaco', 'EU', 'https://en.wikipedia.org/wiki/Monaco', '\r'),
	('MD', 'Moldova', 'EU', 'https://en.wikipedia.org/wiki/Moldova', '\r'),
	('ME', 'Montenegro', 'EU', 'https://en.wikipedia.org/wiki/Montenegro', '\r'),
	('MK', 'North Macedonia', 'EU', 'https://en.wikipedia.org/wiki/Macedonia', '\r'),
	('MT', 'Malta', 'EU', 'https://en.wikipedia.org/wiki/Malta', '\r'),
	('NL', 'Netherlands', 'EU', 'https://en.wikipedia.org/wiki/Netherland', 'Holland'),
	('NO', 'Norway', 'EU', 'https://en.wikipedia.org/wiki/Norway', 'Flyplasser i Norge\r'),
	('PL', 'Poland', 'EU', 'https://en.wikipedia.org/wiki/Poland', 'Lotniska Polski\r'),
	('PT', 'Portugal', 'EU', 'https://en.wikipedia.org/wiki/Portugal', 'Aeroportos do Brasil\r'),
	('RO', 'Romania', 'EU', 'https://en.wikipedia.org/wiki/Romania', 'Aeroporturi din RomÃ¢nia\r'),
	('RS', 'Serbia', 'EU', 'https://en.wikipedia.org/wiki/Serbia', 'Serb\r'),
	('RU', 'Russia', 'EU', 'https://en.wikipedia.org/wiki/Russia', 'Soviet'),
	('SE', 'Sweden', 'EU', 'https://en.wikipedia.org/wiki/Sweden', 'Flygplatserna'),
	('SI', 'Slovenia', 'EU', 'https://en.wikipedia.org/wiki/Slovenia', '\r'),
	('SK', 'Slovakia', 'EU', 'https://en.wikipedia.org/wiki/Slovakia', 'letisko Slovenska\r'),
	('SM', 'San Marino', 'EU', 'https://en.wikipedia.org/wiki/San_Marino', '\r'),
	('UA', 'Ukraine', 'EU', 'https://en.wikipedia.org/wiki/Ukraine', '????????? ???????\r'),
	('VA', 'Vatican City', 'EU', 'https://en.wikipedia.org/wiki/Vatican_Ci', 'The Holy See\r'),
	('XK', 'Kosovo', 'EU', 'https://en.wikipedia.org/wiki/Kosovo', 'Kosova\r');
/*!40000 ALTER TABLE `country` ENABLE KEYS */;

-- Dumping structure for table flight_game.game
CREATE TABLE IF NOT EXISTS `game` (
  `id` varchar(50) NOT NULL DEFAULT '',
  `co2_consumed` int(8) DEFAULT NULL,
  `co2_budget` int(8) DEFAULT NULL,
  `screen_name` varchar(10) DEFAULT NULL,
  `location` varchar(40) DEFAULT NULL,
  `dice` int(11) DEFAULT NULL,
  `collected_countries` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table flight_game.game: ~42 rows (approximately)
/*!40000 ALTER TABLE `game` DISABLE KEYS */;
INSERT INTO `game` (`id`, `co2_consumed`, `co2_budget`, `screen_name`, `location`, `dice`, `collected_countries`) VALUES
	('0qsuRaYKWXd0yilj60jV', 2082, 7918, 'k', 'ESSA', 3, 1),
	('1', 2000, 10000, 'Heini', 'EFHK', 2, NULL),
	('2', 3000, 10000, 'Vesa', 'EGCC', NULL, NULL),
	('25VqsMCzLmPSLOatExTa', 5962, 4038, 'k', 'LGAV', 6, 0),
	('3', 8000, 10000, 'Ilkka', 'EGKK', NULL, NULL),
	('4CBBGLlTGUHXlSOp19cr', 0, 1000, 'EFHK', 'c', NULL, NULL),
	('5sMg2eKf1YngTALdJzdb', 0, 1000, 'EFHK', 'k', NULL, NULL),
	('6iiKeOL6CQvQIG7nuyga', 0, 1000, 'EFHK', 'k', NULL, NULL),
	('8EkkWwRF86JH8PKLDkVs', 0, 1000, 'EFHK', 'k', NULL, NULL),
	('8kIQH6uqC8nGGxIA5T44', 0, 1000, 'EFHK', 'k', NULL, NULL),
	('aBv4fXG0cTdyveh0VR0E', 0, 10000, 'k', 'EFHK', 6, 0),
	('AlB5qyXiBt7M19zBgKl8', 1512, -512, 'EFHK', 'LOWW', NULL, NULL),
	('D9YC03mGuYA2nroXNUqg', 0, 10000, 'k', 'EFHK', 5, 0),
	('dEiGNgI0fzde5g5ls2XY', 0, 1000, 'EFHK', 'k', NULL, NULL),
	('e8Vt3JIoy42WFcKL8TLk', 1774, -774, 'EFHK', 'LDZA', NULL, NULL),
	('eXFsbPc70RClntLbvaFG', 9197, 803, 'EFHK', 'LEMD', NULL, NULL),
	('f3VAL4Zh1SYBy8D8bHSn', 399, 9601, 'k', 'ESSA', 5, 0),
	('HFNrKOYW9YuZ4lx0iDYE', 3501, 6499, 'karin', 'UUDD', 2, 0),
	('hxjmQAKEr4cV9tjWufps', 0, 1000, 'EFHK', 'f', NULL, NULL),
	('i60C5PriL7srDsfGbol3', 0, 10000, 'EFHK', 'k', NULL, NULL),
	('ig3HRZYRj9Igv8TBkQrY', 0, 1000, 'EFHK', 'k', NULL, NULL),
	('iPUULAHQLb5hO6NhGYAp', 0, 1000, 'EFHK', 'j', NULL, NULL),
	('JLhjPPQx6NJlRsWfTvLy', 1289, 8711, 'k', 'ESSA', 2, 0),
	('K7fzzNuJQy96D7cnAVRG', 0, 1000, 'EFHK', 'k', NULL, NULL),
	('lqNmmEGOAFkqdvrD3ZMJ', 0, 10000, 'EFHK', 'k', NULL, NULL),
	('MmzuMYwhjCXeCplyuV0R', 1462, 8538, 'EFHK', 'LKPR', NULL, NULL),
	('mreipLvHDokJrkbzyulr', 0, 1000, 'EFHK', 'k', NULL, NULL),
	('MUbyegRR4bnkThq8pQZ9', 150, 850, 'EFHK', 'EETN', NULL, NULL),
	('nGm2q0iylDeysAvToWIB', 0, 10000, 'EFHK', 'k', NULL, NULL),
	('NlqEUxPBe1qG1A14rrSm', 0, 1000, 'EFHK', 'g', NULL, NULL),
	('oaT8vDjxWdCu1F1oRlvx', 0, 10000, 'EFHK', 'h', NULL, NULL),
	('OwDo7zQTRp0zYVkX5RzR', 784, 9216, 'k', 'ENGM', 1, 0),
	('Rh1RzaRE01qYw8e0zQWm', 0, 10000, 'k', 'EFHK', 6, 0),
	('rmmLWCBBNGMEhR7vkZcl', 0, 1000, 'EFHK', 'g', NULL, NULL),
	('SDK7N4S1EOrwKIqKG9RB', 450, 550, 'EFHK', 'EETN', NULL, NULL),
	('SL9n92k1B3tjQAsMkc9L', 0, 1000, 'EFHK', 't', NULL, NULL),
	('SLjSx51QpAGOv2xn65hF', 100, 9900, 'karin', 'EETN', 3, 0),
	('sM9Mwz1UBESULyJEJQKp', 874, 9126, 'k', 'ENGM', 3, 0),
	('tcaHmIVmMF8sF03DNSau', 766, 9234, 'k', 'ENGM', 6, 1),
	('TkeBHicu5T9g1tJ3abOG', 0, 1000, 'EFHK', 'k', NULL, NULL),
	('X7KGlR5zKPLahpl8zhcS', 2471, 7529, 'k', 'LSZB', 1, 0),
	('xwCl6HgsLAUt4Bpe3j2X', 0, 10000, 'k', 'EFHK', 2, 0);
/*!40000 ALTER TABLE `game` ENABLE KEYS */;

-- Dumping structure for table flight_game.goal
CREATE TABLE IF NOT EXISTS `goal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `icon` varchar(8) DEFAULT NULL,
  `target` varchar(40) DEFAULT NULL,
  `target_minvalue` decimal(8,2) DEFAULT NULL,
  `target_maxvalue` decimal(8,2) DEFAULT NULL,
  `target_text` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Dumping data for table flight_game.goal: ~8 rows (approximately)
/*!40000 ALTER TABLE `goal` DISABLE KEYS */;
INSERT INTO `goal` (`id`, `name`, `description`, `icon`, `target`, `target_minvalue`, `target_maxvalue`, `target_text`) VALUES
	(1, 'HOT', 'Temperature over +25C', '01d', 'TEMP', 25.00, 9999.00, NULL),
	(2, 'COLD', 'Temperature under -20C', '13d', 'TEMP', -9999.00, -20.00, NULL),
	(3, '0DEG', 'Temperature exactly 0C', '04d', 'TEMP', -0.50, 0.50, NULL),
	(4, '10DEG', 'Temperature exactly +10C', '04d', 'TEMP', 9.50, 10.50, NULL),
	(5, '20DEG', 'Temperature exactly +20C', '04d', 'TEMP', 19.50, 20.50, NULL),
	(6, 'CLEAR', 'Clear skies', '01d', 'WEATHER', NULL, NULL, 'Clear'),
	(7, 'CLOUDS', 'Cloudy', '04d', 'WEATHER', NULL, NULL, 'Clouds'),
	(8, 'WINDY', 'Wind blows more than 10 m/s', '04d', 'WIND', 10.00, 9999.00, NULL);
/*!40000 ALTER TABLE `goal` ENABLE KEYS */;

-- Dumping structure for table flight_game.goalreached
CREATE TABLE IF NOT EXISTS `goalreached` (
  `gameid` varchar(50) NOT NULL DEFAULT '',
  `goalid` int(11) NOT NULL,
  PRIMARY KEY (`gameid`,`goalid`) USING BTREE,
  KEY `goalreached_ibfk_2` (`goalid`),
  CONSTRAINT `goalreached_ibfk_1` FOREIGN KEY (`gameid`) REFERENCES `game` (`id`),
  CONSTRAINT `goalreached_ibfk_2` FOREIGN KEY (`goalid`) REFERENCES `goal` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table flight_game.goalreached: ~48 rows (approximately)
/*!40000 ALTER TABLE `goalreached` DISABLE KEYS */;
INSERT INTO `goalreached` (`gameid`, `goalid`) VALUES
	('0qsuRaYKWXd0yilj60jV', 3),
	('0qsuRaYKWXd0yilj60jV', 7),
	('25VqsMCzLmPSLOatExTa', 3),
	('25VqsMCzLmPSLOatExTa', 7),
	('4CBBGLlTGUHXlSOp19cr', 6),
	('5sMg2eKf1YngTALdJzdb', 6),
	('aBv4fXG0cTdyveh0VR0E', 7),
	('AlB5qyXiBt7M19zBgKl8', 3),
	('AlB5qyXiBt7M19zBgKl8', 6),
	('D9YC03mGuYA2nroXNUqg', 7),
	('e8Vt3JIoy42WFcKL8TLk', 6),
	('e8Vt3JIoy42WFcKL8TLk', 7),
	('eXFsbPc70RClntLbvaFG', 3),
	('eXFsbPc70RClntLbvaFG', 6),
	('eXFsbPc70RClntLbvaFG', 7),
	('f3VAL4Zh1SYBy8D8bHSn', 3),
	('f3VAL4Zh1SYBy8D8bHSn', 7),
	('HFNrKOYW9YuZ4lx0iDYE', 3),
	('HFNrKOYW9YuZ4lx0iDYE', 7),
	('hxjmQAKEr4cV9tjWufps', 6),
	('i60C5PriL7srDsfGbol3', 6),
	('ig3HRZYRj9Igv8TBkQrY', 6),
	('iPUULAHQLb5hO6NhGYAp', 6),
	('JLhjPPQx6NJlRsWfTvLy', 3),
	('JLhjPPQx6NJlRsWfTvLy', 7),
	('K7fzzNuJQy96D7cnAVRG', 6),
	('lqNmmEGOAFkqdvrD3ZMJ', 6),
	('MmzuMYwhjCXeCplyuV0R', 3),
	('MmzuMYwhjCXeCplyuV0R', 6),
	('MmzuMYwhjCXeCplyuV0R', 7),
	('MUbyegRR4bnkThq8pQZ9', 6),
	('nGm2q0iylDeysAvToWIB', 6),
	('NlqEUxPBe1qG1A14rrSm', 6),
	('oaT8vDjxWdCu1F1oRlvx', 6),
	('OwDo7zQTRp0zYVkX5RzR', 3),
	('OwDo7zQTRp0zYVkX5RzR', 7),
	('Rh1RzaRE01qYw8e0zQWm', 7),
	('rmmLWCBBNGMEhR7vkZcl', 6),
	('SDK7N4S1EOrwKIqKG9RB', 6),
	('SL9n92k1B3tjQAsMkc9L', 6),
	('SLjSx51QpAGOv2xn65hF', 7),
	('sM9Mwz1UBESULyJEJQKp', 3),
	('sM9Mwz1UBESULyJEJQKp', 7),
	('tcaHmIVmMF8sF03DNSau', 3),
	('tcaHmIVmMF8sF03DNSau', 7),
	('X7KGlR5zKPLahpl8zhcS', 3),
	('X7KGlR5zKPLahpl8zhcS', 7),
	('xwCl6HgsLAUt4Bpe3j2X', 7);
/*!40000 ALTER TABLE `goalreached` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
