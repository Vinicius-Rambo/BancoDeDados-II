--Base de aula criado pelo professor.


-- =========================
-- CRIAÇÃO DAS TABELAS
-- =========================

CREATE TABLE especies (
    id INTEGER PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE galaxias (
    id INTEGER PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE planetas (
    id INTEGER PRIMARY KEY,
    nome VARCHAR(100),
    habitantes NUMERIC,
    idEspecie INTEGER,
    idGalaxia INTEGER,
    CONSTRAINT fk_especie
        FOREIGN KEY (idEspecie)
        REFERENCES especies(id),
    CONSTRAINT fk_galaxia
        FOREIGN KEY (idGalaxia)
        REFERENCES galaxias(id)
);

-- =========================
-- INSERIR ESPECIES (50)
-- =========================

INSERT INTO especies VALUES
(1,'Humanos'),
(2,'Klingons'),
(3,'Vulcanos'),
(4,'NaVi'),
(5,'Predators'),
(6,'Xenomorphs'),
(7,'Wookiees'),
(8,'Ewoks'),
(9,'TimeLords'),
(10,'Asgardianos'),
(11,'Skrulls'),
(12,'Kree'),
(13,'Minbari'),
(14,'Narn'),
(15,'Cylons'),
(16,'TwiLek'),
(17,'Zabrak'),
(18,'Hutt'),
(19,'Gungan'),
(20,'Daleks'),
(21,'Cybermen'),
(22,'Ferengi'),
(23,'Romulanos'),
(24,'Cardassianos'),
(25,'Borg'),
(26,'Chiss'),
(27,'MonCalamari'),
(28,'Quarians'),
(29,'Turians'),
(30,'Salarians'),
(31,'Krogan'),
(32,'Asari'),
(33,'Reapers'),
(34,'Geth'),
(35,'Protoss'),
(36,'Zerg'),
(37,'Terrans'),
(38,'Martians'),
(39,'Venusians'),
(40,'Saturnians'),
(41,'Plutonians'),
(42,'Andromedans'),
(43,'Betazoids'),
(44,'Kelpiens'),
(45,'Trill'),
(46,'Orions'),
(47,'Talaxians'),
(48,'Pakleds'),
(49,'Ocampa'),
(50,'Bajoran');

-- =========================
-- INSERIR GALAXIAS (50)
-- =========================

INSERT INTO galaxias VALUES
(1,'ViaLactea'),
(2,'Andromeda'),
(3,'Triangulum'),
(4,'Whirlpool'),
(5,'Sombrero'),
(6,'Pinwheel'),
(7,'Cartwheel'),
(8,'Sunflower'),
(9,'BlackEye'),
(10,'Cigar'),
(11,'CentaurusA'),
(12,'LargeMagellanic'),
(13,'SmallMagellanic'),
(14,'Messier81'),
(15,'Messier82'),
(16,'Messier87'),
(17,'NGC1300'),
(18,'NGC253'),
(19,'NGC2841'),
(20,'NGC300'),
(21,'NGC891'),
(22,'NGC1097'),
(23,'NGC1365'),
(24,'NGC1512'),
(25,'NGC1672'),
(26,'NGC2207'),
(27,'NGC2403'),
(28,'NGC2683'),
(29,'NGC2903'),
(30,'NGC2997'),
(31,'NGC3079'),
(32,'NGC3184'),
(33,'NGC3310'),
(34,'NGC3344'),
(35,'NGC3521'),
(36,'NGC3627'),
(37,'NGC3628'),
(38,'NGC3718'),
(39,'NGC4038'),
(40,'NGC4051'),
(41,'NGC4088'),
(42,'NGC4157'),
(43,'NGC4214'),
(44,'NGC4244'),
(45,'NGC4258'),
(46,'NGC4303'),
(47,'NGC4321'),
(48,'NGC4395'),
(49,'NGC4449'),
(50,'NGC4559');

-- =========================
-- INSERIR PLANETAS (50)
-- =========================

INSERT INTO planetas VALUES
(1,'Terra',8000000000,1,1),
(2,'Vulcano',6000000,3,1),
(3,'QoNos',9000000,2,1),
(4,'Pandora',12000000,4,2),
(5,'LV426',500000,6,3),
(6,'Kashyyyk',4500000,7,1),
(7,'Endor',300000,8,1),
(8,'Gallifrey',2000000,9,4),
(9,'Asgard',1000000,10,5),
(10,'Skrullos',7000000,11,2),
(11,'Hala',5000000,12,2),
(12,'Minbar',2000000,13,6),
(13,'NarnPrime',3000000,14,6),
(14,'Caprica',4000000,15,7),
(15,'Ryloth',1500000,16,1),
(16,'Iridonia',900000,17,1),
(17,'NalHutta',2000000,18,1),
(18,'Naboo',4500000,19,1),
(19,'Skaro',800000,20,8),
(20,'Mondas',600000,21,8),
(21,'Ferenginar',700000,22,1),
(22,'Romulus',3000000,23,1),
(23,'Cardassia',2500000,24,1),
(24,'BorgPrime',9999999,25,9),
(25,'Csilla',400000,26,1),
(26,'MonCala',900000,27,1),
(27,'Rannoch',600000,28,10),
(28,'Palaven',5000000,29,10),
(29,'SurKesh',700000,30,10),
(30,'Tuchanka',300000,31,10),
(31,'Thessia',4500000,32,10),
(32,'DarkSpace',1,33,11),
(33,'GethPrime',1000000,34,11),
(34,'Aiur',8000000,35,12),
(35,'Char',9000000,36,12),
(36,'Korhal',5000000,37,12),
(37,'Mars',0,38,1),
(38,'Venus',0,39,1),
(39,'Saturn',0,40,1),
(40,'Pluto',0,41,1),
(41,'Andros',1200000,42,2),
(42,'Betazed',800000,43,1),
(43,'Kaminar',700000,44,1),
(44,'TrillPrime',650000,45,1),
(45,'Orion',500000,46,1),
(46,'Talax',400000,47,1),
(47,'Pakledia',300000,48,1),
(48,'OcampaPrime',200000,49,1),
(49,'Bajor',3500000,50,1),
(50,'Arrakis',1000000,1,13);