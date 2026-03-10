## Contexto do Problema

Empresa fictícia: **TechFlow**  
Segmento: Venda de hardwares e periféricos.

Objetivo da atividade:  
Modelar o banco de dados com base nos requisitos de negócio fornecidos e criar o DER (Diagrama Entidade-Relacionamento).
Resumo do problema: [[problema.pdf]] 
26/02/2026

---
# PSQL

Utilizando o **PSQL**, desenvolvi toda a estrutura do banco de dados, criando as tabelas, definindo as chaves primárias e estabelecendo os relacionamentos por meio de chaves estrangeiras.
###### Database
```sql
CREATE DATABASE techFlow; --Cria a database
\c techFlow               --Acessa a database 
```

###### Primeiras tabelas (Marca e Categoria)
```sql
CREATE TABLE marca(
    id_marca SERIAL PRIMARY KEY,
    nome VARCHAR(80) NOT NULL,
    cod_marca VARCHAR(80) NOT NULL UNIQUE
);

CREATE TABLE categoria(
    id_categoria SERIAL PRIMARY KEY,
    nome VARCHAR(80) NOT NULL
);
```

###### Fornecedor, Produto e Estoque.
```sql
CREATE TABLE fornecedor(
    id_fornecedor SERIAL PRIMARY KEY,
    nome VARCHAR(80) NOT NULL,
    contato VARCHAR(11) NOT NULL,
    cnpj VARCHAR(14) NOT NULL UNIQUE
);

CREATE TABLE produto(
    id_produto SERIAL PRIMARY KEY,
    nome VARCHAR(80) NOT NULL,
    descricao VARCHAR(120) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    cod_serie VARCHAR(80) NOT NULL UNIQUE,
    
    id_categoria INT NOT NULL, --Id de categoria
    id_marca INT NOT NULL,     --Id de Marca.

	    FOREIGN KEY (id_categoria) REFERENCES (id_categoria), 
	    FOREIGN KEY (id_marca) REFERENCES marca(id_marca)
);

CREATE TABLE estoque(
    id_estoque SERIAL PRIMARY KEY,
    quantidade INT NOT NULL,

    id_produto INT NOT NULL, --Id de Produto
    id_fornecedor INT NOT NULL, -- Id de fornecedor

    FOREIGN KEY (id_produto) REFERENCES produto(id_produto),
    FOREIGN KEY (id_fornecedor) REFERENCES (id_fornecedor)
);

```
 
###### Endereço
```sql
CREATE TABLE endereco(
    id_endereco SERIAL PRIMARY KEY,
    cep VARCHAR(8) NOT NULL,
    endereco VARCHAR(80) NOT NULL
);
```

###### Cliente, Status e Pagamento
```sql
CREATE TABLE cliente(
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(80) NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    email VARCHAR(80) NOT NULL,
    telefone VARCHAR(11) NOT NULL,

    id_endereco INT NOT NULL,

    FOREIGN KEY (id_endereco) REFERENCES endereco(id_endereco)
);

CREATE TABLE status(
    id_status SERIAL PRIMARY KEY,
    status_atual VARCHAR(20) NOT NULL
);

CREATE TABLE pagamento(
    id_pagamento SERIAL PRIMARY KEY,    
    forma_pagamento VARCHAR(20) NOT NULL
);

```
 
###### Venda e Itens de venda.
```sql
CREATE TABLE venda(
    id_venda SERIAL PRIMARY KEY,
    data DATE NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL,

    id_cliente INT NOT NULL,
    id_pagamento INT NOT NULL,
    id_status INT NOT NULL,

    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_pagamento) REFERENCES pagamento(id_pagamento),
    FOREIGN KEY (id_status) REFERENCES status(id_status)
);

CREATE TABLE itens_venda(
    id_itens_venda SERIAL PRIMARY KEY,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,

    id_produto INT NOT NULL,
    id_venda INT NOT NULL,

    FOREIGN KEY (id_produto) REFERENCES produto(id_produto),
    FOREIGN KEY (id_venda) REFERENCES venda(id_venda)
);
```

Para fins de teste, foi criada a massaDados.sql com auxílio de IA
[Baixar massaDados.sql](massaDados.sql)

---
# pgAdmin

Usando o pgAdmin, fiz a vizualização da minha database exportei a forma de relacionamento do banco.

![Imagem do banco](banco.png)
- - -
## Próxima aula: 
Revisão dos conceitos gerais de banco de dados com o professor substituto temporário Itamar:  [[Revisão II]]