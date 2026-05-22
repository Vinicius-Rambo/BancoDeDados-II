--1 Verificador de Paridade
--Crie uma função para analisar se um número inteiro qualquer é par ou ímpar.
--A função deve usar como parâmetro de entrada um número e retornar um
--resultado em VARCHAR com a palavra 'PAR' ou 'IMPAR'.

CREATE OR REPLACE FUNCTION verificar_impar(num INTEGER) RETURNS TEXT
LANGUAGE plpgSQL AS $$
BEGIN 
    IF(num % 2) = 0 THEN 
        RETURN 'PAR';
    ELSE   
        RETURN 'IMPAR';
    END IF;
END;
$$;

SELECT verificar_impar(1);

--2. Calculadora de Idade Exata
--Faça uma função que calcule a idade atual de uma pessoa em anos completos,
--usando apenas a sua data de nascimento como base.
--A função deve usar como parâmetro de entrada uma data e retornar um resultado
--em NUMBER com a idade.

CREATE OR REPLACE FUNCTION calcular_exata(data_nasc DATE) RETURNS INT
LANGUAGE plpgSQL AS $$
BEGIN
    RETURN EXTRACT (YEAR FROM AGE(data_nasc))::int;
END;
$$;

--3. Cálculo de Fatorial
--Desenvolva uma função capaz de calcular o fatorial de um número inteiro positivo
--(exemplo: o fatorial de 5 é 5 * 4 * 3 * 2 * 1, que resulta em 120).
--A função deve usar como parâmetro de entrada um número e retornar um
--resultado em NUMBER com o valor do cálculo.

CREATE OR REPLACE FUNCTION calcular_fatorial(num INTEGER) RETURNS INT 
LANGUAGE plpgSQL AS $$
DECLARE 
    resultado BIGINT := 1; --Variavel com grande capacidade pois escala rapido. 
BEGIN
    IF num = 0 THEN --Fatorial de 0 é 1
        RETURN 1;
    END IF;

    FOR i IN 1..num LOOP
        resultado := resultado * i;
    END LOOP;
    RETURN resultado;
END;
$$;

--4. Inversor de Texto
--Escreva uma função que receba uma palavra ou até mesmo uma frase inteira e a
--devolva escrita de trás para frente.
--A função deve usar como parâmetro de entrada um texto em VARCHAR e retornar
--um resultado em VARCHAR com o texto invertido.

CREATE OR REPLACE FUNCTION inversor_de_texto(texto VARCHAR) RETURNS VARCHAR 
LANGUAGE plpgSQL AS $$
BEGIN 
    RETURN REVERSE(texto);
END;
$$;

--5. Saudação por Turno
--Crie uma função que analise uma data e hora informada e retorne uma saudação
--educada de acordo com o turno (manhã, tarde ou noite).
--A função deve usar como parâmetro de entrada uma data e retornar um resultado
--em VARCHAR com 'BOM DIA', 'BOA TARDE' ou 'BOA NOITE'.

CREATE OR REPLACE FUNCTION saudacao_por_turno(data_hora TIMESTAMP) RETURNS VARCHAR
LANGUAGE plpgSQL AS $$
DECLARE
    hora_do_dia INT;
BEGIN 
    hora_do_dia := EXTRACT(HOUR FROM data_hora);

    IF hora_do_dia >= 5 AND hora_do_dia < 12 THEN
        RETURN 'BOM DIA';
    ELSIF hora_do_dia >= 12 AND hora_do_dia < 18 THEN
        RETURN 'BOA TARDE';
    ELSE
        RETURN 'BOA NOITE';
    END IF;
END;
$$;

SELECT saudacao_por_turno('2023-10-27 22:00:00');
SELECT saudacao_por_turno('2023-10-27 08:00:00');
SELECT saudacao_por_turno('2023-10-27 08:00:00');

--6. Somatório de Pares em um Intervalo
--Faça uma função que calcule a soma de todos os números pares que existem
--dentro de um intervalo específico.
--A função deve usar como parâmetros de entrada dois números (um de início e um
--de fim) e retornar um resultado em NUMBER com o valor total da soma.

CREATE OR REPLACE FUNCTION somatorio_pares_intervalo(num1 INT, num2 INT) RETURNS INT
LANGUAGE plpgSQL AS $$
DECLARE
   resultado INT := 0;
