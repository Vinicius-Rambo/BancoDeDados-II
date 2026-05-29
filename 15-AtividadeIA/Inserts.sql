-- 1. Cadastrando Clientes
INSERT INTO clientes (nome, cpf, rg, endereco_completo, telefone) VALUES 
('João Silva', '111.111.111-11', '1234567-8', 'Rua das Flores, 123, Centro', '(11) 98888-1111'),
('Maria Oliveira', '222.222.222-22', '8765432-1', 'Av. Paulista, 1000, Bela Vista', '(11) 97777-2222');

-- 2. Cadastrando Vendedores
INSERT INTO vendedores (nome, cpf, endereco_completo, telefone, celular, salario_base) VALUES 
('Carlos Souza', '333.333.333-33', 'Rua do Comércio, 50', '(11) 3333-0000', '(11) 96666-3333', 1500.00),
('Ana Lima', '444.444.444-44', 'Rua das Árvores, 99', '(11) 3444-0000', '(11) 95555-4444', 1600.00);

-- 3. Cadastrando Fornecedores
INSERT INTO fornecedores (nome, cnpj, telefone) VALUES 
('Nike Brasil', '11.111.111/0001-11', '(11) 4004-9999'),
('Adidas Sul', '22.222.222/0001-22', '(11) 4004-8888');

-- 4. Cadastrando Produtos 
-- (Note o estoque atual baixo na Chuteira para testarmos o relatório de compras)
INSERT INTO produtos (nome, descricao, preco_venda, percentual_comissao, estoque_atual, estoque_minimo, qtd_ideal_recompra) VALUES 
('Bola de Futebol', 'Bola oficial tamanho 5', 150.00, 5.00, 20, 5, 30),
('Chuteira de Campo', 'Chuteira com travas', 300.00, 10.00, 4, 5, 15),
('Camisa de Time', 'Camisa oficial I', 250.00, 8.00, 10, 3, 20);

-- 5. Relacionando Fornecedor x Produto (Tempo de entrega)
INSERT INTO fornecedor_produto (fornecedor_id, produto_id, tempo_entrega_dias) VALUES 
(1, 1, 7),  -- Bola demora 7 dias
(1, 2, 10), -- Chuteira demora 10 dias
(2, 3, 5);  -- Camisa demora 5 dias

-- 6. Criando Vendas em Aberto (Ainda não finalizadas)
-- Venda 1: Com cliente identificado (João) / Vendedor Carlos
INSERT INTO vendas (vendedor_id, cliente_id) VALUES (1, 1);
-- Itens da Venda 1: 2 Bolas e 1 Camisa
INSERT INTO itens_venda (venda_id, produto_id, quantidade, preco_unitario) VALUES 
(1, 1, 2, 150.00), 
(1, 3, 1, 250.00);

-- Venda 2: Cliente Nulo (Venda Rápida) / Vendedor Ana
INSERT INTO vendas (vendedor_id, cliente_id) VALUES (2, NULL);
-- Itens da Venda 2: 1 Chuteira
INSERT INTO itens_venda (venda_id, produto_id, quantidade, preco_unitario) VALUES 
(2, 2, 1, 300.00);