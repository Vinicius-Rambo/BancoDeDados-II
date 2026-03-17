-- exemplo de update

UPDATE planetas SET habitantes = 8100000000 WHERE nome = 'Terra'; --Atualiza a os habitantes do planeta terra.

DELETE FROM planetas WHERE nome = 'Pluto'; --Deleta APENAS o "Pluto"

DELETE FROM planetas WHERE id = 1; --Não funciona por violar a chave primaria, um satelite depende desse planeta.

ALTER TABLE satelites
DROP CONSTRAINT fk_planeta;

ALTER TABLE satelites
ADD CONSTRAINT fk_planeta
FOREIGN KEY(idPlaneta)
REFERENCES planetas(id)
ON DELETE CASCADE;


-- Excercicios

--1
UPDATE planetas SET habitantes = 2000000 WHERE nome = 'Arrakis'; 

--2
UPDATE planetas SET habitantes = habitantes + 500  WHERE habitantes < 1000000;

--3 
DELETE FROM satelites WHERE diametro < 600;

--4 


--Desafio Final


CREATE TABLE satelites(
	id SERIAL PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,
	idPlaneta INTEGER,
	diametro NUMERIC,
	CONSTRAINT fk_planeta
	FOREIGN KEY (idPlaneta)
	REFERENCES planetas(id)
);

--1
INSERT INTO planetas VALUES(51, 'Pandora2', 100000, 48, 13);

--2
INSERT INTO satelites VALUES
(21, 'Pandus1', 51, '1111'),
(22, 'Pandus2', 51, '1122'),
(23, 'Pandus3', 51, '2233');

--3 
ALTER TABLE satelites DROP CONSTRAINT fk_planeta;

ALTER TABLE satelites ADD CONSTRAINT fk_planeta
FOREIGN KEY(idPlaneta)
REFERENCES planetas(id)
ON DELETE CASCADE
WHERE id = 51;

