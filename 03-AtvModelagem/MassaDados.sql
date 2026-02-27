-- Massa de dados usando IA.

INSERT INTO status (status_atual) VALUES
('Pendente'),
('Aprovado'),
('Cancelado');

INSERT INTO pagamento (forma_pagamento) VALUES
('Cartão Crédito'),
('Boleto'),
('Pix');

INSERT INTO marca (nome, cod_marca) VALUES
('Samsung', 'SAM001'),
('Apple', 'APP001'),
('Dell', 'DEL001'),
('Lenovo', 'LEN001'),
('Xiaomi', 'XIA001');

INSERT INTO categoria (categoria) VALUES
('Smartphone'),
('Notebook'),
('Monitor'),
('Acessórios'),
('Tablet');

INSERT INTO fornecedor (nome, contato, cnpj) VALUES
('Tech Distribuidora', '11987654321', '12345678000199'),
('Global Eletrônicos', '11912345678', '98765432000188'),
('InfoTech Supply', '11911223344', '45678912000177');

INSERT INTO produto (nome, descricao, preco, cod_serie) VALUES
('Galaxy S23', 'Smartphone Samsung 256GB', 4500.00, 'GS23-256'),
('iPhone 14', 'iPhone 14 128GB', 6000.00, 'IP14-128'),
('Dell Inspiron 15', 'Notebook i7 16GB RAM', 5200.00, 'DELLI15-I7'),
('Monitor LG 24', 'Monitor LED 24 polegadas', 900.00, 'LG24-LED');

INSERT INTO estoque (quantidade) VALUES
(50),
(30),
(15),
(40),
(60);

INSERT INTO endereco (cep, endereco) VALUES
('01001000', 'Rua das Flores, 100'),
('02002000', 'Av. Paulista, 1500'),
('03003000', 'Rua da Tecnologia, 500');

INSERT INTO cliente (nome, cpf, email, telefone) VALUES
('João Silva', '12345678901', 'joao@email.com', '11988887777'),
('Maria Oliveira', '98765432100', 'maria@email.com', '11977776666'),
('Carlos Souza', '11122233344', 'carlos@email.com', '11966665555');

INSERT INTO venda (data, valor_total) VALUES
('2025-05-10', 4500.00),
('2025-05-11', 6000.00),
('2025-05-12', 2700.00);

INSERT INTO itens_venda (quantidade, preco_unitario) VALUES
(1, 4500),
(1, 6000),
(1, 1800);