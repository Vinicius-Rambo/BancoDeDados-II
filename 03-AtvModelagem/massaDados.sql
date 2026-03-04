-- Massa de dados criada usando IA.

INSERT INTO marca (nome, cod_marca) VALUES
('Dell', 'DELL001'),
('Samsung', 'SAM001'),
('Logitech', 'LOG001'),
('Lenovo', 'LEN001'),
('HP', 'HP001');

INSERT INTO categoria (nome) VALUES
('Notebook'),
('Monitor'),
('Periférico'),
('Smartphone'),
('Impressora');

INSERT INTO fornecedor (nome, contato, cnpj) VALUES
('Tech Distribuidora', '45999990001', '12345678000101'),
('Global Imports', '45999990002', '22345678000102'),
('Master Eletrônicos', '45999990003', '32345678000103');

INSERT INTO produto (nome, descricao, preco, cod_serie, id_categoria, id_marca) VALUES
('Dell Inspiron 15', 'Notebook 16GB RAM SSD 512GB', 4299.90, 'SN-DELL-001', 1, 1),
('Samsung Odyssey 24"', 'Monitor Gamer 144Hz', 1299.90, 'SN-SAM-001', 2, 2),
('Mouse Logitech G203', 'Mouse Gamer RGB', 149.90, 'SN-LOG-001', 3, 3),
('Lenovo IdeaPad 3', 'Notebook Ryzen 5 8GB SSD 256GB', 3499.90, 'SN-LEN-001', 1, 4),
('HP DeskJet 2774', 'Impressora Multifuncional Wi-Fi', 499.90, 'SN-HP-001', 5, 5),
('Samsung Galaxy A54', 'Smartphone 128GB 5G', 1899.90, 'SN-SAM-002', 4, 2);

INSERT INTO estoque (quantidade, id_produto, id_fornecedor) VALUES
(10, 1, 1),
(15, 2, 2),
(50, 3, 3),
(8, 4, 1),
(20, 5, 2),
(25, 6, 2);

INSERT INTO endereco (cep, endereco) VALUES
('85850000', 'Rua das Palmeiras, 120'),
('85850100', 'Av. Brasil, 455'),
('85850200', 'Rua Paraná, 890');

INSERT INTO cliente (nome, cpf, email, telefone, id_endereco) VALUES
('Carlos Henrique', '11122233344', 'carlos@email.com', '45999887766', 1),
('Mariana Souza', '55566677788', 'mariana@email.com', '45999776655', 2),
('Juliana Martins', '99988877766', 'juliana@email.com', '45999665544', 3);

INSERT INTO status (status_atual) VALUES
('Pendente'),
('Pago'),
('Enviado'),
('Entregue'),
('Cancelado');

INSERT INTO pagamento (forma_pagamento) VALUES
('Cartão de Crédito'),
('Pix'),
('Boleto');

INSERT INTO venda (data, valor_total, id_cliente, id_pagamento, id_status) VALUES
('2026-03-01', 4449.80, 1, 1, 2),
('2026-03-02', 1899.90, 2, 2, 4),
('2026-03-03', 1649.80, 3, 1, 3);

INSERT INTO itens_venda (quantidade, preco_unitario, id_produto, id_venda) VALUES
(1, 4299.90, 1, 1),
(1, 149.90, 3, 1),
(1, 1899.90, 6, 2),
(1, 1299.90, 2, 3),
(1, 349.90, 3, 3);
