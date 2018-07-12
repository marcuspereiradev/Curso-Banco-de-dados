-- Aula2 BD (Continuação aula1) - 12/07/2018

DROP TABLE cliente;

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

-- Pesquisas.

-- Exibir nome, email e gênero dos clientes do sexo feminino.
SELECT nome, email, genero
	FROM cliente WHERE genero = 'f';

-- Exibir nome, gênero e renda dos clientes com renda inferior a 6000. Ordem alfabética.
SELECT nome, genero, renda
	FROM cliente WHERE renda < 6000
	ORDER BY nome;

-- Exibir nome, gênero e renda dos clientes do sexo feminino com renda superior a 6000.
SELECT nome, genero, renda
	FROM cliente WHERE genero = 'f' AND renda > 6000;

-- Exibir nome, email e endereço dos clientes do Rio de Janeiro.
SELECT nome, email, endereco
	FROM cliente WHERE endereco = 'RJ';
	
SELECT nome, email, endereco
	FROM cliente WHERE uf = 'RJ';	
	
-- LIKE - Consulta por sequência de caracteres.

SELECT nome, email FROM cliente WHERE nome LIKE 'm%';	
SELECT nome, email FROM cliente WHERE nome LIKE '%na';	

SELECT nome, email FROM cliente WHERE email LIKE '%uol%';		
	
SELECT nome, email, endereco
	FROM cliente WHERE endereco LIKE '%rj%';
	
INSERT INTO cliente VALUES(104, 'Nat', 'nat@aol.com', 'f', 5700, '4444-5555 / 8888-3333', 'Maspe, Gorjes, mg');
	
SELECT nome, email, endereco
	FROM cliente WHERE endereco LIKE '%mg%';


