CREATE DATABASE revisao;    -- Cria a Database.
\c revisao                  -- Acessa a DATABASE. 
\dt                         -- Lista as Tabelas.

                            --Criar a tabela aluno com ID, Nome, Email.
CREATE TABLE aluno(   
    id SERIAL PRIMARY KEY,  
    nome VARCHAR(80) NOT NULL,
    email VARCHAR(255) NOT NULL
);

SELECT * FROM aluno;        --Mostra todos os itens da tabela.

-- Os comandos do psql são muito utilizados pelo administrador do banco, mas para o programador
-- é comum utilziar outras ferramentas, na aula utilizaremos o pgAdmin4 