Aula de revisão ministrada pelo professor Itamar, com foco na utilização do pgAdmin e em uma revisão geral dos principais conceitos do PostgreSQL.

**Banco de Dados: Universo**
- - -
###### Criação do banco de dados.
```sql
CREATE DATABASE universo;
\c universo
```

###### Enum
```sql
CREATE TYPE tipo_superficie_enum 
AS ENUM ('sólido', 'liquido', 'gasoso');
```
ENUM (Enumerated Type) é um **tipo de dado personalizado** que permite apenas valores pré-definidos, evita erros de digitação e melhora a integridade.

###### Criação Inicial (Sem PK e FK propositalmente)
```sql
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
    nome VARCHAR(100),
    id_especie INTEGER,
    tiposuperficie tipo_superficie_enum,
    habitantes INTEGER,
    massa FLOAT,
    circunferencia NUMERIC(15,2)
);
```

###### Ajustando as Tabelas (Adicionando PK)
```sql
ALTER TABLE galaxias 
ADD PRIMARY KEY (id);

ALTER TABLE especies 
ADD PRIMARY KEY (id);

ALTER TABLE planetas 
ADD CONSTRAINT pk_planetas 
PRIMARY KEY (id);
```

###### Criando a Foreign Key e transformando o ID em Auto incremento.
```sql
ALTER TABLE planetas
ADD CONSTRAINT fk_especies
FOREIGN KEY(id_especie) 
REFERENCES especies(id);

ALTER TABLE galaxias
ALTER COLUMN id 
ADD GENERATED ALWAYS AS IDENTITY;

ALTER TABLE especies
ALTER COLUMN id 
ADD GENERATED ALWAYS AS IDENTITY;
--Isso faz o PostgreSQL gerar o ID automaticamente.
```
###### Corrigindo Estrutura Antiga
```sql
ALTER TABLE planetas 
ADD COLUMN id_galaxia INTEGER,
ADD COLUMN clima VARCHAR(50);

ALTER TABLE planetas 
ADD CONSTRAINT fk_planetas_galaxia
FOREIGN KEY (id_galaxia)
REFERENCES galaxias(id);
```

