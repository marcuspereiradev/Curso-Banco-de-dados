-- Aula3 - 17/07/2018

/*
	Um hospital requer armazenar os dados de suas consultas. Cada consulta realizada deve armazenar o nome 
	do médico e sua especialidade; o nome, gênero e data de nascimento do paciente; o diagnóstico e a data
	e hora do atendimento.

	Os médicos podem atender qualquer paciente várias vezes, assim como os pacientes podem ser atendidos por
	qualquer médico várias vezes.
	
	Os pacientes podem informar o nome e o telefone de uma pessoa para contato, mas isso não é obrigatório.
	
**/

DROP DATABASE aula3;
CREATE DATABASE aula3;
USE aula3;

CREATE TABLE medico (
	codMedico 	INTEGER 	PRIMARY KEY	AUTO_INCREMENT,
	nome 		VARCHAR(50)	NOT NULL,
	espec 		VARCHAR(30)	NOT NULL);
	
-- DATE - Armazenar data no formato yyyy-mm-dd
CREATE TABLE paciente (
	codPaciente INTEGER 		PRIMARY KEY	AUTO_INCREMENT,
	nome 		VARCHAR(50)		NOT NULL,
	genero 		ENUM('f', 'm')	NOT NULL,
	dataNasc 	DATE			NOT NULL);
	
CREATE TABLE pessoaContato (
	codContato 	INTEGER 	PRIMARY KEY	AUTO_INCREMENT,
	nome 		VARCHAR(50)	NOT NULL,
	telefone 	VARCHAR(10)	NOT NULL,
	codPac 		INTEGER		NOT NULL	UNIQUE,
	FOREIGN KEY(codPac) REFERENCES paciente (codPaciente));

-- TIMESTAMP - Armazenar data e hora no formato yyyy-mm-dd HH:mm:ss
CREATE TABLE consulta (
	codConsulta INTEGER 		PRIMARY KEY	AUTO_INCREMENT,
	cod_med 	INTEGER			NOT NULL,
	cod_pac 	INTEGER			NOT NULL,
	diagnostico VARCHAR(200)	NOT NULL,
	dataHora 	TIMESTAMP,
	FOREIGN KEY(cod_med) REFERENCES medico (codMedico),
	FOREIGN KEY(cod_pac) REFERENCES paciente (codPaciente));
	
-- Exibir tabelas existentes.
SHOW TABLES;

-- Exibir estrutura das tabelas.
DESC medico;
DESC paciente;
DESC pessoaContato;
DESC consulta;

-- Inserir dados nas tabelas.

INSERT INTO medico VALUES(NULL, 'Edu', 'Ortopedia');
INSERT INTO medico VALUES(NULL, 'Mel', 'Cardiologia');
INSERT INTO medico VALUES(NULL, 'Nat', 'Pediatria');
INSERT INTO medico VALUES(NULL, 'Ana', 'Clinica Medica');

SELECT * FROM medico;

INSERT INTO paciente VALUES(NULL, 'Mila', 'f', '1986-03-18'),
						   (NULL, 'Beto', 'm', '1973-08-25'),
						   (NULL, 'Rafa', 'f', '1990-05-12'),
						   (NULL, 'Cadu', 'm', '1961-11-05'),
						   (NULL, 'Duda', 'f', '2012-07-07'),
						   (NULL, 'Hugo', 'm', '1954-01-15'),
						   (NULL, 'Juca', 'm', '1991-10-21'),
						   (NULL, 'Luis', 'm', '1982-07-30');
						   
SELECT * FROM paciente;

INSERT INTO pessoaContato(codPac, nome, telefone) VALUES(2, 'Maria', '3333-5555');
INSERT INTO pessoaContato(codPac, nome, telefone) VALUES(3, 'Pedro', '2222-3333');
INSERT INTO pessoaContato(codPac, nome, telefone) VALUES(6, 'Paulo', '4444-6666');
INSERT INTO pessoaContato(codPac, nome, telefone) VALUES(8, 'Bruno', '8888-4444');

SELECT * FROM pessoaContato;

INSERT INTO consulta(codConsulta, cod_med, cod_pac, diagnostico, dataHora)
					 VALUES(NULL, 4, 8, 'Dengue', '2017-12-22 10:00'),
						   (NULL, 1, 2, 'Fratura', '2017-12-26 08:30'),
						   (NULL, 3, 5, 'Catapora',	'2017-12-29 17:00'),
						   (NULL, 4, 6, 'Virose', '2018-01-03 14:00'),
						   (NULL, 4, 4, 'Infeccao',	'2018-01-11 16:00'),
						   (NULL, 1, 3, 'Entorse', '2018-01-24 13:00'),
						   (NULL, 2, 1, 'Hipertensao', '2018-01-30 11:20'),
						   (NULL, 4, 2, 'Zika', '2018-02-04 17:20'),
						   (NULL, 1, 1, 'Fratura', '2018-02-09 09:00'),
						   (NULL, 4, 3, 'Gripe', '2018-02-15 15:30'),
						   (NULL, 2, 8, 'Arritmia', '2018-03-01 16:30'),
						   (NULL, 1, 2, 'Luxacao', '2018-03-08 13:00'),
						   (NULL, 4, 1, 'Pneumonia', '2018-03-14 12:00'),
						   (NULL, 3, 5, 'Gripe', '2018-03-22 16:00'),
						   (NULL, 2, 6, 'Arritmia', '2018-03-29 13:00');
						   
SELECT * FROM consulta;

-- Manipulação de datas no MySQL.

SELECT CURRENT_DATE;
SELECT CURRENT_TIME;

SELECT SYSDATE() AS DATAHORA;
SELECT NOW() AS DATAHORA;

SELECT YEAR('2017-03-17') AS Ano;
SELECT MONTH('2017-03-17') AS Mes;
SELECT DAY(NOW()) AS Dia;

SELECT DATE_FORMAT('2017-03-17', '%d/%m/%y') AS Data_Formatada;
SELECT DATE_FORMAT(NOW(), '%W %D %M %Y - %H:%i') AS Data_Formatada;

SELECT nome, DATE_FORMAT(dataNasc, '%d/%m/%y') AS Nascimento
	FROM paciente;

SELECT DATEDIFF('2018-07-18', '2017-12-31');
	
SELECT nome, 
	DATE_FORMAT(dataNasc, '%d/%m/%Y') AS Nascimento,
	TRUNCATE(DATEDIFF(NOW(), dataNasc)/365, 0) AS Idade
	FROM paciente;

-- Consultas.

-- Exibir o nome e a data de nascimento dos pacientes nascidos antes de 1980.


-- Exibir o nome e a data de nascimento dos pacientes que fazem aniversário no mês atual.

	
-- Exibir o nome e a especialidade dos médicos e as datas em que atenderam.

	
-- Exibir o nome e a especialidade dos médicos e as datas em que atenderam.
-- Somente atendimentos da ortopedia e clinica médica.


-- Exibir nome, gênero e diagnóstico dos pacientes.

	
-- Exibir nome, gênero e diagnóstico dos pacientes. Somente consultas realizadas em 
-- janeiro e fevereiro de 2018.

	
-- Exibir nome, data de nascimento e idade dos pacientes. 