BEGIN
    IF num1 < num2 THEN 
        FOR i IN num1..num2 LOOP
            IF(i % 2) = 0 THEN
                resultado := resultado + i;
            END IF;
        END LOOP;
    ELSE 
        FOR i IN num2..num1 LOOP
            IF(i % 2) = 0 THEN
                resultado := resultado + i;
            END IF;
        END LOOP;
    END IF;
    RETURN resultado;
END;
$$;

--7. Validador de E-mail Simples
--Desenvolva uma função para verificar de forma simples se um endereço de e-mail
--é válido, checando se ele possui o símbolo "@" e um ponto posicionado depois
--dele.
--A função deve usar como parâmetro de entrada um texto em VARCHAR e retornar
--um resultado em VARCHAR com a palavra 'VALIDO' ou 'INVALIDO'.

CREATE OR REPLACE FUNCTION validacao_email(email VARCHAR) RETURNS VARCHAR
LANGUAGE plpgSQL AS $$
BEGIN   
    IF POSITION('@' IN email) > 0 AND 
        POSITION ('.' IN substring(email FROM POSITION('@' IN email))) > 0  THEN
            RETURN 'VALIDO';
    ELSE 
        RETURN 'INVALIDO';
    END IF;     
END;
$$;

--8. Contador de Vogais
--Crie uma função que varra um texto e conte exatamente quantas vogais (a, e, i, o,
--u) existem naquela palavra ou frase.
--A função deve usar como parâmetro de entrada um texto em VARCHAR e retornar
--um resultado em NUMBER com a quantidade encontrada.

CREATE OR REPLACE FUNCTION contador_vogal(texto VARCHAR) RETURNS int
LANGUAGE plpgSQL AS $$
DECLARE 
    total_vogais INTEGER := 0;
    i INTEGER;
    caractere CHAR(1);
BEGIN 
    texto := lower(texto);

    FOR i in 1..length(texto) LOOP
        caractere := substring(texto FROM i for 1);
        
        IF caractere = 'a' OR caractere = 'e' OR caractere = 'i' OR caractere = 'o' OR caractere = 'u' THEN
            total_vogais := total_vogais + 1;
        END IF;
    END LOOP;

    RETURN total_vogais;
END;
$$;

--9. Classificador de Dia da Semana
--Escreva uma função para descobrir se uma data específica vai cair em um dia útil
--(segunda a sexta) ou no fim de semana (sábado ou domingo).
--A função deve usar como parâmetro de entrada uma data e retornar um resultado
--em VARCHAR2 com 'DIA UTIL' ou 'FIM DE SEMANA'

CREATE OR REPLACE FUNCTION verificar_dia_util(dia DATE) RETURNS VARCHAR
LANGUAGE plpgSQL AS $$
DECLARE
    num_dia INTEGER := 0;
BEGIN 
    num_dia := EXTRACT(DOW FROM dia);
    IF num_dia > 0 AND num_dia < 6 THEN
        RETURN 'DIA UTIL';
    
    ELSE 
        RETURN 'FIM DE SEMANA';
    END IF;
END;
$$;

--10.Gerador de Código de Matrícula
--Faça uma função que crie um código de matrícula juntando os três primeiros
--caracteres do nome em letras maiúsculas, o ano de nascimento com quatro dígitos
--e a quantidade total de letras do nome (Exemplo: "Carlos" nascido em
--"15/05/1990" resulta em "CAR19906").
--A função deve usar como parâmetros de entrada um texto em VARCHAR e uma
--data e retornar um resultado em VARCHAR com o código gerado.

CREATE OR REPLACE FUNCTION gerador_codigo(nome VARCHAR, data_nasc DATE) RETURNS VARCHAR
LANGUAGE plpgSQL AS $$
DECLARE 
    nomeQuebrado VARCHAR;
    anoNasc VARCHAR;
    quantidade VARCHAR;

BEGIN 
    nomeQuebrado := UPPER(substring(nome FROM 1 for 3));
    anoNasc := EXTRACT(YEAR FROM data_nasc)::VARCHAR;
    quantidade := length(nome)::VARCHAR;

    RETURN concat(nomeQuebrado, anoNasc, quantidade);

END;
$$;
SELECT gerador_codigo('Carlos', '1990-05-15');
SELECT gerador_codigo('Vinicius', '2007-01-15');