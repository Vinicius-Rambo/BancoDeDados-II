-- Active: 1775778814249@@127.0.0.1@5432@ifloja
--1. Funções para Manipulação de Strings (Textos)

UPPER() - Maiúsculas
--Transforma todo o nome dos clientes em letras maiúsculas.
SELECT nome, UPPER(nome) AS nome_maiusculo FROM cliente;

LOWER() - Minúsculas
--Garante que todos os e-mails dos vendedores apareçam em minúsculas (ideal para padronização de login).
SELECT nome, email, LOWER(email) AS email_padronizado FROM vendedor;

INITCAP() - Letra Capitular
Deixa a primeira letra de cada palavra maiúscula na descrição do produto.
SELECT descricao, INITCAP(descricao) AS descricao_bonita FROM produto;


LENGTH() - Tamanho do Texto
Conta quantos caracteres tem a descrição de cada produto. Pode ser usado para achar descrições muito curtas.
SELECT descricao, LENGTH(descricao) AS tamanho_descricao FROM produto;

SUBSTRING() - Extração de Pedaços
Pega apenas os 3 primeiros caracteres do CPF do cliente.
SELECT nome, cpf, SUBSTRING(cpf FROM 1 FOR 3) AS inicio_cpf FROM cliente;

REPLACE() - Substituição de Caracteres
Remove o traço do CPF dos clientes, substituindo-o por nada (vazio).
SELECT cpf, REPLACE(cpf, '-', '') AS cpf_sem_traco FROM cliente;

CONCAT() (ou `||`) - Concatenação (Junção)
Cria uma frase amigável juntando o nome do cliente e seu telefone.
SELECT nome, fone, CONCAT(nome, ' - Contato: ', fone) AS info_contato FROM cliente;
-- Alternativa: nome || ' - Contato: ' || fone

SPLIT_PART() - Divisão por delimitador
Extrai apenas o primeiro nome do cliente (divide por espaço e pega a primeira parte).
SELECT nome, SPLIT_PART(nome, ' ', 1) AS primeiro_nome FROM cliente;

POSITION()  / STRPOS() - Posição de um Caractere
Descobre em qual posição está o arroba (`@`) no e-mail do cliente.

SELECT email, POSITION('@' IN email) AS posicao_arroba FROM cliente;


RIGHT() e LEFT()  - Pegando pelas bordas
Pega apenas os últimos 2 dígitos do CPF do cliente usando a função RIGHT (disponível nas versões recentes do Postgres).

SELECT nome, cpf, RIGHT(cpf, 2) AS digito_verificador FROM cliente;


--2. Funções para Tipos de Dados Numéricos
--Operadores Matemáticos Básicos (+, -, *, /)
--Calcula o preço do produto subtraindo o valor do desconto.

SELECT descricao, preco, desconto, (preco - desconto) AS preco_final FROM produto;


ROUND() - Arredondamento com casas decimais
Aplica um acréscimo de 10% no preço dos produtos e arredonda para 2 casas decimais.

SELECT descricao, preco, ROUND((preco * 1.10), 2) AS preco_com_acrescimo FROM produto;


13. TRUNC() - Truncamento (corta sem arredondar)
Corta os centavos do salário do vendedor, retornando apenas a parte inteira.

SELECT nome, salario, TRUNC(salario, 0) AS salario_inteiro FROM vendedor;


CEIL() - Arredondamento para Cima
Exibe o valor da comissão do vendedor sempre arredondado para o próximo número inteiro acima.

SELECT nome, comissao, CEIL(comissao) AS comissao_teto FROM vendedor;


FLOOR() - Arredondamento para Baixo
Exibe a comissão do vendedor sempre arredondada para o número inteiro abaixo.

SELECT nome, comissao, FLOOR(comissao) AS comissao_piso FROM vendedor;


MOD() - Resto da Divisão
Verifica se a quantidade em estoque do produto é par ou ímpar (se o resto da divisão por 2 for 0, é par).

