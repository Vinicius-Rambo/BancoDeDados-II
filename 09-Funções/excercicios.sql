--1
SELECT nome, LOWER(SPLIT_PART(nome, ' ', 1)) AS login from vendedor; 

--2
SELECT descricao,  ROUND((qtde * preco), 2) AS valor_total_estoque FROM produto;

--3
SELECT nome, AGE(CURRENT_DATE, data_nasc ) AS idade FROM cliente;

--4
SELECT nome, CONCAT(SUBSTRING(cpf, 1,3), '.***.***-**') AS cpf_oculto FROM cliente;

--5
SELECT id_venda, 
  TO_CHAR(data_venda, 'DD/MM/YYYY') AS data_venda, 
  TO_CHAR((data_venda + INTERVAL '7 days'),'DD/MM/YYY')  AS data_limite_devolucao 
FROM venda;

--6 
SELECT nome, salario, comissao, 
    TRUNC((salario + comissao),0) AS salario_total 
FROM vendedor;   

--7 
SELECT 
    UPPER(descricao) AS descricao, 
    LENGTH(descricao) AS quantidade
FROM produto; 

--8 
SELECT id_produto, ABS(qtde - qtde_min) AS diferenca FROM produto; 

--9 
SELECT nome, EXTRACT(YEAR FROM data_nasc)AS ano_nascimento from cliente ORDER BY ano_nascimento ASC;

--10 
SELECT 
    'O vendedor(a) ' || 
    SPLIT_PART(nome, ' ', 1) || 
    ' nasceu no ano de ' || 
    EXTRACT(YEAR FROM data_nasc) AS etiqueta_mural 
FROM vendedor; 

SELECT CONCAT('O vendedor(a) ', nome, ' nasceu no ano de ', EXTRACT(YEAR FROM data_nasc)) AS etiqueta_mural FROM vendedor;