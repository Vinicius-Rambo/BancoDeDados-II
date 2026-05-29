
-- 1. CRIAR O BANCO DE DADOS
CREATE DATABASE loja_esportiva;

-- Tabela para armazenar variáveis globais (ex: Multa por Atraso)
CREATE TABLE configuracoes (
    id SERIAL PRIMARY KEY,
    chave VARCHAR(50) UNIQUE NOT NULL,
    valor_percentual DECIMAL(5,2) NOT NULL
);

-- Inserindo a multa padrão (ex: 2%)
INSERT INTO configuracoes (chave, valor_percentual) VALUES ('MULTA_ATRASO_PARCELA', 2.00);

-- Tabela para regras dinâmicas de parcelamento (ex: 2x -> 5%)
CREATE TABLE regras_parcelamento (
    qtd_parcelas INT PRIMARY KEY,
    percentual_acrescimo DECIMAL(5,2) NOT NULL
);

-- Inserindo os exemplos solicitados
INSERT INTO regras_parcelamento (qtd_parcelas, percentual_acrescimo) 
VALUES (1, 0.00), (2, 5.00), (3, 7.00), (4, 8.00);

-- Entidades

CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE,
    rg VARCHAR(20),
    endereco_completo VARCHAR(255),
    telefone VARCHAR(20)
);

CREATE TABLE vendedores (
    codigo SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    endereco_completo VARCHAR(255),
    telefone VARCHAR(20),
    celular VARCHAR(20),
    salario_base DECIMAL(10,2) NOT NULL
);

CREATE TABLE fornecedores (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cnpj VARCHAR(20) UNIQUE NOT NULL,
    telefone VARCHAR(20)
);

CREATE TABLE produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco_venda DECIMAL(10,2) NOT NULL,
    percentual_comissao DECIMAL(5,2) NOT NULL, -- Comissão varia por produto
    estoque_atual INT NOT NULL DEFAULT 0,
    estoque_minimo INT NOT NULL DEFAULT 5,
    qtd_ideal_recompra INT NOT NULL DEFAULT 10
);


-- Relacionamentos e movimentações

-- Gerenciamento de Fornecedores e Tempo de Entrega por Produto
CREATE TABLE fornecedor_produto (
    fornecedor_id INT REFERENCES fornecedores(id),
    produto_id INT REFERENCES produtos(id),
    tempo_entrega_dias INT NOT NULL,
    PRIMARY KEY (fornecedor_id, produto_id)
);

-- Cabeçalho da Venda
CREATE TABLE vendas (
    id SERIAL PRIMARY KEY,
    vendedor_id INT NOT NULL REFERENCES vendedores(codigo),
    cliente_id INT REFERENCES clientes(id), -- Aceita NULL para "vendas rápidas/dinheiro"
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_venda DECIMAL(10,2) DEFAULT 0.00,
    tipo_pagamento VARCHAR(20) CHECK (tipo_pagamento IN ('A_VISTA', 'A_PRAZO')),
    status VARCHAR(20) DEFAULT 'EM_ABERTO'
);

-- Itens da Venda
CREATE TABLE itens_venda (
    id SERIAL PRIMARY KEY,
    venda_id INT NOT NULL REFERENCES vendas(id),
    produto_id INT NOT NULL REFERENCES produtos(id),
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    valor_comissao DECIMAL(10,2) DEFAULT 0.00
);

-- Parcelamento
CREATE TABLE parcelas_venda (
    id SERIAL PRIMARY KEY,
    venda_id INT NOT NULL REFERENCES vendas(id),
    numero_parcela INT NOT NULL,
    data_vencimento DATE NOT NULL,
    valor_parcela DECIMAL(10,2) NOT NULL,
    data_pagamento DATE,
    valor_pago DECIMAL(10,2)
);

--A 

CREATE OR REPLACE FUNCTION finaliza_venda(p_venda_id INT, p_qtd_parcelas INT)
RETURNS VOID AS $$
DECLARE
    v_total_itens DECIMAL(10,2);
    v_percentual_acrescimo DECIMAL(5,2) := 0;
    v_total_final DECIMAL(10,2);
    v_valor_parcela DECIMAL(10,2);
    v_item RECORD;
