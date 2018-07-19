-- Geração de Modelo físico
-- Sql ANSI 2003 - brModelo.

DROP DATABASE aula3;
CREATE DATABASE aula3;
USE aula3;

CREATE TABLE Medico (
codMedico 		INTEGER 		PRIMARY KEY AUTO_INCREMENT,
nome 			VARCHAR(50) 	NOT NULL,
especialidade 	VARCHAR(50) 	NOT NULL
);

CREATE TABLE Paciente (
nome 			VARCHAR(50) 	NOT NULL,
dataNasc 		DATE			NOT NULL,
genero 			ENUM('f', 'm')	NOT NULL,
codPaciente 	INTEGER PRIMARY KEY AUTO_INCREMENT
);

CREATE TABLE PessoaContato (
telefone 	VARCHAR(10) NOT NULL,
nome 		VARCHAR(50) NOT NULL,
codContato 	INTEGER PRIMARY KEY AUTO_INCREMENT,
codPac 		INTEGER		NOT NULL UNIQUE,
FOREIGN KEY(codPac) REFERENCES Paciente (codPaciente)
);

CREATE TABLE consulta (
codConsulta INTEGER PRIMARY KEY,
codMedico INTEGER,
codPaciente INTEGER,
diagnostico VARCHAR(200),
dataHora DATETIME,

FOREIGN KEY(codPaciente) REFERENCES Paciente (codPaciente),
FOREIGN KEY(codMedico) REFERENCES Medico (codMedico)
);

--Exibir tabelas existentes
SHOW TABLES;

--Exibir estrutura das tabelas
DESC medico;
DESC paciente;
DESC pessoaContato;
DESC consulta;


--Inserir dados nas tabelas

INSERT INTO medico VALUES(NULL, 'Edu', 'Ortopedia');
INSERT INTO medico VALUES(NULL, 'Mel', 'Cardiologia');
INSERT INTO medico VALUES(NULL, 'Nat', 'Pediatria');
INSERT INTO medico VALUES(NULL, 'Ana', 'Clinica Médica');

SELECT * FROM medico;

INSERT INTO paciente(codPaciente, nome, genero, dataNasc) VALUES(NULL, 'Mila', 'f', '1986-03-18'),
						   (NULL, 'Beto', 'm', '1973-08-25'),
						   (NULL, 'Rafa', 'f', '1990-05-12'),
						   (NULL, 'Cadu', 'm', '1961-11-05'),
						   (NULL, 'Duda', 'f', '2012-07-07'),
						   (NULL, 'Hugo', 'm', '1954-01-15'),
						   (NULL, 'Juca', 'm', '1991-10-21'),
						   (NULL, 'Luis', 'm', '1982-07-30');
						   
SELECT * FROM paciente;

INSERT INTO consulta(codConsulta, codMedico, codPaciente, diagnostico, dataHora)
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

--Manipulação da data no msql
SELECT CURRENT_DATE;		   
SELECT CURRENT_TIME;

SELECT SYSDATE() AS DATAHORA;
SELECT NOW() AS DATAHORA;

SELECT YEAR(2017-03-17) AS Ano;		   
SELECT MONTH(2017-03-17) AS Mes;
SELECT DAY(2017-03-17) AS Dia;

SELECT DATE_FORMAT('2017-05-20', '%d/%m/%y') AS Data_Formatada;
SELECT DATE_FORMAT(NOW(), '%D/%M/%Y - %H:%i') AS Data_Formatada;

SELECT nome, DATE_FORMAT(DataNasc, '%d/%m/%y') AS Nascimento
	FROM paciente;
	
SELECT DATEDIFF('2018-07-10', '2018-04-19');

SELECT nome,
	DATE_FORMAT(dataNasc, '%d/%m/%y') AS Nascimento,
	TRUNCATE(DATEDIFF(NOW(), dataNasc)/365, 0) AS idade
	FROM paciente;