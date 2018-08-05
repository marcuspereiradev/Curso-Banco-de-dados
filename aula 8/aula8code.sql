DROP DATABASE aula7;
CREATE DATABASE aula7;
\c aula7

CREATE TABLE aluno (
	matricula 	INTEGER 	PRIMARY KEY,
	nome 		VARCHAR(60)	NOT NULL,
	email 		VARCHAR(50)	NOT NULL,
	genero 		CHAR		NOT NULL,
	dataNasc 	DATE		NOT NULL);
	
CREATE TABLE professor (
	codProfessor 	INTEGER 	PRIMARY KEY,
	nome 			VARCHAR(50)	NOT NULL,
	cpf 			CHAR(14)	NOT NULL	UNIQUE,
	titulacao 		VARCHAR(30)	NOT NULL);
	
CREATE TABLE disciplina (
	codDisciplina 	INTEGER 		PRIMARY KEY,
	nome 			VARCHAR(100)	NOT NULL,
	cargaHr 		INTEGER			NOT NULL,
	cod_prof 		INTEGER			NOT NULL,
	FOREIGN KEY(cod_prof) REFERENCES professor (codProfessor));

CREATE TABLE endereco (
	codEndereco INTEGER 	PRIMARY KEY,
	rua 		VARCHAR(60)	NOT NULL,
	numero 		VARCHAR(10)	NOT NULL,
	bairro 		VARCHAR(60)	NOT NULL,
	cidade 		VARCHAR(60)	NOT NULL,
	mat_aluno 	INTEGER		NOT NULL	UNIQUE,
	FOREIGN KEY(mat_aluno) REFERENCES aluno (matricula));

CREATE TABLE alunosInscritos (
	anoLetivo 	INTEGER,
	cod_disc 	INTEGER,
	mat_aluno 	INTEGER,
	nota1 		FLOAT,
	nota3 		FLOAT,
	nota2 		FLOAT,
	PRIMARY KEY(anoLetivo, cod_disc, mat_aluno),
	FOREIGN KEY(cod_disc) REFERENCES disciplina (codDisciplina),
	FOREIGN KEY(mat_aluno) REFERENCES aluno (matricula));
	
-- Metadados.

-- Exibir as tabelas
\d 

-- Exibir a estrutura das tabelas.
\d aluno
\d endereco
\d professor
\d disciplina
\d alunosInscritos

-- Sequence
CREATE SEQUENCE seqaluno;
CREATE SEQUENCE seqend START WITH 101;
CREATE SEQUENCE seqprof START WITH 1010 INCREMENT BY 10;
CREATE SEQUENCE seqdisc;

-- Inserir dados
INSERT INTO aluno VALUES(NEXTVAL('seqaluno'), 'Leo', 'leo@uol.com', 'm', '1994-06-17'),
						(NEXTVAL('seqaluno'), 'Ana', 'ana@uol.com', 'f', '1998-03-29'),
						(NEXTVAL('seqaluno'), 'Bia', 'bia@aol.com', 'f', '1995-10-06'),
						(NEXTVAL('seqaluno'), 'Edu', 'edu@uol.com', 'm', '1990-08-21'),
						(NEXTVAL('seqaluno'), 'Nat', 'nat@uol.com', 'f', '1989-11-05'),
						(NEXTVAL('seqaluno'), 'Mel', 'mel@aol.com', 'f', '1985-04-30'),
						(NEXTVAL('seqaluno'), 'Rui', 'rui@uol.com', 'm', '1991-10-09');
						
SELECT * FROM aluno;

INSERT INTO endereco VALUES(NEXTVAL('seqend'), 'Rua a', '1550', 'Bairro q', 'Cidade z', 4),
						   (NEXTVAL('seqend'), 'Rua s', '564', 'Bairro w', 'Cidade x', 1),
						   (NEXTVAL('seqend'), 'Rua d', '231', 'Bairro e', 'Cidade c', 2),
						   (NEXTVAL('seqend'), 'Rua f', '2221', 'Bairro r', 'Cidade v', 5),
						   (NEXTVAL('seqend'), 'Rua g', '231', 'Bairro t', 'Cidade v', 7),
						   (NEXTVAL('seqend'), 'Rua h', '431', 'Bairro y', 'Cidade z', 3),
						   (NEXTVAL('seqend'), 'Rua j', '163', 'Bairro u', 'Cidade x', 6);
						
SELECT * FROM endereco;

INSERT INTO professor(codProfessor, nome, cpf, titulacao)
					  VALUES(NEXTVAL('seqprof'), 'Beto', '234.534.534-31', 'Doutorado'),
							(NEXTVAL('seqprof'), 'Rafa', '123.534.534-16', 'Pos Graduacao'),
							(NEXTVAL('seqprof'), 'Duda', '432.534.534-04', 'Mestrado'),
							(NEXTVAL('seqprof'), 'Cadu', '045.534.534-28', 'Graduacao');
							
SELECT * FROM professor;

ALTER TABLE disciplina ALTER COLUMN cod_prof DROP NOT NULL;

DELETE FROM disciplina;

ALTER SEQUENCE seqdisc RESTART;

