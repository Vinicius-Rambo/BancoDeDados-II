--1 
SELECT nome AS planeta FROM planetas;

--2 
SELECT nome AS Planeta, habitantes AS Populacao FROM planetas;

--3
SELECT nome AS planeta FROM planetas ORDER BY nome ASC; 

--4 
SELECT nome AS planetas, habitantes AS Populacao 
FROM planetas ORDER BY habitantes DESC; 

--5 
SELECT nome AS galaxia FROM 
galaxias ORDER BY nome ASC; 

--6 
SELECT p.nome AS planeta, g.nome AS galaxia 
FROM planetas AS p, galaxias AS g WHERE p.idGalaxia = g.id;  

--7
SELECT g.nome AS galaxia, COUNT(p.nome) AS planeta 
FROM planetas AS p, galaxias AS g WHERE p.idGalaxia = g.id GROUP BY galaxia 

--8 
SELECT g.nome AS galaxia, SUM(p.habitantes) AS planeta 
FROM planetas AS p, galaxias AS g WHERE p.idGalaxia = g.id GROUP BY galaxia ORDER BY planeta;

--9 
SELECT e.nome AS especie, COUNT(p.nome) AS planeta 
FROM planetas AS p, especies AS e WHERE p.idEspecie = e.id GROUP BY especie ORDER BY planeta DESC;

--10
SELECT g.nome AS galaxia, COUNT(p.nome) AS planeta 
FROM planetas AS p, galaxias AS g WHERE p.idGalaxia = g.id GROUP BY galaxia ORDER BY planeta ASC