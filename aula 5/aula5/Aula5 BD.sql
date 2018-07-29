-- Aula5 BD - 24/07/2018

/*

	Segunda Forma Normal (FN2)
	
	Todos os campos de uma tabela, que não são Chave Primária, devem ter a sua existência
	diretamente, e somente, associada à Chave Primária da tabela ao qual estão contidos.

	Em tabelas com PK composta não pode haver Dependência Parcial, quando um campo que não faz parte 
	da chave primária depende apenas de parte dos campos que compõe a chave primária.
	
	Terceira Forma Normal (FN3) - Dependência Transitiva.
	
	Não deve haver dependência transitiva, quando um campo que não faz parte da chave primária 
	depende de outro campo que também não é a Chave Primária.
	
**/

/*
	
	Estudo de caso:

	Uma empresa requer armazenar os dados de seus funcionários: nome, cpf, gênero, cargo e salário. 
	Funcionários que exercem o mesmo cargo recebem o mesmo salário.
	
	Caso o funcionario seja casado, armazenar nome e telefone do cônjuge.
	
	Há ainda a necessidade de armazenar os dados dos projetos em que os funcionários podem
	atuar. Destes os dados são: nome, valor, data de inicio, tempo previsto para o término e porcentagem
	por participação.

	A porcentagem é aplicada ao valor do projeto, gerando um bônus para os funcionários que atuam nele.
	
*/

DROP DATABASE aula5;
CREATE DATABASE aula5;
USE aula5;
	
CREATE TABLE funcionario (
	codFuncionario 	INTEGER 	PRIMARY KEY	AUTO_INCREMENT,
	nome 			VARCHAR(60)	NOT NULL,
	cpf 			CHAR(14)	NOT NULL	UNIQUE,
	genero 			CHAR(1)		NOT NULL);

-- DECIMAL - Valores com casas decimais onde são definidos escala e precisão. DEC(10,2) = 99999999.99
CREATE TABLE cargo (
	codCargo 	INTEGER 		PRIMARY KEY	AUTO_INCREMENT,
	titulo 		VARCHAR(40)		NOT NULL,
	salario 	DECIMAL(10,2)	NOT NULL);
	
CREATE TABLE conjuge (
	codConjuge 	INTEGER 	PRIMARY KEY	AUTO_INCREMENT,
	nome 		VARCHAR(60)	NOT NULL,
	telefone 	VARCHAR(10)	NOT NULL,
	codFunc 	INTEGER		NOT NULL,
	FOREIGN KEY(codFunc) REFERENCES funcionario (codFuncionario));

CREATE TABLE projeto (
	codProjeto 	INTEGER 		AUTO_INCREMENT,
	nome 		VARCHAR(80)		NOT NULL,
	valor 		DECIMAL(12,2)	NOT NULL,
	dataInicio 	DATE			NOT NULL,
	tempPrev 	INTEGER			NOT NULL,
	porcent 	FLOAT			NOT NULL,
	PRIMARY KEY(codProjeto));
	
CREATE TABLE alocado (
	cod_proj 	INTEGER	NOT NULL,
	cod_func 	INTEGER	NOT NULL,
	PRIMARY KEY(cod_proj, cod_func),
	FOREIGN KEY(cod_proj) REFERENCES projeto (codProjeto),
	FOREIGN KEY(cod_func) REFERENCES funcionario (codFuncionario));

-- Metadados.
SHOW TABLES;

SELECT TABLE_SCHEMA, TABLE_NAME, CREATE_TIME 
	FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'aula5';

DESC funcionario;
DESC cargo;
DESC conjuge;
DESC projeto;
DESC conjuge;

SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE, IS_NULLABLE, COLUMN_KEY
	FROM INFORMATION_SCHEMA.COLUMNS
	WHERE TABLE_SCHEMA = 'aula5';
	
-- Alterações na estrutura das tabelas.

-- Adicionar campo.
ALTER TABLE funcionario ADD COLUMN cod_cargo INT NOT NULL;

-- Adicionar restrição(CONSTRAINT) de chave estrangeira.
ALTER TABLE funcionario ADD CONSTRAINT FK_cargo
FOREIGN KEY(cod_cargo) REFERENCES cargo (codCargo);