INSERT INTO disciplina VALUES (NEXTVAL('seqdisc'), 'Logica', 32, 1040);
INSERT INTO disciplina VALUES (NEXTVAL('seqdisc'), 'BD', 32, 1010);
INSERT INTO disciplina VALUES (NEXTVAL('seqdisc'), 'PHP', 60, 1020);
INSERT INTO disciplina VALUES (NEXTVAL('seqdisc'), 'SQL Server', 32, 1020);
INSERT INTO disciplina VALUES (NEXTVAL('seqdisc'), 'BI', 40, 1010);
INSERT INTO disciplina VALUES (NEXTVAL('seqdisc'), 'UML', 20, NULL);
INSERT INTO disciplina VALUES (NEXTVAL('seqdisc'), 'Oracle', 32, 1010);
                               
SELECT * FROM disciplina;

INSERT INTO alunosInscritos(anoLetivo, cod_disc, mat_aluno) VALUES(2017, 4, 2);

SELECT * FROM alunosInscritos;

UPDATE alunosInscritos SET nota1 = 6.5
	WHERE mat_aluno = 2 AND cod_disc = 4
		AND anoLetivo = 2017;

UPDATE alunosInscritos SET nota2 = 7
	WHERE mat_aluno = 2 AND cod_disc = 4
		AND anoLetivo = 2017;
		
UPDATE alunosInscritos SET nota3 = 5
	WHERE mat_aluno = 2 AND cod_disc = 4
		AND anoLetivo = 2017;
		
SELECT * FROM alunosInscritos;

INSERT INTO alunosInscritos VALUES (2017, 3, 2, 7, 5.5, 8);
INSERT INTO alunosInscritos VALUES (2017, 6, 4, 8, 7.5, 5);
INSERT INTO alunosInscritos VALUES (2017, 2, 3, 4, 9.5, 7);
INSERT INTO alunosInscritos VALUES (2017, 7, 1, 5, 7, 6);
INSERT INTO alunosInscritos VALUES (2017, 3, 6, 4, 9, 6);
INSERT INTO alunosInscritos VALUES (2017, 1, 3, 7, 6, 6);
INSERT INTO alunosInscritos VALUES (2017, 2, 2, 3, 5, 7);
INSERT INTO alunosInscritos VALUES (2018, 5, 4, 8, 7, 4);
INSERT INTO alunosInscritos VALUES (2018, 3, 1, 6, 6, 8);
INSERT INTO alunosInscritos VALUES (2018, 5, 2, 7, 4, 6);
INSERT INTO alunosInscritos VALUES (2018, 7, 6, 8, 7, 5);
INSERT INTO alunosInscritos VALUES (2018, 1, 3, 6, 5, 5);
INSERT INTO alunosInscritos VALUES (2018, 2, 2, 5, 8, 7);
INSERT INTO alunosInscritos VALUES (2018, 3, 5, 5, 5.5, 5);
INSERT INTO alunosInscritos VALUES (2018, 4, 1, 7, 8.5, 6);
INSERT INTO alunosInscritos VALUES (2018, 6, 2, 6.5, 8.5, 8);
INSERT INTO alunosInscritos VALUES (2018, 5, 3, 5.5, 5, 8);

SELECT * FROM alunosInscritos;


--------------------------------------------------------------------------------
-- Utilizar base de dados da aula anterior (acima)
\c aula7

-- Exibir objetos
\d

-- Schema - PArtições de uma base de dados
-- Schema atual
SHOW SEARCH_PATH;

-- Criar novo schema
CREATE SCHEMA rh; 

-- Selecionar schema
SET SEARCH_PATH TO rh;

-- Exibir objetos
\d

-- SERIAL - Criação de sequência implicita
CREATE TABLE funcionario (
	matricula 	SERIAL	 	PRIMARY KEY,
	nome 		VARCHAR(60)	NOT NULL,
	genero 		CHAR		NOT NULL,
	renda 		FLOAT		NOT NULL);
	
-- Metadados
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

-- UNION e UNION ALL
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

-- TRIGGER (Gatilho) para evitar redução de notas
-- 1- Criar função que será executada pela Trigger
CREATE FUNCTION fnEvitarReducNota()
	RETURNS TRIGGER AS $$
	BEGIN
	
		IF OLD.nota1 > NEW.nota1 OR
		   OLD.nota2 > NEW.nota2 OR
		   OLD.nota3 > NEW.nota3 THEN
		   
		   RAISE NOTICE 'Nota1: %', OLD.nota1;
		   RAISE NOTICE 'Nota1: %', OLD.nota2;
		   RAISE NOTICE 'Nota1: %', OLD.nota3;
		   
		   RAISE EXCEPTION 'Notas não pode ser reduzidas.';
		   
		END IF;
		
		RETURN NEW;
		
	END;
$$

LANGUAGE PLPGSQL;

-- 2- Criar trigger que executa a função
CREATE TRIGGER tgEvitarReducNota
	BEFORE UPDATE ON alunosInscritos
	FOR EACH ROW
	EXECUTE PROCEDURE fnEvitarReducNota();
	
UPDATE alunosInscritos SET nota2 = 3
	WHERE mat_aluno = 3 AND cod_disc = 2
	AND anoLetivo = 2017;

-- BACKUP
-- No prompt do SO
cd C:\Program Files\PostgreSQL\9.3\bin

pg_dump -U postgres --inserts aula7 > C:\backup\aula7.txt

-- Restaurar
-- No prompt do SO
cd C:\Program Files\PostgreSQL\9.3\bin

psql -U postgres -d aula7 -f C:\backup\aula7.txt