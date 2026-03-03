
CREATE TABLE IF NOT EXISTS public.categoria
(
    id_categoria serial NOT NULL,
    categoria character varying(80) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT categoria_pkey PRIMARY KEY (id_categoria)
);

CREATE TABLE IF NOT EXISTS public.cliente
(
    id_cliente integer NOT NULL DEFAULT nextval('cliente_id_clientes_seq'::regclass),
    nome character varying(80) COLLATE pg_catalog."default" NOT NULL,
    cpf character varying(11) COLLATE pg_catalog."default" NOT NULL,
    email character varying(80) COLLATE pg_catalog."default" NOT NULL,
    telefone character varying(11) COLLATE pg_catalog."default" NOT NULL,
    endereco integer NOT NULL,
    CONSTRAINT cliente_pkey PRIMARY KEY (id_cliente)
);

CREATE TABLE IF NOT EXISTS public.endereco
(
    id_endereco serial NOT NULL,
    cep character varying(8) COLLATE pg_catalog."default" NOT NULL,
    endereco character varying(80) COLLATE pg_catalog."default",
    CONSTRAINT endereco_pkey PRIMARY KEY (id_endereco)
);

CREATE TABLE IF NOT EXISTS public.estoque
(
    id_estoque serial NOT NULL,
    quantidade integer NOT NULL,
    produto integer NOT NULL,
    fornecedor integer NOT NULL,
    CONSTRAINT estoque_pkey PRIMARY KEY (id_estoque)
);

CREATE TABLE IF NOT EXISTS public.fornecedor
(
    id_fornecedor serial NOT NULL,
    nome character varying(80) COLLATE pg_catalog."default" NOT NULL,
    contato character varying(11) COLLATE pg_catalog."default" NOT NULL,
    cnpj character varying(14) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT fornecedor_pkey PRIMARY KEY (id_fornecedor)
);

CREATE TABLE IF NOT EXISTS public.itens_venda
(
    id_itens_venda serial NOT NULL,
    quantidade integer NOT NULL,
    preco_unitario integer NOT NULL,
    produto integer NOT NULL,
    venda integer NOT NULL,
    CONSTRAINT itens_venda_pkey PRIMARY KEY (id_itens_venda)
);

CREATE TABLE IF NOT EXISTS public.marca
(
    id_marca serial NOT NULL,
    nome character varying(80) COLLATE pg_catalog."default" NOT NULL,
    cod_marca character varying(80) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT marca_pkey PRIMARY KEY (id_marca)
);

CREATE TABLE IF NOT EXISTS public.pagamento
(
    id_pagamento serial NOT NULL,
    forma_pagamento character varying(9) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pagamento_pkey PRIMARY KEY (id_pagamento)
);

CREATE TABLE IF NOT EXISTS public.produto
(
    id_produto serial NOT NULL,
    nome character varying(80) COLLATE pg_catalog."default" NOT NULL,
    descricao character varying(120) COLLATE pg_catalog."default" NOT NULL,
    preco double precision NOT NULL,
    cod_serie character varying(80) COLLATE pg_catalog."default" NOT NULL,
    categoria integer NOT NULL,
    marca integer NOT NULL,
    CONSTRAINT produto_pkey PRIMARY KEY (id_produto)
);

CREATE TABLE IF NOT EXISTS public.status
(
    id_status serial NOT NULL,
    status_atual character varying(9) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT status_pkey PRIMARY KEY (id_status)
);

CREATE TABLE IF NOT EXISTS public.venda
(
    id_venda serial NOT NULL,
    data date NOT NULL,
    valor_total double precision NOT NULL,
    cliente integer NOT NULL,
    pagamento integer NOT NULL,
    status integer NOT NULL,
    CONSTRAINT venda_pkey PRIMARY KEY (id_venda)
);

ALTER TABLE IF EXISTS public.cliente
    ADD CONSTRAINT cliente_endereco_fkey FOREIGN KEY (endereco)
    REFERENCES public.endereco (id_endereco) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.estoque
    ADD CONSTRAINT estoque_fornecedor_fkey FOREIGN KEY (fornecedor)
    REFERENCES public.fornecedor (id_fornecedor) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.estoque
    ADD CONSTRAINT estoque_produto_fkey FOREIGN KEY (produto)
    REFERENCES public.produto (id_produto) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.itens_venda
    ADD CONSTRAINT itens_venda_produto_fkey FOREIGN KEY (produto)
    REFERENCES public.produto (id_produto) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.itens_venda
    ADD CONSTRAINT itens_venda_venda_fkey FOREIGN KEY (venda)
    REFERENCES public.venda (id_venda) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.produto
    ADD CONSTRAINT produto_categoria_fkey FOREIGN KEY (categoria)
    REFERENCES public.categoria (id_categoria) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.produto
    ADD CONSTRAINT produto_marca_fkey FOREIGN KEY (marca)
    REFERENCES public.marca (id_marca) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.venda
    ADD CONSTRAINT venda_cliente_fkey FOREIGN KEY (cliente)
    REFERENCES public.cliente (id_cliente) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.venda
    ADD CONSTRAINT venda_pagamento_fkey FOREIGN KEY (pagamento)
    REFERENCES public.pagamento (id_pagamento) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.venda
    ADD CONSTRAINT venda_status_fkey FOREIGN KEY (status)
    REFERENCES public.status (id_status) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

END;
