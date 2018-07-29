-- Geração de Modelo físico
-- Sql ANSI 2003 - brModelo.

-- Exibir bases de dados
\l

DROP DATABASE aula6;
CREATE DATABASE aula6;

--Conectar a uma base de dados
\c aula6

CREATE TABLE cliente (
codCliente 		INTEGER 			PRIMARY KEY,
nome 			VARCHAR(80) 		NOT NULL,
email 			VARCHAR(60) 		NOT NULL,
renda 			DECIMAL(10,2 )		NOT NULL
);

CREATE TABLE pessoaJuridica (
codCliente 		INTEGER 			PRIMARY KEY,
cnpj 			CHAR(18)			NOT NULL,
ramo 			VARCHAR(20)			NOT NULL,
FOREIGN KEY(codCliente) REFERENCES Cliente (codCliente)
);

CREATE TABLE pessoaFisica (
codCliente 		INTEGER 			PRIMARY KEY,
cpf 			CHAR(14)			NOT NULL,
genero 			CHAR(1)				NOT NULL,
FOREIGN KEY(codCliente) REFERENCES Cliente (codCliente)
);

CREATE TABLE imovel (
codImovel 		VARCHAR(10) 		PRIMARY KEY,
tipo 			VARCHAR(60)			NOT NULL,
valor 			DECIMAL(12,2 )		NOT NULL,
area 			FLOAT	   			NOT NULL,
rua 			VARCHAR(60)			NOT NULL,
numero 			VARCHAR(10)			NOT NULL,
bairro 			VARCHAR(60)			NOT NULL,
codCliente 		INTEGER				NOT NULL,
FOREIGN KEY(codCliente) REFERENCES Cliente (codCliente)
);

--Exibir objetos existentes
\d

--Exibir a estrutura das tabelas
\d cliente
\d pessoaFisica
\d pessoaJuridica
\d imovel


--SEQUENCE - Objeto utilizado para gerar valores sequenciais
CREATE SEQUENCE seqcliente;
CREATE SEQUENCE seqimv START 101 INCREMENT BY 1;
-- Inserir dados nas tabelas

INSERT INTO cliente VALUES(NEXTVAL('seqcliente'), 'Bia', 'bia@uol.com', 4000);
INSERT INTO cliente VALUES(NEXTVAL('seqcliente'), 'Ana', 'ana@uol.com', 5000);
INSERT INTO cliente VALUES(NEXTVAL('seqcliente'), 'Leo', 'leo@uol.com', 6000);
INSERT INTO cliente VALUES(NEXTVAL('seqcliente'), 'Nat', 'nat@uol.com', 7000);
INSERT INTO cliente VALUES(NEXTVAL('seqcliente'), 'XPTO', 'xpto@uol.com', 8000);
INSERT INTO cliente VALUES(NEXTVAL('seqcliente'), 'COTI', 'coti@uol.com', 9000);

SELECT * FROM cliente;

INSERT INTO pessoaFisica VALUES(1, '234.432;441-16', 'f'),
							   (2, '114.432;441-17', 'f'),
							   (3, '222.432;441-18', 'm'),
							   (4, '333.432;441-19', 'f');
							   
SELECT * FROM pessoaFisica;

INSERT INTO pessoaJuridica VALUES(5, '25.432.442/0001-17', 'COM'),
								 (6, '36.432.442/0001-18', 'EDU');
								 
SELECT * FROM pessoaJuridica;

ALTER TABLE imovel ALTER COLUMN codCliente DROP NOT NULL;

INSERT INTO imovel VALUES(NEXTVAL('seqimv'), 'Apto', 360000, 50, 'Rua a', '352', 'Bairro q', 1),
						 (NEXTVAL('seqimv'), 'Apto', 430000, 115, 'Rua b', '452', 'Bairro u', 4),
						 (NEXTVAL('seqimv'), 'Casa', 668000, 180, 'Rua c', '552', 'Bairro v', 3),
						 (NEXTVAL('seqimv'), 'Apto', 250000, 70, 'Rua d', '652', 'Bairro w', 4),
						 (NEXTVAL('seqimv'), 'Sala', 394000, 40, 'Rua e', '752', 'Bairro y', 5),
						 (NEXTVAL('seqimv'), 'Sala', 368000, 30, 'Rua f', '852', 'Bairro x', 6),
						 (NEXTVAL('seqimv'), 'Apto', 770000, 30, 'Rua g', '952', 'Bairro z', NULL),
						 (NEXTVAL('seqimv'), 'Loja', 888000, 200, 'Rua h', '1052', 'Bairro 2', 6);
						 