-- Adicionar restrição(CONSTRAINT) de campo único.
ALTER TABLE conjuge ADD CONSTRAINT UNQ_codFunc UNIQUE(codFunc);

DESC funcionario;
DESC conjuge;

-- Inserir dados nas tabela.

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
	VALUES(NULL, 'E-Commerce', 230000, '2018-02-14', 170, 1),
		  (NULL, 'Gestão Hospitalar', 420000, '2019-04-20', 225, 0.5);

SELECT * FROM projeto;

INSERT INTO alocado(cod_proj, cod_func) VALUES(2, 5), (1, 3), (1, 2), (2, 6), (2, 7), (1, 1), (2, 4);

SELECT * FROM alocado;

-- Pesquisas.

SELECT nome, titulo, salario
	FROM funcionario INNER JOIN cargo
	ON codCargo = cod_cargo;

SELECT IFNULL(nome, '---') AS Funcionario, 
	titulo, salario
	FROM funcionario RIGHT JOIN cargo
	ON codCargo = cod_cargo;

SELECT f.nome AS NomeFunc, c.nome AS NomeConj, telefone
	FROM funcionario f LEFT JOIN conjuge c
	ON codFuncionario = codFunc;

-- Funções de agregação.

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

-- GROUP BY - Resultado de uma função de agregação divido por grupo de indivíduos.

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
	   SUM(salario) AS SomaSal
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
	GROUP BY titulo HAVING COUNT(nome) >= 2 ;

-- Subquery.
	
-- Exibir o funcionário que recebe o maior salário.
SELECT nome, salario
	FROM funcionario INNER JOIN cargo
	ON codCargo = cod_cargo
	WHERE salario = (SELECT MAX(salario) FROM funcionario 
					 INNER JOIN cargo ON codCargo = cod_cargo);
	
-- Exibir o funcionário que recebem acima da média.	
SELECT nome, salario
	FROM funcionario INNER JOIN cargo
	ON codCargo = cod_cargo
	WHERE salario >= (SELECT AVG(salario) FROM funcionario 
					 INNER JOIN cargo ON codCargo = cod_cargo);	
					 
-- Adiocionar período a uma data.

SELECT DATE_ADD(NOW(), INTERVAL 90 DAY);

SELECT nome, dataInicio, tempPrev,
	DATE_ADD(dataInicio, INTERVAL tempPrev DAY) AS DataFim
	FROM projeto;
	
SELECT nome, 
	DATE_FORMAT(dataInicio, '%d/%m/%Y') AS Inicio, tempPrev,
	DATE_FORMAT(DATE_ADD(dataInicio, INTERVAL tempPrev DAY), '%d/%m/%Y') AS Fim
	FROM projeto;
	
-- Calculo de Bonus.
SELECT nome, valor, porcent, (valor * (porcent/100)) AS Bonus
	FROM projeto;


/*
	Exercicios da Aula5.

		Exibir o nome dos funcionarios, cargo e salario. Somente cargos Junior e Pleno.
		
		Exibir o nome dos funcionarios, cargo e salario. Somente funcionarios com salario
		superior a 4000 ou do sexo feminino.
	
		Exibir o nome dos funcionarios, cargo e salario. Somente funcionarios com salario
		inferior a 4000 e do sexo feminino.
	
		Exibir o nome dos funcionarios, cargo e salario. Somente funcionarios casados.
	
		Exibir o nome dos funcionarios, nome do projeto, data de inicio.

		Exibir o nome dos funcionarios, nome do projeto, valor. Somente funcionarios do sexo
		feminino.
		
		Exibir o nome dos funcionarios, nome do projeto, valor. Somente funcionarios casados.
		
		Exibir o nome dos funcionarios, cargo, projeto e valor.
		
		Exibir o nome do projeto, valor, porcentagem por participação e bonus(porcentagem 
		aplicada no valor).
		
		Exibir o nome dos funcionarios, salario base, salario liquido(Salario * bonus).
		
		Exibir o total de salario base pago por projetos.
		
		Exibir o total de salario liquido pago por projetos.
		
**/
	