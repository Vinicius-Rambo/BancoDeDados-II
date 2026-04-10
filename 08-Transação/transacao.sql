-- Active: 1775778814249@@127.0.0.1@5432@ifloja
BEGIN; --Inicia a transação. 

INSERT INTO venda(id_vendedor, id_cliente, data_venda, total, status) VALUES (2, 2, now(), 0, 0);

SELECT * FROM venda;

INSERT INTO item_venda(id_venda, id_produto, qtde, preco) VALUES --esse select vai dar erro
(7,5,2,SELECT preco FROM produto WHERE id_produto = 5;); --Insert usando subSelect

ROLLBACK; --Caso der erro, tem que dar esse comando para ele voltar ao inicio.

--- Agora vai dar certo:

BEGIN;
INSERT INTO venda(id_vendedor, id_cliente, data_venda, total, status) VALUES (2, 2, now(), 0, 0);

INSERT INTO item_venda(id_venda, id_produto, qtde, preco) VALUES (11, 5, 2, (SELECT preco FROM produto WHERE id_produto = 5)); --SubSelect funcionando

UPDATE produto SET qtde = (SELECT qtde-2 FROM produto WHERE id_produto = 5) WHERE id_produto = 5; 

SELECT * FROM produto WHERE id_produto = 5;

SELECT SUM(qtde*preco) FROM item_venda WHERE id_venda = 11;

UPDATE venda SET total = (SELECT SUM(qtde*preco) FROM item_venda WHERE id_venda = 11) WHERE id_venda = 11;

COMMIT; --Envia quando dá certo. 

--Transação 2.

BEGIN;

INSERT INTO venda(id_vendedor, id_cliente, data_venda, total, status) VALUES (1, 4, now(), 0, 0);

INSERT INTO item_venda(
    id_venda, id_produto, qtde, preco)
    VALUES (12, 9, 1, (SELECT preco FROM produto WHERE id_produto = 9));
INSERT INTO item_venda(
    id_venda, id_produto, qtde, preco)
    VALUES (12, 11, 3, (SELECT preco FROM produto WHERE id_produto = 11));
INSERT INTO item_venda(
    id_venda, id_produto, qtde, preco)
    VALUES (12, 15, 2, (SELECT preco FROM produto WHERE id_produto = 15));

UPDATE produto SET qtde = (SELECT qtde-1 FROM produto WHERE id_produto = 9) WHERE id_produto = 9;
UPDATE produto SET qtde = (SELECT qtde-3 FROM produto WHERE id_produto = 11) WHERE id_produto = 11;
UPDATE produto SET qtde = (SELECT qtde-2 FROM produto WHERE id_produto = 15) WHERE id_produto = 15;

UPDATE venda SET total = (SELECT SUM(qtde*preco) FROM item_venda WHERE id_venda = 12) WHERE id_venda = 12;

ROLLBACK;

--Trannsação 3 

BEGIN;

INSERT INTO venda(id_vendedor, id_cliente, data_venda, total, status) VALUES (1, 4, now(), 0, 0);

INSERT INTO item_venda(
    id_venda, id_produto, qtde, preco)
    VALUES (13, 9, 1, (SELECT preco FROM produto WHERE id_produto = 9));
INSERT INTO item_venda(
    id_venda, id_produto, qtde, preco)
    VALUES (13, 11, 3, (SELECT preco FROM produto WHERE id_produto = 11));
INSERT INTO item_venda(
    id_venda, id_produto, qtde, preco)
    VALUES (13, 15, 2, (SELECT preco FROM produto WHERE id_produto = 15));

UPDATE produto SET qtde = (SELECT qtde-1 FROM produto WHERE id_produto = 9) WHERE id_produto = 9;
UPDATE produto SET qtde = (SELECT qtde-3 FROM produto WHERE id_produto = 11) WHERE id_produto = 11;
UPDATE produto SET qtde = (SELECT qtde-2 FROM produto WHERE id_produto = 15) WHERE id_produto = 15;

UPDATE venda SET total = (SELECT SUM(qtde*preco) FROM item_venda WHERE id_venda = 13) WHERE id_venda = 13;

COMMIT;