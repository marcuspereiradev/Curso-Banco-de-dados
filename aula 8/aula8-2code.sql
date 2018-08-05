DROP DATABASE aula8;
CREATE DATABASE aula8;
USE aula8;

CREATE TABLE funcionario (
	matricula 	SERIAL	 	PRIMARY KEY,
	nome 		VARCHAR(60)	NOT NULL,
	genero 		CHAR		NOT NULL,
	salario 	FLOAT		NOT NULL);

DESC funcionario;

INSERT INTO funcionario(nome, genero, salario)
	VALUES('Beto', 'm', 4500),
		  ('Rafa', 'f', 4500),
		  ('Duda', 'f', 4500),
		  ('Mila', 'f', 4500),
		  ('Cadu', 'm', 4500),
		  ('Nat', 'f', 4500);
		  
SELECT * FROM funcionario;

-- Alterar o caractere de execução
DELIMITER $$
SELECT * FROM funcionario$$

-- Frocedure
CREATE PROCEDURE cadFunc(p_nome VARCHAR(30), sexo CHAR, sal FLOAT)
	BEGIN
		DECLARE salBruto FLOAT;
		
		IF sal > 5000 THEN
			SET salBruto = sal * 0.96;
		ELSE
			SET salBruto = sal * 0.96;
		END IF;
		
		INSERT INTO funcionario(nome, genero, salario)
			VALUES(p_nome, sexo, salBruto);
	END;
	
$$

-- Procedures são executadas com o comando CALL
CALL cadFunc('Luis', 'm', 4000)$$
CALL cadFunc('Maria', 'f', 6000)$$

SELECT * FROM funcionario$$

-- Função
CREATE FUNCTION calcHoraExtra(salario FLOAT, diasExtra INT)
	RETURNS FLOAT 
	BEGIN
		DECLARE salDia, salLiq FLOAT;
		
		SET salDia = salario / 22;
		
		SET salLiq = salario + (salDia * diasExtra);
		
		RETURN salLiq;
	END;
$$

SELECT nome, salario, ROUND(calcHoraExtra(salario,2), 2) AS Liquido
	FROM funcionario WHERE matricula = 4$$
	
-- Criar copia da tabela sem os dados
CREATE TABLE funcDelete(LIKE funcionario)$$

DESC funcDelete$$

-- TRIGGER
CREATE TRIGGER moverFuncDel
	AFTER DELETE ON funcionario
	FOR EACH ROW 
	BEGIN
	
	INSERT INTO funcDelete
		VALUES(OLD.matricula, OLD.nome, OLD.genero, OLD.salario);
		
	END
$$

DELETE FROM funcionario WHERE matricula = 2$$

SELECT * FROM funcionario$$
SELECT * FROM funcDelete$$

DELIMITER ;

-- Tarefas agendadas
-- Ativar agendamento de eventos
SET GLOBAL event_scheduler = 1;

-- Criar tabela de teste
CREATE TABLE teste(dt_hr TIMESTAMP);

-- Criar evento para inserir na tabela a cada 10 segundos
CREATE EVENT inserirTeste
ON SCHEDULE EVERY 10 SECOND
STARTS '2018-08-02 11:58'
ENDS '2018-08-02 12:00'
DO
INSERT INTO teste VALUES(NOW());

SELECT * FROM teste;

-- Controle de Transação (COMMIT e ROLLBACK)
-- Desativar o autocommit
SET SESSION autocommit = 0;

DELETE FROM teste;

UPDATE funcionario SET salario = 0;

SELECT * FROM teste;
SELECT * FROM funcionario;

-- Confirmar transações
COMMIT;

-- Desfazer transações
ROLLBACK;

-- Ativar transações
SET SESSION autocommit = 1;

-- BLOB - Armazenar o código binário de um arquivo no bd
CREATE TABLE foto(
	cod		INTEGER		PRIMARY KEY,
	imagem	BLOB		NOT NULL
);

INSERT INTO foto VALUES(1, LOAD_FILE('C:/ProgramData/MySQL/MySQL Server 5.6/Uploads/path.jpg'));

SELECT imagem INTO DUMPFILE 'C:/ProgramData/MySQL/MySQL Server 5.6/Uploads/path1.jpg' FROM foto WHERE cod = 1;

-- Tipos de tabelas
-- InnoDB - Tipo de tabela padrão do mysql em que as transações e as consultas tem o desempenho equivalente
SHOW TABLE STATUS;

-- MyISAM - Tipo de tabela padrão do mysql em que as consultas tem o desempenho priorizado
CREATE TABLE aluno (
	matricula 	SERIAL	 	PRIMARY KEY,
	nome 		VARCHAR(60)	NOT NULL,
	genero 		CHAR		NOT NULL) ENGINE = MYISAM;

DESC aluno;

INSERT INTO aluno(nome, genero)
	VALUES('Beto', 'm'),
		  ('Rafa', 'f'),
		  ('Duda', 'f'),
		  ('Mila', 'f'),
		  ('Cadu', 'm'),
		  ('Nat', 'f');
		  
SELECT * FROM aluno;

-- Usuarios e permissões
-- Usuario atual
SELECT CURRENT_USER;

-- Todos os usuários
SELECT user, host, password FROM mysql.user;

-- Criar usuário
CREATE USER dudu IDENTIFIED BY '123';

-- Conceder permissões
GRANT SELECT, INSERT ON funcionario TO dudu;

-- Acesso com outro usuario
-- No prompt do SO
cd C:\Program Files\PostgreSQL\9.3\bin

mysql -u dudu -p

-- Usuario Atual
SELECT CURRENT_USER;

USE aula8

SELECT * FROM funcionario;
SELECT * FROM teste;

-- BACKUP
-- No prompt do SO
cd C:\Program Files\PostgreSQL\9.3\bin
mysqldump -u root -p -B aula8 --routines --triggers > C:\backup\aula8.txt

-- Restaurar pela linha de comando do mysql
SOURCE C:\backup\aula8.txt