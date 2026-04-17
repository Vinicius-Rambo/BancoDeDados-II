# Funções

Link do DOC: ![link](https://docs.google.com/document/d/1OhMnvWHXKIe5ENwaXXcuKM96oEXiXvRjjrKhmHgKXwI/edit?tab=t.0)
---

## 1. Funções para Manipulação de Strings (Textos)

#### UPPER() - Maiúsculas

```sql
SELECT nome, UPPER(nome) AS nome_maiusculo FROM cliente;
```
Transforma todo o nome dos clientes em letras maiúsculas

#### LOWER() - Minusculas
```sql 
SELECT nome, email, LOWER(email) AS email_padronizado FROM vendedor;
```
Garante que todos os e-mails dos vendedores apareçam em minúsculas (ideal para padronização de login).

#### INITCAP() - Letra Capitular
```sql
SELECT descricao, INITCAP(descricao) AS descricao_bonita FROM produto;
```
Deixa a primeira letra de cada palavra maiúscula na descrição do produto.

#### LENGTH() - Tamanho do Texto
```sql
SELECT descricao, LENGTH(descricao) AS tamanho_descricao FROM produto;
```
Conta quantos caracteres tem a descrição de cada produto. Pode ser usado para achar descrições muito curtas.

#### SUBSTRING() - Extração de Pedaços
```sql
SELECT nome, cpf, SUBSTRING(cpf FROM 1 FOR 3) AS inicio_cpf FROM cliente;
```
Pega apenas os 3 primeiros caracteres do CPF do cliente

#### REPLACE() - Substituição de Caracteres
```sql
SELECT cpf, REPLACE(cpf, '-', '') AS cpf_sem_traco FROM cliente;
```
Remove o traço do CPF dos clientes, substituindo-o por nada (vazio).

#### CONCAT() (ou `||`) - Concatenação (Junção)
```sql
SELECT nome, fone, CONCAT(nome, ' - Contato: ', fone) AS info_contato FROM cliente;
```
Cria uma frase amigável juntando o nome do cliente e seu telefone.

#### SPLIT_PART() - Divisão por delimitador
```sql
SELECT nome, SPLIT_PART(nome, ' ', 1) AS primeiro_nome FROM cliente;
```
Extrai apenas o primeiro nome do cliente (divide por espaço e pega a primeira parte).

#### POSITION()  / STRPOS() - Posição de um Caractere
```sql
SELECT email, POSITION('@' IN email) AS posicao_arroba FROM cliente;
```
Descobre em qual posição está o arroba (`@`) no e-mail do client

#### RIGHT() e LEFT()  - Pegando pelas bordas
```sql
SELECT nome, cpf, RIGHT(cpf, 2) AS digito_verificador FROM cliente;
```
Pega apenas os últimos 2 dígitos do CPF do cliente usando a função RIGHT (disponível nas versões recentes do Postgres).

## 2. Funções para Tipos de Dados Numéricos

#### Operadores Matemáticos Básicos (+, -, *, /)
```sql
SELECT descricao, preco, desconto, (preco - desconto) AS preco_final FROM produto;
```
Calcula o preço do produto subtraindo o valor do desconto.

#### ROUND() - Arredondamento com casas decimais
```sql
SELECT descricao, preco, ROUND((preco * 1.10), 2) AS preco_com_acrescimo FROM produto;
```
Aplica um acréscimo de 10% no preço dos produtos e arredonda para 2 casas decimais.

#### TRUNC() - Truncamento (corta sem arredondar)
```sql
SELECT nome, salario, TRUNC(salario, 0) AS salario_inteiro FROM vendedor;
```
Corta os centavos do salário do vendedor, retornando apenas a parte inteira.

#### CEIL() - Arredondamento para Cima
```sql
SELECT nome, comissao, CEIL(comissao) AS comissao_teto FROM vendedor;
```
Exibe o valor da comissão do vendedor sempre arredondado para o próximo número inteiro acima.

#### Floor() - Arredondamento para Baixo
```sql
SELECT nome, comissao, FLOOR(comissao) AS comissao_piso FROM vendedor;
```
Exibe a comissão do vendedor sempre arredondada para o número inteiro abaixo.

#### MOD() - Resto da Divisão
```sql
SELECT descricao, qtde, MOD(qtde, 2) AS resto_divisao_por_2 FROM produto;
```
Verifica se a quantidade em estoque do produto é par ou ímpar (se o resto da divisão por 2 for 0, é par).

#### POWER() - Potenciação
```sql
SELECT id_produto, qtde, POWER(qtde, 2) AS qtde_ao_quadrado FROM item_venda;
```
Apenas como exemplo matemático, eleva a quantidade do item vendido ao quadrado.

#### ABS() - Valor Absoluto (Sempre positivo)
```sql
SELECT descricao, qtde, qtde_min, ABS(qtde_min - qtde) AS diferenca_absoluta FROM produto;
```
Garante que o resultado de uma subtração não seja negativo (ex: diferença entre quantidade mínima e quantidade em estoque).

#### GREATEST() - O maior valor de uma lista
```sql
SELECT descricao, qtde, qtde_min, GREATEST(qtde, qtde_min) AS maior_valor FROM produto;
```
Compara a `qtde` atual com a `qtde_min` e retorna qual dos dois números é o maior.

#### LEAST() - O menor valor de uma lista
```sql
SELECT descricao, qtde, qtde_max, LEAST(qtde, qtde_max) AS menor_valor FROM produto;
```
Compara a quantidade máxima permitida (`qtde_max`) e a atual, retornando a menor.

## 3. Funções de Data e Hora

#### CURRENT_DATE e CURRENT_TIMESTAMP - Data e Hora Atuais
```sql
SELECT nome, data_nasc, CURRENT_DATE AS hoje, CURRENT_TIMESTAMP AS data_hora_agora FROM cliente;
```
Mostra a data de nascimento do cliente lado a lado com a data de hoje.

#### AGE() - Idade/Tempo Decorrido
```sql
SELECT nome, data_nasc, AGE(CURRENT_DATE, data_nasc) AS idade_exata FROM vendedor;
```
Calcula a idade exata (anos, meses e dias) de cada vendedor.

#### EXTRACT(YEAR FROM...) - Extração de Ano
```sql
SELECT nome, data_nasc, EXTRACT(YEAR FROM data_nasc) AS ano_nascimento FROM cliente;
```
Pega apenas o ano de nascimento dos clientes (ideal para agrupar clientes por ano).

#### EXTRACT(MONTH FROM...) - Extração de Mês
```sql
SELECT id_venda, data_venda, EXTRACT(MONTH FROM data_venda) AS mes_da_venda FROM venda;
```
Retorna apenas o mês em que a venda foi realizada, útil para relatórios mensais.

#### TO_CHAR() - Formatação de Data para Texto
```sql
SELECT id_venda, data_venda, TO_CHAR(data_venda, 'DD/MM/YYYY HH24:MI') AS data_formatada FROM venda;
```
Converte o Timestamp da venda para o formato amigável brasileiro (DD/MM/YYYY HH24:MI).

#### Cálculos Simples (+ e -) com Dias
```sql
SELECT id_venda, data_venda, (data_venda + INTERVAL '30 days') AS vencimento_garantia FROM venda;
```
Calcula quando será/foi o vencimento de uma garantia de 30 dias a partir da data de venda.

#### Subtração de Datas (Dias de Vida)
```sql
SELECT nome, data_nasc, (CURRENT_DATE - data_nasc) AS dias_de_vida FROM cliente;
```
Calcula quantos dias os clientes já viveram subtraindo a data de nascimento da data atual.

#### DATE_PART() - Alternativa ao Extract
```sql
SELECT id_venda, data_venda, DATE_PART('day', data_venda) AS dia_da_venda FROM venda;
```
Obtém o dia do mês que a venda foi realizada.

#### DATE_TRUNC() - Arredondamento de Datas
```sql
SELECT id_venda, data_venda, DATE_TRUNC('month', data_venda) AS primeiro_dia_mes_venda FROM venda;
```
Arredonda a data da venda para o primeiro dia do respectivo mês (ótimo para agrupamentos contábeis).

#### DATE() - Removendo a Hora do Timestamp
```sql
SELECT id_venda, data_venda AS com_hora, DATE(data_venda) AS apenas_data FROM venda;
```
A coluna `data_venda` da sua tabela `venda` é um `timestamp` (possui horas). Com a função DATE(), pegamos estritamente a data.

---

Para a lista de exercicios: [[Exercicios.md]]