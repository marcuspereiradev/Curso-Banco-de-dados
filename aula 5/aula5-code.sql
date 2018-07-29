-- Gera��o de Modelo f�sico
-- Sql ANSI 2003 - brModelo.

DROP DATABASE aula5;
CREATE DATABASE aula5;
USE aula5;

CREATE TABLE funcionario (
codFuncionario 	INTEGER 		PRIMARY KEY 		AUTO_INCREMENT,
nome 			VARCHAR(60)		NOT NULL,
cpf 			CHAR(14)		NOT NULL	UNIQUE,
genero 			CHAR(1)			NOT NULL
);

CREATE TABLE Cargo (
codCargo 		INTEGER 		PRIMARY KEY			AUTO_INCREMENT,
titulo 			VARCHAR(40)		NOT NULL,
salario 		DECIMAL(10,2)   NOT NULL
);

CREATE TABLE Conjuge (
codConjuge 		INTEGER 		PRIMARY KEY			AUTO_INCREMENT,
nome 			VARCHAR(60)		NOT NULL,
telefone 		VARCHAR(10)		NOT NULL,
codFunc			INTEGER			NOT NULL,
FOREIGN KEY(codFunc) REFERENCES funcionario (codFuncionario)
);

CREATE TABLE Projeto (
codProjeto 		INTEGER 		AUTO_INCREMENT,
nome 			VARCHAR(80)		NOT NULL,
valor 			DECIMAL(12,2)	NOT NULL,
dataInicio 		DATE 			NOT NULL,
tempoPrev 		INTEGER 		NOT NULL,
porcent 		FLOAT 			NOT NULL,
PRIMARY KEY(codProjeto)
);

CREATE TABLE alocado (
cod_proj INTEGER NOT NULL,
cod_func INTEGER NOT NULL,
PRIMARY KEY(cod_proj,cod_func),
FOREIGN KEY(cod_proj) REFERENCES Projeto (codProjeto),
FOREIGN KEY(cod_func) REFERENCES funcionario (codfuncionario)
);


--Metadados
SHOW TABLES;

SELECT TABLE_SCHEMA, TABLE_NAME, CREATE_TIME
	FROM INFORMATIONS_SCHEMA, TABLES WHERE TABLE_SCHEMA = 'aula5';
	
DESC funcionario;
DESC cargo;
DESC conjuge;
DESC projeto;
DESC conjuge;
	
SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE, IS_NULLABLE, COLUMN_KEY
	FROM INFORMATION_SCHEMA.COLUMNS
	WHERE TABLE_SCHEMA = 'aula5';
	
	
-- Altera��es na estrutura das tabelas

-- Adicionar campo.
ALTER TABLE funcionario ADD CoLUMN cod_cargo INT NOT NULL;

-- Adicionar restri��o(CONSTRAINT) de chave estrangeira.
ALTER TABLE funcionario ADD CONSTRAINT FK_cargo
FOREIGN KEY(cod_cargo) REFERENCES cargo (codCargo);

-- Adicionar restri��o(CONSTRAINT) de campo �nico.
ALTER TABLE conjuge ADD CONSTRAINT UNQ_codFunc UNIQUE(codfunc);

DESC funcionario;
DESC conjuge;

INSERT INTO cargo(titulo, salario) VALUES('Estagio', 1400),
										 ('Junior', 3350),
										 ('Pleno', 6100),
										 ('Senior', 9800),
										 ('Gerente', 13000);
										 
SELECT * FROM cargo;

INSERT INTO funcionario VALUES(NULL, 'Bia', '123.312.312-21', 'f', 4),
							  (NULL, 'Leo', '132.312.312-17', 'm', 3),
							  (NULL, 'Ana', '045.312.312-05', 'f', 1),
							  (NULL, 'Mel', '221.312.312-15', 'f', 1),
							  (NULL, 'Edu', '034.312.312-38', 'm', 2),
							  (NULL, 'Rui', '441.312.312-06', 'm', 1),
							  (NULL, 'Nat', '934.312.312-17', 'f', 2);

SELECT * FROM funcionario;

INSERT INTO conjuge VALUES(NULL, 'Beto', '2333-4222', 3),
						  (NULL, 'Duda', '5333-4221', 2);
						  
SELECT * FROM conjuge;

INSERT INTO projeto
	VALUES(NULL, 'E-Commerce', 230000, '2018-08-14', 170, 1),
		  (NULL, 'Gest�o Hospitalar', 420000, '2018-07-20', 225, 0.5);

