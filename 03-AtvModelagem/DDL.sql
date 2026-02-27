CREATE DATABASE techFlow

CREATE TABLE marca(
    id_marca SERIAL PRIMARY KEY NOT NULL,
    nome VARCHAR(80) NOT NULL,
    cod_marca VARCHAR(80) NOT NULL
);

CREATE TABLE categoria(
    id_categoria SERIAL PRIMARY KEY NOT NULL,
    categoria VARCHAR(80) NOT NULL
    
);

CREATE TABLE fornecedor(
    id_fornecedor SERIAL PRIMARY KEY NOT NULL,
    nome VARCHAR(80) NOT NULL,
    contato VARCHAR(11) NOT NULL,
    cnpj VARCHAR(14) NOT NULL   
);

CREATE TABLE produto(
    id_produto SERIAL PRIMARY KEY NOT NULL,
    nome VARCHAR(80) NOT NULL,
    descricao VARCHAR(120) NOT NULL,
    preco FLOAT NOT NULL
    cod_serie VARCHAR(80) NOT NULL UNIQUE,
    --CATEGORIA
    --MARCA
);

CREATE TABLE estoque(
    id_estoque SERIAL PRIMARY KEY NOT NULL
    quantidade int NOT NULL,
    --Produto
    --Fornecedor
);

CREATE TABLE endereco(
    id_endeco SERIAL PRIMARY KEY NOT NULL,
    cep VARCHAR(8) NOT NULL,
    endereco VARCHAR(80) NOT NULL
);

CREATE TABLE cliente(
    id_cliente SERIAL PRIMARY KEY NOT NULL,
    nome VARCHAR(80) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    email VARCHAR(80) NOT NULL,
    telefone VARCHAR(11) NOT NULL,
    --Endereço
);

CREATE TABLE status(
    id_status SERIAL PRIMARY KEY NOT NULL,
    status_atual VARCHAR(9)
);

CREATE TABLE pagamento(
    id_pagamento SERIAL PRIMARY KEY NOT NULL,    
    forma_pagamento VARCHAR(20)
);

CREATE TABLE venda(
    id_venda SERIAL PRIMARY KEY NOT NULL,
    data DATE NOT NULL,
    valor_total FLOAT NOT NULL,
    --cliente
    --Pagamento
    --Status
);

CREATE TABLE itens_venda(
    id_itens_venda SERIAL PRIMARY KEY NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario INT NOT NULL
    --Produto.
    --venda
);