SELECT * FROM imovel;

SELECT nome, email, cpf, genero, renda
	FROM cliente c INNER JOIN pessoaFisica pf
	ON c.codCliente = pf.codCliente;
	
SELECT nome, email, cnpj, ramo, renda
	FROM cliente c INNER JOIN pessoaJuridica pj
	ON c.codCliente = pj.codCliente;
	
SELECT nome, email, renda, tipo, area, valor
	FROM cliente INNER JOIN imovel
	ON codCliente = codCliente;
	
SELECT nome, email, renda, tipo, area, valor
	FROM cliente LEFT JOIN imovel
	ON codCliente = codCliente;
	
SELECT nome, email, renda, tipo, area, valor
	FROM cliente RIGHT JOIN imovel
	ON codCliente = codCliente;
	
SELECT nome, email, renda, tipo, area, valor
	FROM cliente FULL JOIN imovel
	ON codCliente = codCliente;
	
SELECT nome, email, renda, tipo, area, valor
	FROM cliente INNER JOIN imovel
	ON codCliente = codCliente;
	
SELECT nome, email, renda, tipo, area, valor
	FROM cliente LEFT JOIN imovel
	ON codCliente = codCliente;
	
SELECT nome, email, renda, tipo, area, valor
	FROM cliente RIGHT JOIN imovel
	ON codCliente = codCliente;
	
SELECT nome, email, renda, tipo, area, valor
	FROM cliente FULL JOIN imovel
	ON codCliente = codCliente
	WHERE tipo = 'Apto' AND valor < 400000
	ORDER BY valor;
	
--Programação no Banco de Dados
--Função para executar SQL
CREATE FUNCTION dadosCliente(cod INT)
	RETURNS VARCHAR(60) AS $$
	
	SELECT 'Nome: ' || nome || ' / Email: ' || email
	FROM cliente WHERE codCliente = cod;
	
$$
LANGUAGE SQL;

SELECT dadosCliente(6);
SELECT dadosCliente(2);

--Função utilizando PLPGSQL
CREATE FUNCTION calcDesconto(valor FLOAT, porcent FLOAT)
	RETURNS FLOAT AS $$
	DECLARE
		resultado FLOAT;
	BEGIN 
	
		resultado = valor - (valor * (porcent / 100));
		
		RETURN resultado;
		
	END;
$$
LANGUAGE PLPGSQL;

SELECT calcDesconto(100, 5);

SELECT tipo, valor, calcDesconto(valor, 7.5) AS ValorDesconto
	FROM imovel;
	
UPDATE cliente SET renda = calcDesconto(renda, 0.75) WHERE codCliente = 2;
SELECT * FROM cliente;

--Função para realizar transações
CREATE OR REPLACE FUNCTION cadPF(pnome VARCHAR(60), pemail VARCHAR(60), prenda FLOAT, pcpf CHAR(14), sexo CHAR)
	RETURNS VARCHAR (100) AS $$
	DECLARE
		fk_cliente INT;
		msg VARCHAR(100);
	BEGIN
	
		INSERT INTO  cliente VALUES(NEXTVAL('seqcliente'), pnome, pemail, prenda);
		fk_cliente = CURRVAL('seqcliente');
		INSERT INTO pessoaFisica VALUES(fk_cliente, pcpf, sexo);
		
		msg = pnome || 'cadastrado como pessoa fisica';
		RETURN msg;
	END;
$$
LANGUAGE PLPGSQL;

SELECT cadPF('Beto', 'beto@uol.com', 4500, '344.111.222-44', 'm');

SELECT * FROM cliente;
SELECT * FROM pessoaFisica;

--Criar view
CREATE VIEW relProprietarios AS
	SELECT nome, email, renda, tipo, area, valor
	FROM Cliente FULL JOIN imovel
	ON codCliente = codCliente;

--Exportar dados para arquivos
\copy imovel TO 'C:/bancodedados/imovel.txt'
\copy (SELECT * FROM relProprietarios) TO 'C:/bancodedados/proprietarios.txt'
\copy (SELECT * FROM relProprietarios) TO 'C:/bancodedados/proprietarios.csv' DELIMITER ';' CSV HEADER

--Criar copia da tabela de dados
CREATE TABLE copiaImv (LIKE imovel);

\d copiaImv
SELECT * FROM copiaImv

-- Importar dados de um arquivo
\copy copiaImv FROM 'C:/bancodedados/imovel.txt'
SELECT * FROM copiaImv;