DROP DATABASE aula2;
CREATE DATABASE aula2;
USE aula2;

-- AUTO_INCREMENT - Geração automática de valores sequenciais.
-- UNIQUE - Campo único, não permite duplicidade.
-- ENUM('f', 'm') - Limitar a entrada de dados em 'f' ou 'm'.
CREATE TABLE funcionario (
	codFuncionario 	INTEGER 		PRIMARY KEY	AUTO_INCREMENT,
	nome 			VARCHAR(50)		NOT NULL,
	cpf 			CHAR(14)		NOT NULL	UNIQUE,
	genero 			ENUM('f', 'm')	NOT NULL,
	salario 		FLOAT			NOT NULL);

/*
	Declaração de Chave Estrangeira
	FOREIGN KEY(cod_func) REFERENCES funcionario (codFuncionario)
	
	O campo 'cod_func' da tabela é uma chave estrangeira e faz referência ao campo
	'codFuncionario' da tabela 'funcionario'.

**/
CREATE TABLE endereco (
	codEndereco INTEGER 	PRIMARY KEY	AUTO_INCREMENT,
	rua 		VARCHAR(60)	NOT NULL,
	numero 		INTEGER		NOT NULL,
	bairro 		VARCHAR(60)	NOT NULL,
	cidade 		VARCHAR(60)	NOT NULL,
	uf 			CHAR(2)		NOT NULL,
	cod_func 	INTEGER		NOT NULL	UNIQUE,
	FOREIGN KEY(cod_func) REFERENCES funcionario (codFuncionario));

CREATE TABLE dependente (
	codDependente 	INTEGER 	PRIMARY KEY	AUTO_INCREMENT,
	nome 			VARCHAR(50)	NOT NULL,
	telefone 		VARCHAR(10)	NOT NULL,
	grau 			VARCHAR(10)	NOT NULL,
	cod_func 		INTEGER		NOT NULL,
	FOREIGN KEY(cod_func) REFERENCES funcionario (codFuncionario));

	
SHOW TABLES;

DESC funcionario;
DESC endereco;
DESC dependente;

-- Inserir dados nas tabelas.

INSERT INTO funcionario VALUES(NULL, 'Bia', '123.432.432-21', 'f', 4000);
INSERT INTO funcionario VALUES(NULL, 'Edu', '222.432.432-21', 'm', 3500);
INSERT INTO funcionario VALUES(NULL, 'Ana', '333.432.432-21', 'f', 5100);
INSERT INTO funcionario VALUES(NULL, 'Nat', '444.432.432-21', 'f', 6200);
INSERT INTO funcionario VALUES(NULL, 'Rui', '555.432.432-21', 'm', 5300);

SELECT * FROM funcionario;

INSERT INTO endereco VALUES(NULL, 'Rua a', 523, 'Bairro q', 'Cidade z', 'RJ', 3);
INSERT INTO endereco VALUES(NULL, 'Rua s', 315, 'Bairro w', 'Cidade x', 'RJ', 1);
INSERT INTO endereco VALUES(NULL, 'Rua d', 1358, 'Bairro e', 'Cidade c', 'SP', 2);
INSERT INTO endereco VALUES(NULL, 'Rua f', 20, 'Bairro r', 'Cidade v', 'SP', 5);
INSERT INTO endereco VALUES(NULL, 'Rua g', 117, 'Bairro t', 'Cidade b', 'RJ', 4);

SELECT * FROM endereco;

INSERT INTO dependente VALUES(NULL, 'Beto', 'Filho', '4444-2222', 3);
INSERT INTO dependente VALUES(NULL, 'Rita', 'Filha', '5555-2222', 3);
INSERT INTO dependente VALUES(NULL, 'Mila', 'Filha', '6644-2222', 1);
INSERT INTO dependente VALUES(NULL, 'Cadu', 'Filho', '3344-2222', 5);
INSERT INTO dependente VALUES(NULL, 'Duda', 'Filha', '7744-2222', 5);
INSERT INTO dependente VALUES(NULL, 'Hugo', 'Conjuge', '2244-2222', 4);
INSERT INTO dependente VALUES(NULL, 'Rafa', 'Conjuge', '9999-2222', 5);

SELECT * FROM dependente;

ALTER TABLE dependente CHANGE COLUMN telefone grauParent VARCHAR(10) NOT NULL;
ALTER TABLE dependente CHANGE COLUMN grau telefone VARCHAR(10) NOT NULL;

-- Aula 3(continuação aula 2) - 17 - 07 - 2018

--Exibir os dependentes com grau de parenntesco filho e filha, em uma ordem que os fillhos 
--sejam exibidos primeiro.

SELECT * FROM dependente
	WHERE grauParent = 'filho' OR grauParent = 'filha'
	ORDER BY grauParent DESC, nome;
	
SELECT * FROM dependente
	WHERE grauParent IN ('filho', 'filha')
	ORDER BY grauParent DESC, nome;
	
SELECT * FROM dependente
	WHERE grauParent NOT IN ('filho', 'filha')
	ORDER BY grauParent DESC, nome;
	
-- Consultas em duas tabelas (sintax defasada)
SELECT nome, rua, bairro, cidade
	FROM funcionario, endereco
	WHERE codFuncionario = cod_func;
	
SELECT nome, rua, bairro, cidade, uf
	FROM funcionario, endereco
	WHERE codFuncionario = cod_func
	AND uf = 'RJ';
	
-- Exibir o nome dos funcionarios, o nome de seus dependentes e o grau parentesco
SELECT funcionario.nome, dependente.nome, grauparent
FROM funcionario, dependente WHERE codFuncionario = cod_func;

-- Consultas em duas tabelas com JOIN
SELECT nome, rua, bairro, cidade
	FROM funcionario INNER JOIN endereco
	ON codFuncionario = cod_func;
	
SELECT nome, rua, bairro, cidade, uf
	FROM funcionario INNER JOIN endereco
	ON codFuncionario = cod_func
	WHERE uf = 'RJ';