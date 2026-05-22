CREATE TABLE parcela(
    id_parcela SERIAL NOT NULL, 
    num_parcela INTEGER NOT NULL CHECK(num_parcela >= 1 AND num_parcela <=12) ,
    data_parcela DATE NOT NULL,
    data_pagamento TIMESTAMP NULL,
    valor NUMERIC(7,2) NOT NULL,
    PRIMARY KEY(id_parcela),
    id_venda INTEGER NOT NULL REFERENCES venda(id_venda)
); 



CREATE OR REPLACE FUNCTION parcelar(p_id_venda INTEGER, p_acrescimo NUMERIC, p_num_parcela INTEGER) RETURNS BOOLEAN 
LANGUAGE plpgsql AS $$
DECLARE 
    v_valor_parcela NUMERIC(7,2);
    v_data_venda TIMESTAMP;
    v_valor_venda NUMERIC (7,2);
BEGIN 
    IF p_num_parcela < 2 OR p_num_parcela > 12 THEN
        RETURN FALSE;
    END IF;
    
    SELECT total, data_venda INTO v_valor_venda, v_data_venda FROM venda WHERE id_venda = p_id_venda;
    v_valor_parcela := (v_valor_venda / p_num_parcela) * (1 + (p_acrescimo /100) * p_num_parcela);


    FOR i IN 1..p_num_parcela LOOP
        v_data_venda := DATE(v_data_venda + INTERVAL '1 month');

        INSERT INTO parcela (num_parcela, data_parcela, valor, id_venda) VALUES
        (i, v_data_venda::DATE, v_valor_parcela, p_id_venda);
    END LOOP;
    RETURN TRUE;
END;
$$;

CREATE OR REPLACE FUNCTION parcelar_sem_facada(p_id_venda INTEGER, p_acrescimo NUMERIC, p_num_parcela INTEGER) RETURNS BOOLEAN 
LANGUAGE plpgsql AS $$
DECLARE 
    v_valor_parcela NUMERIC(7,2);
    v_data_venda TIMESTAMP;
    v_valor_venda NUMERIC (7,2);
BEGIN 
    IF p_num_parcela < 2 OR p_num_parcela > 12 THEN
        RETURN FALSE;
    END IF;
    
    SELECT total, data_venda INTO v_valor_venda, v_data_venda FROM venda WHERE id_venda = p_id_venda;
    v_valor_parcela := (v_valor_venda / p_num_parcela) * (1 + p_acrescimo /100);


    FOR i IN 1..p_num_parcela LOOP
        v_data_venda := DATE(v_data_venda + INTERVAL '1 month');

        INSERT INTO parcela (num_parcela, data_parcela, valor, id_venda) VALUES
        (i, v_data_venda::DATE, v_valor_parcela, p_id_venda);
    END LOOP;
    RETURN TRUE;
END;
$$;


SELECT parcelar(3,10,10);

SELECT * FROM parcela;
