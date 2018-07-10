-- Aula 1 BD - 10/07/2018

/*
	Estruturas básicas do MySQL.

	Base de Dados (DATABASE) - Estrutura de organização dos objetos no banco de dados.

	Tabela (TABLE) - Estrutura constituída de campos, chaves e modificadores onde os 
					 dados são efetivamente armazenados.
	
**/

-- Exibir as bases de dados exitentes.
SHOW DATABASES;

-- Eliminar base de dados (CUIDADO).
DROP DATABASE aula1;

-- Criar base de dados.
CREATE DATABASE aula1;

-- Selecionar a base de dados.
USE aula1;

--  Criar tabela.
CREATE TABLE produto(
	nome 	VARCHAR(30), 
	fabric 	VARCHAR(20), 
	qtd 	INT, 
	preco 	FLOAT);
	
-- Exibir as tabelas existentes.
SHOW TABLES;

-- Exibir a estrutura da tabela.
DESC produto;

-- Inserir dados na tabela.
INSERT INTO produto VALUES('Notebook', 'Dell', 2, 2300);

INSERT INTO produto VALUES('Impressora', 'HP', 3, 470);
INSERT INTO produto VALUES('Camera', 'Sony', 4, 980.5);
INSERT INTO produto VALUES('Projetor', 'Epson', 1, 2500);
INSERT INTO produto VALUES('Computador', 'Dell', 2, 1760);
INSERT INTO produto VALUES('Smartphone', 'Sony', 3, 2100);
INSERT INTO produto VALUES('Monitor', 'LG', 5, 610.9);

-- Pesquisar dados da tabela.
-- SELECT lista-de-campos FROM tabela;

SELECT nome, qtd, preco FROM produto;
SELECT fabric, nome, preco FROM produto;

SELECT nome, fabric, qtd, preco FROM produto;
-- mesmo que
SELECT * FROM produto;

-- Ordenação.

SELECT nome, preco 
	FROM produto ORDER BY nome;

SELECT nome, qtd, preco 
	FROM produto ORDER BY qtd;

SELECT nome, qtd, preco 
	FROM produto ORDER BY preco ASC;

SELECT nome, qtd, preco 
	FROM produto ORDER BY preco DESC;

SELECT fabric, nome, preco 
	FROM produto ORDER BY fabric, nome;

-- LIMIT - Limitar a quantidade de registros na exibição.

SELECT * FROM produto LIMIT 5;

SELECT * FROM produto 
	ORDER BY preco LIMIT 3;

SELECT * FROM produto 
	ORDER BY preco DESC LIMIT 3;
	
-- WHERE (Filtro) - Condicionar o resultado de uma pesquisa.

SELECT nome, qtd, preco 
	FROM produto WHERE preco < 1000;

SELECT nome, qtd, preco 
	FROM produto WHERE qtd > 3;

SELECT nome, qtd, preco 
	FROM produto WHERE qtd >= 3;
	
SELECT fabric, nome, preco 
	FROM produto WHERE fabric = 'Dell';

SELECT fabric, nome, preco 
	FROM produto WHERE fabric <> 'DELL'
	ORDER BY preco;

-- Operadores Lógicos (AND e OR).

SELECT fabric, nome, preco 
	FROM produto 
	WHERE fabric = 'Dell' AND preco < 2000;
	
SELECT fabric, nome, preco 
	FROM produto 
	WHERE fabric = 'Dell' OR preco < 2000;	
	
SELECT fabric, nome, preco 
	FROM produto 
	WHERE fabric = 'Dell' OR fabric = 'Sony'
	ORDER BY fabric;
	
SELECT fabric, nome, preco 
	FROM produto 
	WHERE (fabric = 'Dell' OR fabric = 'Sony') AND preco < 2000;
	
-- Falhas de integridade da tabela produto.

INSERT INTO produto VALUES('Smartphone', 'Sony', 3, 2100);
INSERT INTO produto VALUES(NULL, 'LG', 2, NULL);
	
SELECT * FROM produto;
	
-- Alterar dados de um registro.

UPDATE produto SET nome = 'TV' 
	WHERE fabric = 'LG' AND qtd = 2;

UPDATE produto SET preco = 2200
	WHERE nome = 'TV';
	
-- Excluir registros da tabela.
DELETE FROM produto WHERE nome = 'Smartphone';

SELECT * FROM produto;

----------------------------------------------------------------------------------

/*
	Estudo de Caso
	
	Uma empresa requer armazenar os dados seus clientes. Cada cliente cadastrado
	possui os seguintes dados: nome, email, gênero, renda, telefone e endereço.
	
	Esses dados são fornecidos a outras empresas e utilizados em campanhas publicitárias.
	
	ENTIDADES
	
	Cliente				
		nome
		email
		genero
		renda
		telefone
		endereco

**/

-- PRIMARY KEY (Chave Primária) - Campo identificador, não nulo, único.
-- NOT NULL - Campo não nulo.
CREATE TABLE cliente(
	codCliente	INT				PRIMARY KEY,
	nome		VARCHAR(40)		NOT NULL, 
	email 		VARCHAR(40)		NOT NULL, 
	genero 		CHAR			NOT NULL, 
	renda		FLOAT			NOT NULL,
	telefone	VARCHAR(60)		NOT NULL,
	endereco	VARCHAR(100)	NOT NULL);
	
SHOW TABLES;

DESC produto;
DESC cliente;

-- Inserir dados na tabela cliente.
INSERT INTO cliente VALUES(101, 'Edu', 'edu@uol.com', 'm', 4300, '2222-5555 / 5555-3333', 'Rua a, Cidade q, rj');
INSERT INTO cliente VALUES(102, 'Ana', 'ana@uol.com', 'f', 6400, '9999-5555 / 7777-3333', 'Rua s, Cidade w, sp');
INSERT INTO cliente VALUES(103, 'Mel', 'mel@aol.com', 'f', 5200, '8888-5555 / 2222-3333', 'Rua d, Cidade e, rj');

SELECT * FROM cliente;

INSERT INTO cliente VALUES(104, 'Mel', 'mel@aol.com', 'f', 5200, '8888-5555 / 2222-3333', 'Rua d, Cidade e, rj');
	
DELETE FROM cliente WHERE codCliente = 104;

SELECT * FROM cliente;