SELECT descricao, qtde, MOD(qtde, 2) AS resto_divisao_por_2 FROM produto;


POWER() - Potenciação
Apenas como exemplo matemático, eleva a quantidade do item vendido ao quadrado.

SELECT id_produto, qtde, POWER(qtde, 2) AS qtde_ao_quadrado FROM item_venda;


ABS() - Valor Absoluto (Sempre positivo)
Garante que o resultado de uma subtração não seja negativo (ex: diferença entre quantidade mínima e quantidade em estoque).

SELECT descricao, qtde, qtde_min, ABS(qtde_min - qtde) AS diferenca_absoluta FROM produto;


GREATEST() - O maior valor de uma lista
Compara a `qtde` atual com a `qtde_min` e retorna qual dos dois números é o maior.

SELECT descricao, qtde, qtde_min, GREATEST(qtde, qtde_min) AS maior_valor FROM produto;


LEAST() - O menor valor de uma lista
Compara a quantidade máxima permitida (`qtde_max`) e a atual, retornando a menor.

SELECT descricao, qtde, qtde_max, LEAST(qtde, qtde_max) AS menor_valor FROM produto;


-- 3. Funções de Data e Hora

-- CURRENT_DATE e CURRENT_TIMESTAMP - Data e Hora Atuais
-- Mostra a data de nascimento do cliente lado a lado com a data de hoje.

SELECT nome, data_nasc, CURRENT_DATE AS hoje, CURRENT_TIMESTAMP AS data_hora_agora FROM cliente;


AGE() - Idade / Tempo Decorrido
Calcula a idade exata (anos, meses e dias) de cada vendedor.

SELECT nome, data_nasc, AGE(CURRENT_DATE, data_nasc) AS idade_exata FROM vendedor;


EXTRACT(YEAR FROM...) - Extração de Ano
Pega apenas o ano de nascimento dos clientes (ideal para agrupar clientes por ano).

SELECT nome, data_nasc, EXTRACT(YEAR FROM data_nasc) AS ano_nascimento FROM cliente;


EXTRACT(MONTH FROM...) - Extração de Mês
Retorna apenas o mês em que a venda foi realizada, útil para relatórios mensais.

SELECT id_venda, data_venda, EXTRACT(MONTH FROM data_venda) AS mes_da_venda FROM venda;


TO_CHAR() - Formatação de Data para Texto
Converte o Timestamp da venda para o formato amigável brasileiro (DD/MM/YYYY HH24:MI).

SELECT id_venda, data_venda, TO_CHAR(data_venda, 'DD/MM/YYYY HH24:MI') AS data_formatada FROM venda;


Cálculos Simples (+ e -) com Dias
Calcula quando será/foi o vencimento de uma garantia de 30 dias a partir da data de venda.

SELECT id_venda, data_venda, (data_venda + INTERVAL '30 days') AS vencimento_garantia FROM venda;


Subtração de Datas (Dias de Vida)
Calcula quantos dias os clientes já viveram subtraindo a data de nascimento da data atual.

SELECT nome, data_nasc, (CURRENT_DATE - data_nasc) AS dias_de_vida FROM cliente;


DATE_PART() - Alternativa ao Extract
Obtém o dia do mês que a venda foi realizada.

SELECT id_venda, data_venda, DATE_PART('day', data_venda) AS dia_da_venda FROM venda;


DATE_TRUNC() - Arredondamento de Datas
Arredonda a data da venda para o primeiro dia do respectivo mês (ótimo para agrupamentos contábeis).

SELECT id_venda, data_venda, DATE_TRUNC('month', data_venda) AS primeiro_dia_mes_venda FROM venda;


DATE() - Removendo a Hora do Timestamp
A coluna `data_venda` da sua tabela `venda` é um `timestamp` (possui horas). Com a função DATE(), pegamos estritamente a data.

SELECT id_venda, data_venda AS com_hora, DATE(data_venda) AS apenas_data FROM venda;