BEGIN
    -- 1. Calcula o total bruto dos itens
    SELECT COALESCE(SUM(quantidade * preco_unitario), 0) INTO v_total_itens
    FROM itens_venda WHERE venda_id = p_venda_id;

    -- 2. Busca a regra de juros para vendas a prazo
    IF p_qtd_parcelas > 1 THEN
        SELECT percentual_acrescimo INTO v_percentual_acrescimo
        FROM regras_parcelamento WHERE qtd_parcelas = p_qtd_parcelas;
        
        IF NOT FOUND THEN
            RAISE EXCEPTION 'Regra para % parcelas não configurada.', p_qtd_parcelas;
        END IF;
    END IF;

    -- Aplica o acréscimo
    v_total_final := v_total_itens * (1 + (v_percentual_acrescimo / 100));

    -- 3. Atualiza o cabeçalho da Venda
    UPDATE vendas
    SET total_venda = v_total_final,
        tipo_pagamento = CASE WHEN p_qtd_parcelas = 1 THEN 'A_VISTA' ELSE 'A_PRAZO' END,
        status = 'FINALIZADA'
    WHERE id = p_venda_id;

    -- 4. Gera as parcelas (se houver)
    IF p_qtd_parcelas > 0 THEN
        v_valor_parcela := v_total_final / p_qtd_parcelas;
        FOR i IN 1..p_qtd_parcelas LOOP
            INSERT INTO parcelas_venda (venda_id, numero_parcela, data_vencimento, valor_parcela)
            VALUES (p_venda_id, i, CURRENT_DATE + (i * 30), v_valor_parcela);
        END LOOP;
    END IF;

    -- 5. Processa cada item: baixa estoque e calcula comissão
    FOR v_item IN SELECT iv.id, iv.produto_id, iv.quantidade, iv.preco_unitario, p.percentual_comissao 
                  FROM itens_venda iv
                  JOIN produtos p ON iv.produto_id = p.id
                  WHERE iv.venda_id = p_venda_id LOOP
        
        -- Baixa de Estoque
        UPDATE produtos 
        SET estoque_atual = estoque_atual - v_item.quantidade 
        WHERE id = v_item.produto_id;

        -- Registra a comissão gerada para o vendedor neste item exato
        UPDATE itens_venda 
        SET valor_comissao = (v_item.quantidade * v_item.preco_unitario) * (v_item.percentual_comissao / 100)
        WHERE id = v_item.id;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

--B 

CREATE OR REPLACE FUNCTION obter_resumo_venda(p_venda_id INT)
RETURNS TABLE (
    numero_venda INT, 
    total DECIMAL(10,2), 
    data_venda DATE, 
    hora_venda TIME, 
    nome_cliente VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        v.id,
        v.total_venda,
        v.data_hora::DATE,
        v.data_hora::TIME,
        COALESCE(c.nome, 'CLIENTE NÃO IDENTIFICADO (VENDA RÁPIDA)')::VARCHAR
    FROM vendas v
    LEFT JOIN clientes c ON v.cliente_id = c.id
    WHERE v.id = p_venda_id;
END;
$$ LANGUAGE plpgsql;

-- C

CREATE OR REPLACE FUNCTION relatorio_necessidade_compras()
RETURNS TABLE (
    id_produto INT, 
    nome_produto VARCHAR, 
    estoque_atual INT, 
    comprar_qtd INT, 
    fornecedor VARCHAR, 
    dias_para_entrega INT
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        p.id,
        p.nome::VARCHAR,
        p.estoque_atual,
        p.qtd_ideal_recompra,
        f.nome::VARCHAR,
        fp.tempo_entrega_dias
    FROM produtos p
    LEFT JOIN fornecedor_produto fp ON p.id = fp.produto_id
    LEFT JOIN fornecedores f ON fp.fornecedor_id = f.id
    WHERE p.estoque_atual <= p.estoque_minimo; 
    -- Retorna apenas produtos que atingiram o limite crítico
END;
$$ LANGUAGE plpgsql;

--D 
CREATE OR REPLACE FUNCTION carga_estoque(p_produto_id INT, p_quantidade INT)
RETURNS VOID AS $$
BEGIN
    UPDATE produtos
    SET estoque_atual = estoque_atual + p_quantidade
    WHERE id = p_produto_id;
END;
$$ LANGUAGE plpgsql;