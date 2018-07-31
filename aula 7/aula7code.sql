-- Geração de Modelo físico
-- Sql ANSI 2003 - brModelo.

DROP DATABASE aula7;
CREATE DATABASE aula7;
\c aula7

CREATE TABLE aluno (
codAluno 	INTEGER 		PRIMARY KEY,
nome 		VARCHAR(60)		NOT NULL,
email 		VARCHAR(60)		NOT NULL,
genero 		CHAR			NOT NULL,
dataNasc 	DATE			NOT NULL
);

CREATE TABLE professor (
codProfessor 		INTEGER 			PRIMARY KEY,
nome 				VARCHAR(100)		NOT NULL,
cpf 				CHAR(14)			NOT NULL		UNIQUE,
titulacao 			VARCHAR(30)			NOT NULL	
);

CREATE TABLE disciplina (
codDisciplina 		INTEGER 		PRIMARY KEY,
nome 				VARCHAR(100)	NOT NULL,
cargaHc 			INTEGER			NOT NULL,
cod_prof 			INTEGER			NOT NULL,
FOREIGN KEY(cod_prof) REFERENCES professor (codProfessor)
);

CREATE TABLE endereco (
codEndereco 	INTEGER 		PRIMARY KEY,
rua 			VARCHAR(60)		NOT NULL,
numero 			VARCHAR(60)		NOT NULL,
bairro 			VARCHAR(60)		NOT NULL,
cidade 			VARCHAR(60)		NOT NULL,
mat_aluno 		INTEGER			NOT NULL		UNIQUE,
FOREIGN KEY(mat_aluno) REFERENCES aluno (matricula)
);

CREATE TABLE alunosInscritos (
anoLetivo 		INTEGER,
cod_disc 		INTEGER,
mat_aluno 		INTEGER,
nota1 			FLOAT,
nota2 			FLOAT,
nota3 			FLOAT,
PRIMARY KEY(anoLetivo, cod_disc, mat_aluno),
FOREIGN KEY(cod_disc) REFERENCES disciplina (codDisciplina),
FOREIGN KEY(mat_aluno) REFERENCES aluno (matricula)
);

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

INSERT INTO endereco VALUES(NEXTVAL('seqend'), 'Rua a', 'Bairro q', 'Cidade z', 4),
						   (NEXTVAL('seqend'), 'Rua s', 'Bairro w', 'Cidade x', 1),
						   (NEXTVAL('seqend'), 'Rua d', 'Bairro e', 'Cidade c', 2),
						   (NEXTVAL('seqend'), 'Rua f', 'Bairro r', 'Cidade v', 5),
						   (NEXTVAL('seqend'), 'Rua g', 'Bairro t', 'Cidade v', 7),
						   (NEXTVAL('seqend'), 'Rua h', 'Bairro y', 'Cidade z', 3),
						   (NEXTVAL('seqend'), 'Rua j', 'Bairro u', 'Cidade x', 6);
						
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

INSERT INTO disciplina VALUES (1, 'Lógica', 32, 1040);
INSERT INTO disciplina VALUES (2, 'BD', 32, 1010);
INSERT INTO disciplina VALUES (3, 'PHP', 60, 1020);
INSERT INTO disciplina VALUES (4, 'SQL Server', 32, 1020);
INSERT INTO disciplina VALUES (5, 'BI', 40, 1010);
INSERT INTO disciplina VALUES (6, 'UML', 20, NULL);
INSERT INTO disciplina VALUES (7, 'Oracle', 32, 1010); 

SELECT * FROM disciplina;

INSERT INTO alunosInscritos VALUES(2017, 4, 2);

SELECT * FROM alunosInscritos;

UPDATE alunosInscritos SET nota = 6.5
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

--Pesquisas

SELECT nome, dataNasc, rua, numero, bairro
	FROM aluno INNER JOIN endereco
	ON matricula = mat_aluno;
	
SELECT nome, TO_CHAR(dataNasc, 'DD/MM/YYYY') AS Nascimento,
	AGE(dataNasc), rua, numero, bairro
	FROM aluno INNER JOIN endereco
	ON matricula = mat_aluno;
	
SELECT nome, TO_CHAR(dataNasc, 'DD/MM/YYYY') AS Nascimento,
	DATE_PART('year', AGE(dataNasc)) AS idade,
	rua, numero, bairro
	FROM aluno INNER JOIN endereco
	ON matricula = mat_aluno;
	
	
SELECT d.nome AS Disciplina, cargaHr,
	p.nome AS Professor, titulacao
	FROM disciplina d LEFT JOIN professor p
	ON codProfessor = cod_prof;
	
SELECT d.nome AS Disciplina, cargaHr,
	p.nome AS Professor, titulacao
	FROM disciplina d RIGHT JOIN professor p
	ON codProfessor = cod_prof;
	
SELECT anoLetivo, p.nome AS Professor,
	d.nome AS Disciplina, a.nome AS aluno,
	nota1, nota2, nota3
	FROM aluno a
	INNER JOIN alunosInscritos ai ON a.matricula = ai.mat_aluno
	INNER JOIN disciplina d ON d.codDisciplina = ai.cod_disc
	LEFT JOIN professor p ON p.codProfessor = c.cod.prof;

SELECT anoLetivo, p.nome AS Professor,
	d.nome AS Disciplina, a.nome AS aluno,
	nota1, nota2, nota3,
	(nota1 + nota2 + nota3)/3 AS Media
	FROM aluno a
	INNER JOIN alunosInscritos ai ON a.matricula = ai.mat_aluno
	INNER JOIN disciplina d ON d.codDisciplina = ai.cod_disc
	LEFT JOIN professor p ON p.codProfessor = c.cod.prof;

SELECT anoLetivo, disciplina, aluno,
	TO_CHAR(media, '99d99') AS media,
	CASE
		WHEN media >= 7 THEN 'Aprovado'
		WHEN media BETWEEN 6 and 6.99 THEN 'Recuperação'
		ELSE 'Reprovado'
	END AS situacao
	FROM relMedias;
	
	
-------------------------------------------------------------------------------
-- Controle de transação (COMMIT e ROOLBACK)

-- Iniciar bloco de transação.
BEGIN;

UPDATE aluno SET genero = 'f';
DELETE FROM endereco;

SELECT * FROM aluno;
SELECT * FROM endereco;

-- Confirma transações
COMMIT;

-- Desfazer transações
ROLLBACK;

SELECT * FROM aluno;
SELECT * FROM endereco;

-- Usuários, grupos e permissões

-- Exibir usuário
SELECT CURRENT_USER;

-- Exibir todos os usuários
\du

-- Criar usuários
CREATE USER lucas WITH PASSWORD '123';
CREATE USER maria WITH PASSWORD '456';
CREATE USER bruna WITH PASSWORD '789';

ALTER USER lucas WITH PASSWORD '111';


-- Criar grupos de usuários
CREATE GROUP estagiarios WITH USER lucas;
CREATE GROUP estagiarios WITH USER maria;


-- Conceder Permissões
GRANT SELECT, INSERT ON aluno TO bruna;
GRANT ALL PRIVILEGES ON seqaluno TO bruna;

GRANT SELECT, INSERT, UPDATE ON alunosInscritos TO bruna;

GRANT SELECT, INSERT ON aluno TO estagiarios;

-- Remover permissão
REVOKE INSERT ON aluno FROM estagiarios;

-- Trocar de usuário
\c aula7 maria
SELECT * FROM aluno;
SELECT * FROM professor;
DELETE FROM aluno;

-- Conectar com usuário postgres
\c aula7 postgres0,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
