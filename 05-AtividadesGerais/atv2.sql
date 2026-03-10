CREATE TABLE estrelas(
    id SERIAL PRIMARY KEY, 
    nome VARCHAR(50) NOT NULL,
    tamanho NUMERIC,
    idGalaxia INTEGER,
    CONSTRAINT fk_galaxia FOREIGN KEY (idGalaxia) REFERENCES galaxias(id)
);

CREATE TABLE satelites( 
    id SERIAL PRIMARY KEY, 
    nome VARCHAR(50) NOT NULL,
    idPlaneta INTEGER,
    diametro NUMERIC,
    CONSTRAINT fk_planetas FOREIGN KEY (idPlaneta) REFERENCES planetas(id)
);

ALTER TABLE estrelas RENAME COLUMN tamanho TO massa;

ALTER TABLE satelites ALTER COLUMN diametro TYPE NUMERIC(10,2);

ALTER TABLE satelites ADD COLUMN  habitavel BOOLEAN;