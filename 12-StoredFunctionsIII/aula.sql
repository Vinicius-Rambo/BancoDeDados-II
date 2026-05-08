-- Active: 1775778814249@@127.0.0.1@5432@ifloja
CREATE OR REPLACE FUNCTION verificar_estoque(
    p_id_produto INTEGER, p_qtde INTEGER 
) RETURNS TEXT 
LANGUAGE plpgsql AS $$
DECLARE 
    v_estoque INTEGER;
BEGIN 
    SELECT qtde
    INTO v_estoque
    FROM produto
    WHERE id_produto = p_id_produto;

    IF v_estoque < p_qtde THEN 
        return 'Estoque Insuficiente';
    END IF;

    RETURN 'Venda Permitida';

END;
$$;


CREATE OR REPLACE FUNCTION estoque_critico (p_id_produto INTEGER) RETURNS TEXT 
LANGUAGE plpgsql AS $$
DECLARE v_qtde INTEGER;
BEGIN 
    SELECT qtde INTO v_qtde FROM produto WHERE id_produto = p_id_produto;
    IF v_qtde <= 2 THEN 
        RETURN 'Estoque CRÍTICO';
    ELSIF v_qtde <= 5 THEN
        RETURN 'Estoque baixo';
    END IF;
    RETURN 'Estoque normal';

END;
$$;

CREATE OR REPLACE FUNCTION estoque_critico(p_id_produto INTEGER) RETURNS text
LANGUAGE plpgSQL AS $$
DECLARE    
    v_qtde INTEGER;
    v_qtde_min INTEGER;
BEGIN 
    SELECT qtde INTO v_qtde FROM produto
    WHERE id_produto = p_id_produto;

    SELECT qtde_min INTO v_qtde_min FROM produto
    WHERE id_produto = p_id_produto;

    IF v_qtde <= FLOOR (v_qtde_min /2 ) THEN
        RETURN 'Estoque critico'
    ELSIF v_qtde <= v_qtde_min THEN
        RETURN 'Estoque baixo';
    END IF;

    RETURN 'Estoque normal';

END;
$$

CREATE OR REPLACE FUNCTION ajustar_preco(p_perc NUMERIC) RETURNS BOOLEAN
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE produto SET preco = preco + (preco * p_perc/100);
    RETURN TRUE;

END; 
$$;


CREATE OR REPLACE FUNCTION inserir_item_venda(p_id_venda INTEGER, p_id_produto INTEGER, p_qtde INTEGER) RETURNS BOOLEAN
LANGUAGE plpgsql AS $$
DECLARE 
    v_preco NUMERIC;
BEGIN
        IF verificar_estoqueb(p_id_produto, p_qtde) THEN
            UPDATE produto SET qtde = qtde - p_qtde
                WHERE id_produto = p_id_produto;

        ELSE 
            RETURN FALSE;

        END IF;
        
        SELECT preco INTO v_preco FROM produto WHERE id_produto = p_id_produto;
        INSERT INTO item_venda(id_venda, id_produto, preco, qtde)
            VALUES(p_id_venda, p_id_produto, v_preco,  p_qtde);
        SELECT SUM(preco * qtde) FROM item_venda WHERE id_venda = p_id_venda;
        UPDATE venda SET total = v_total WHERE id_venda = p_id_venda;
        RETURN TRUE;
END;$$;
