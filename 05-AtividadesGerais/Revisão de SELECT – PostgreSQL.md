Aula de revisão ministrada pelo professor Itamar, com foco na utilização do SELECT, usando o  **banco de dados: universo**.

a base utilizada foi: [base.sql](base.sql)
- - - 
## Consultas Básicas

###### Selecionar todos os dados da tabela
``` sql
SELECT * FROM planetas;
```
Seleciona **todos os atributos e registros** da tabela `planetas`.

###### Filtrando registros com WHERE.
```sql
SELECT * 
FROM planetas 
WHERE habitantes >= 1000;
```
Retorna todos os planetas que possuem habitantes maior ou igual a 1000.
###### Ordenação de resultados
```sql
SELECT * 
FROM planetas 
ORDER BY habitantes DESC;
```
Ordena os resultados **do maior para o menor número de habitantes**.
- - -  
## Agrupamento de dados

###### Contagem de planetas por galáxia
```sql
SELECT id_galaxia, COUNT(*) 
FROM planetas  
GROUP BY id_galaxia;
```
Agrupa os planetas pelo **ID da galáxia** e mostra **quantos planetas existem em cada uma**.
- - - 
## Utilizando LIKE (Busca por padrões)

> No PostgreSQL, `LIKE` é **case-sensitive** (diferencia maiúsculas e minúsculas).
###### Nome começando com determinada letra
```sql
SELECT * 
FROM planetas 
WHERE nome LIKE 'T%';
```
Retorna planetas cujo nome começa com **"T"**.
###### Nome terminando com determinada letra
```sql
SELECT * 
FROM planetas 
WHERE nome LIKE '%a';
```
Retorna planetas cujo nome termina com **"a"**.
###### Nome contendo determinada letra
```sql
SELECT * 
FROM planetas 
WHERE nome LIKE '%e%';
```
Retorna planetas cujo nome contém a letra **"e"** em qualquer posição.
- - - 
## Exercícios de SELECT

1. Liste  todos os planetas mostrando apenas o nome
```sql
SELECT nome AS planeta 
FROM planetas;
```

2. Liste todos os planetas e o numero de habitantes (Use alias para renomear as colunas para: planeta população) 
```sql
SELECT nome AS planeta, habitantes AS populacao 
FROM planetas;
```

 3. Liste todos os planetas ordenados alfabeticamente
```sql
SELECT nome AS planeta 
FROM planetas 
ORDER BY nome ASC;
```

4. Liste todos os planetas do mais populoso para o menos populoso
```sql
SELECT nome AS planeta, habitantes AS populacao 
FROM planetas 
ORDER BY habitantes DESC;
```

 5. Liste todas as galaxias em ordem alfabetica
```sql
SELECT nome AS galaxia 
FROM galaxias 
ORDER BY nome ASC;
```

6. Liste os planetas e suas galaxias 
```sql
SELECT p.nome AS planeta, g.nome AS galaxia
FROM planetas AS p, galaxias AS g
WHERE p.id_galaxia = g.id;
```

7. Liste quantos planetas existem em cada galaxia.
```sql
SELECT g.nome AS galaxia, COUNT(p.nome) AS quantidade_planetas
FROM planetas AS p, galaxias AS g
WHERE p.id_galaxia = g.id
GROUP BY g.nome;
```

8. Liste a soma de habitantes por galaxia.
```sql
SELECT g.nome AS galaxia, SUM(p.habitantes) AS total_habitantes
FROM planetas AS p, galaxias AS g
WHERE p.id_galaxia = g.id
GROUP BY g.nome
ORDER BY total_habitantes;
```

9. Liste quantos planetas existe para cada especie dominante
```sql
SELECT e.nome AS especie, COUNT(p.nome) AS quantidade_planetas
FROM planetas AS p, especies AS e
WHERE p.id_especie = e.id
GROUP BY e.nome
ORDER BY quantidade_planetas DESC;
```

10. Liste as galaxias ordenadas pela quantidade de planetas.
```sql
SELECT g.nome AS galaxia, COUNT(p.nome) AS quantidade_planetas
FROM planetas AS p, galaxias AS g
WHERE p.id_galaxia = g.id
GROUP BY g.nome
ORDER BY quantidade_planetas ASC;
```
 - - -
## Manipulação de Estruturas de Tabelas.
###### Criando tabela de estrelas
```sql
CREATE TABLE estrelas(
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    tamanho NUMERIC,
    id_galaxia INTEGER,
    CONSTRAINT fk_galaxia 
    FOREIGN KEY (id_galaxia) 
    REFERENCES galaxias(id)
);
```

###### Criando tabela de satélites
```sql
CREATE TABLE satelites(
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    id_planeta INTEGER,
    diametro NUMERIC,
    CONSTRAINT fk_planetas 
    FOREIGN KEY (id_planeta) 
    REFERENCES planetas(id)
);
```
---
## Alterando estrutura das tabelas

Renomeando coluna
```sql
ALTER TABLE estrelas 
RENAME COLUMN tamanho TO massa;
```

```sql
ALTER TABLE satelites 
ALTER COLUMN diametro TYPE NUMERIC(10,2);
```

```sql
ALTER TABLE satelites 
ADD COLUMN habitavel BOOLEAN;
```

- - -
## Próxima aula: 
professor substituto temporário Itamar:  [[Revisão II]]