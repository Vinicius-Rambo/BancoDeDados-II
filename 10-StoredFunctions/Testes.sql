--Teste com hello_World 

CREATE OR REPLACE FUNCTION hello_world()
RETURNS text AS $$
DECLARE
   -- variáveis
BEGIN
   -- lógica
   RETURN 'Hello World';
END;
$$ LANGUAGE plpgsql;

SELECT helloworld(); --Para chamar a função criada


CREATE OR REPLACE FUNCTION hello_world2()
RETURNS text AS $$
DECLARE 
    mensagem TEXT := 'Hello World 2!!!';
    notificacao  TEXT := 'Aviso: Hello World foi executado';

BEGIN
    RAISE NOTICE '%', notificacao;
    RETURN mensagem;
END;
$$ LANGUAGE plpgsql

CREATE OR REPLACE FUNCTION hello_world3()
RETURNS text AS $$
DECLARE  
    mensagem TEXT := 'Hello World 3!!!';
BEGIN
    RAISE EXCEPTION 'Cuidado %', mensagem;
    RETURN mensagem;
END;
$$ LANGUAGE plpgsql

CREATE OR REPLACE FUNCTION hello_world4(p_mensagem TEXT)
RETURNS text AS $$
DECLARE  
    v_mensagem TEXT := 'Hello World 4!!!';
BEGIN
    RETURN v_mensagem || ' - ' || p_mensagem;
END;
$$ LANGUAGE plpgsql