SELECT * FROM projeto;

INSERT INTO alocado(cod_proj, cod_func) VALUES(2, 5), (1, 3), (1, 2), (2, 6), (2, 7), (1, 1), (2, 4);

SELECT * FROM alocado;
 
 
 -- Pesquisas
 SELECT nome, titulo, salario
	FROM funcionario INNER JOIN cargo
	ON codCargo = cod_cargo;
	
SELECT IFNULL(nome, '---') AS funcionario,
	titulo, salario
	FROM funcionario RIGHT JOIN cargo
	ON codCargo = cod_cargo;
	
SELECT f.nome AS NomeFunc, c.nome AS NomeConj, telefone
	FROM funcionario f LEFT JOIN conjuge c
	ON codFuncionario = codFunc;
	
	
-- Fun��es de agrega��o
SELECT COUNT(nome) AS QTD FROM funcionario;	
SELECT SUM(valor) AS Soma FROM projeto;
SELECT AVG(valor) AS Media FROM projeto;
SELECT MIN(salario) AS Menor FROM cargo;
SELECT MAX(salario) AS Maior FROM cargo;

SELECT COUNT(nome) AS QTD,	
	   SUM(valor) AS Soma,
	   AVG(valor) AS Media 
	   FROM projeto;
	   
SELECT COUNT(nome) AS `QTD Func`,
	SUM(salario) AS SomaSal,
	ROUND(AVG(salario), 2) AS MediaSal
FROM funcionario INNER JOIN cargo
ON codCargo = cod_cargo;

-- GROUP BY - Resultado de uma fun��o de agrega��o dividido por grupo de individuos.

SELECT genero, COUNT(nome) AS QTD
	FROM funcionario
	GROUP BY genero;
	
SELECT nome, COUNT(*) AS QTD
	FROM funcionario
	GROUP BY nome;
	
SELECT genero, 
	COUNT(nome) AS `QTD Func`,
	SUM(salario) AS SomaSal,
	ROUND(AVG(salario), 2) AS MediaSal
FROM funcionario INNER JOIN cargo
ON codCargo = cod_cargo
GROUP BY genero;

SELECT titulo, 
	COUNT(nome) AS `QTD Func`,
	SUM(salario) AS SomaSal,
	ROUND(AVG(salario), 2) AS MediaSal
FROM funcionario INNER JOIN cargo
ON codCargo = cod_cargo
GROUP BY titulo;

SELECT titulo, 
	COUNT(nome) AS `QTD Func`,
	SUM(salario) AS SomaSal
FROM funcionario INNER JOIN cargo
ON codCargo = cod_cargo
WHERE titulo IN('Junior', 'Pleno')
GROUP BY titulo;

-- HAVING
SELECT titulo, 
	COUNT(nome) AS `QTD Func`,
	SUM(salario) AS SomaSal
FROM funcionario INNER JOIN cargo
ON codCargo = cod_cargo
GROUP BY titulo HAVING COUNT(nome) >= 2;


-- Subquery
-- Exibir o funcionario que revebe o maior sal�rio

SELECT nome, salario
	FROM funcionario INNER JOIN cargo
	ON codCargo = cod_cargo
	WHERE salario = (SELECT MAX(salario) FROM funcionario
					 INNER JOIN cargo ON codCargo = cod_cargo);
					 

					 
-- Exibir o funcionario que revebe acima da m�dia

SELECT nome, salario
	FROM funcionario INNER JOIN cargo
	ON codCargo = cod_cargo
	WHERE salario >= (SELECT AVG(salario) FROM funcionario
					 INNER JOIN cargo ON codCargo = cod_cargo);
					 
--Adicionar periodo a uma data
SELECT DATE_ADD(NOW(), INTERVAL 90 DAY);

SELECT nome, dataInicio, tempPrev,
	DATE_ADD(dataInicio, INTERVAL tempPrev DAY) AS DataFim
	FROM projeto;

SELECT nome,
	DATE_FORMAT(dataInicio, '%d/%m/%Y') AS Inicio, tempPrev,
	DATE_FORMAT(DATE_ADD(dataInicio, INTERVAL tempPrev DAY), '%d/%m/%Y') AS Fim
	FROM projeto;

--Calculo de Bonus
SELECT nome, valor, porcent, (valor * (porcent/100)) AS Bonus
	FROM projeto;