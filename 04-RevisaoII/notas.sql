CREATE DATABASE universo;

CREATE TYPE tipo_superfice_enum AS ENUM ('sólido', 'liquido', 'gasoso');

--Criação inicial de tabelas (Sem PK e FK proposital,)
CREATE TABLE galaxias(
    id INTEGER,
    nome VARCHAR(50)
);

CREATE TABLE especies( 
    id INTEGER,
    nome VARCHAR(50)
);

CREATE TABLE planetas(
    id INTEGER,
    nome VARCHAR,
    id_especie INTEGER,
    tiposuperficie TIPO_SUPERFICE_ENUM, --Tipo criado anteriormente que pode ser sólido, liquido ou gasoso.
    habitantes INTEGER,
    massa FLOAT
    circuferencia numeric(15,2)
);

--Concertando essas tabelas tudo torta.

ALTER TABLE galaxias ADD PRIMARY KEY (id);
ALTER TABLE especies ADD PRIMARY KEY (id);

ALTER TABLE planetas 
ADD CONSTRAINT pk_planetas PRIMARY KEY (id);

--
ALTER TABLE planetas
ADD CONSTRAINT fk_especies
FOREIGN KEY(id_especie) REFERENCES especies(id);

--ALTER TABLE planetas
--ADD CONSTRAINT fk_galaxia
--FOREIGN KEY(id) REFERENCES galaxias(id);

ALTER TABLE galaxias
ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY; --cria um gerador automatico no ID.

ALTER TABLE especies
ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY;

--Alterando nome de tabela e colunas

ALTER TABLE especies RENAME TO especies_inteligentes;

ALTER TABLE planetas ALTER COLUMN massa TYPE NUMERIC(10,2);
--ALTER TABLE planetas RENAME COLUMN tipoClimatico TO clima;

--Criando e excluindo uma tabela.

CREATE TABLE teste( 
    id SERIAL PRIMARY KEY,
    descricao VARCHAR(50)
);

DROP TABLE teste;

--Corrigindo nossos erros do passado.

ALTER TABLE planetas 
ADD COLUMN id_galaxia integer,
ADD COLUMN clima VARCHAR(50);

ALTER table planetas 
ADD CONSTRAINT fkPlanetas
FOREIGN KEY (id_galaxia)
REFERENCES galaxias(id);

