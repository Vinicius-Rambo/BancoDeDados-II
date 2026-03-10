SELECT * FROM planetas; --Todos os atributos da tabela planetas
 
SELECT * FROM planetas WHERE habitantes >= 1000; --Todos os atributos da tabela planetas que forem maior que 1000.

SELECT * FROM planetas ORDER BY habitantes DESC; --Todos os atributos da tabela planetas ordenados pelos habitantes decressente.

SELECT idGalaxia, COUNT(*) FROM planetas GROUP BY idGalaxia; -- Qual o ID da galaxia + a contagem de planetas dentro dela, Agrupado pelos numeros.

--Like é case-sensitive.

SELECT * FROM planetas WHERE nome LIKE 'T%'; -- Todos os atributos da tabela planetas onde o nome começa com T.

SELECT * FROM planetas WHERE nome LIKE '%a'; -- Todos os atributos da tabela planetas onde o nome termina com A.

SELECT * FROM planetas WHERE nome LIKE '%e%'; -- Todos os atributos da tabela planetas onde o nome tem algum e.


