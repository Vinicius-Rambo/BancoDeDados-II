### Estrutura básica de uma function
```sql
CREATE OR REPLACE FUNCTION nome_funcao(parametros)
RETURNS tipo AS $$
DECLARE
   -- variáveis
BEGIN
   -- lógica
   RETURN valor;
END;
$$ LANGUAGE plpgsql;
```

### Variáveis (DECLARE)
```sql
DECLARE
   idade INTEGER;
   nome TEXT;
   salario NUMERIC := 1000;
```

##### Exemplo:

```sql
CREATE OR REPLACE FUNCTION exemplo_variavel()
RETURNS INTEGER AS $$
DECLARE
   x INTEGER := 10;
BEGIN
   x := x + 5;
   RETURN x;
END;
$$ LANGUAGE plpgsql;
```

### Parâmetros

```sql
CREATE FUNCTION soma(a INTEGER, b INTEGER)
RETURNS INTEGER AS $$
BEGIN
   RETURN a + b;
END;
$$ LANGUAGE plpgsql;
```
**Chamada**: SELECT soma(2, 3);

### IF/ELSE 

```sql
CREATE FUNCTION verifica_idade(idade INTEGER)
RETURNS TEXT AS $$
BEGIN
   IF idade >= 18 THEN
       RETURN 'Maior de idade';
   ELSE
       RETURN 'Menor de idade';
   END IF;
END;
$$ LANGUAGE plpgsql;
```

Versão com **ELSIF**:
```sql
IF idade < 12 THEN
   RETURN 'Criança';
ELSIF idade < 18 THEN
   RETURN 'Adolescente';
ELSE
   RETURN 'Adulto';
END IF;
```
![Vídeo Aula](https://youtu.be/g31YjPy4SLQ?si=IWM75-8nLBN8fAzF)


### While

```sql
CREATE FUNCTION contador()
RETURNS INTEGER AS $$
DECLARE
   i INTEGER := 1;
BEGIN
   WHILE i <= 5 LOOP
       i := i + 1;
   END LOOP;

   RETURN i;
END;
$$ LANGUAGE plpgsql;
```

### FOR

```sql
CREATE FUNCTION soma_loop()
RETURNS INTEGER AS $$
DECLARE
   total INTEGER := 0;
BEGIN
   FOR i IN 1..5 LOOP
       total := total + i;
   END LOOP;

   RETURN total;
END;
$$ LANGUAGE plpgsql;
```


