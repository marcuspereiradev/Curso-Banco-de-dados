-- Aula8 BD - 02/08/2018

-- Utilizar base de dados da aula anterior.
\c aula7

-- Exibir objetos.
\d

-- Schema - Partições de uma base de dados.

-- Schema atual.
SHOW SEARCH_PATH;

-- Criar novo Schema.
CREATE SCHEMA rh;

-- Selecionar Schema.
SET SEARCH_PATH TO rh;

-- SERIAL - Criação de sequência implícita.
CREATE TABLE funcionario (
	matricula 	SERIAL	 	PRIMARY KEY,
	nome 		VARCHAR(60)	NOT NULL,
	genero 		CHAR		NOT NULL 	CHECK(genero IN('f', 'm')),
	salario		FLOAT		NOT NULL 	CHECK(salario > 1000 AND salario < 20000));

-- Metadados.
\d
\d funcionario
	
DELETE FROM funcionario;
ALTER SEQUENCE funcionario_matricula_seq RESTART;
	
INSERT INTO funcionario(nome, genero, renda) 
	VALUES('Beto', 'm', 4500),
		  ('Rafa', 'f', 4500),
		  ('Duda', 'f', 4500),
		  ('Mila', 'f', 4500),
		  ('Cadu', 'm', 4500),
		  ('Nat', 'f', 4500);
	
SELECT * FROM funcionario;

-- UNION e UNION ALL.

SELECT nome, genero FROM public.aluno
UNION
SELECT nome, genero FROM funcionario;

SELECT matricula, nome, genero FROM funcionario
UNION
SELECT codProfessor, nome, titulacao FROM public.professor;

SELECT nome, genero FROM public.aluno
UNION ALL
SELECT nome, genero FROM funcionario;

SELECT nome, genero, 'Aluno' AS Tipo FROM public.aluno
UNION ALL
SELECT nome, genero, 'Funcionario' FROM funcionario;

SET SEARCH_PATH TO public;

-- Trigger (Gatilho) para evitar redução de notas.

-- 1- Criar função que será execudata pela Trigger.
CREATE FUNCTION fnEvitarReducNota()
	RETURNS TRIGGER AS $$
	BEGIN
		IF OLD.nota1 > NEW.nota1 OR
		   OLD.nota2 > NEW.nota2 OR
		   OLD.nota3 > NEW.nota3 THEN
		   
		   RAISE NOTICE 'Nota1: %', OLD.nota1;
		   RAISE NOTICE 'Nota2: %', OLD.nota2;
		   RAISE NOTICE 'Nota3: %', OLD.nota3;
		   
		   RAISE EXCEPTION 'Notas nao podem ser reduzidas.';
		   
		END IF;   
		RETURN NEW;
	END;
$$
LANGUAGE PLPGSQL;

-- 2- Criar trigger que executa a função.
CREATE TRIGGER tgEvitarReducNota
	BEFORE UPDATE ON alunosInscritos
	FOR EACH ROW
	EXECUTE PROCEDURE fnEvitarReducNota();
	
UPDATE alunosInscritos SET nota2 = 3
	WHERE mat_aluno = 3 AND cod_disc = 2
		AND anoLetivo = 2017;

-- BACKUP
-- No prompt do camando do SO.
cd C:\Program Files\PostgreSQL\9.3\bin

pg_dump -U postgres --inserts aula7 > c:\backup\aula7.txt


-- Restaurar.
-- No prompt do camando do SO.
cd C:\Program Files\PostgreSQL\9.3\bin

psql -U postgres -d aula7 -f c:\backup\aula7.txt





