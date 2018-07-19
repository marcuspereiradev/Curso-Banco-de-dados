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

-- Consultas.

-- Exibir o nome e a data de nascimento dos pacientes nascidos antes de 1980.
SELECT nome, dataNasc 
	FROM paciente WHERE dataNasc < '1980-01-01';

SELECT nome, DATE_FORMAT(dataNasc, '%d/%m/%Y') AS nascimento
	FROM paciente WHERE YEAR(dataNasc) < 1980;
-- Exibir o nome e a data de nascimento dos pacientes que fazem aniversário no mês atual.
SELECT nome, DATE_FORMAT(dataNasc, '%d/%m/%Y') AS nascimento
	FROM paciente WHERE MONTH(dataNasc) = MONTH(NOW());
	
-- Exibir o nome e a especialidade dos médicos e as datas em que atenderam.
SELECT nome, espec, dataHora
	fROM medico INNER JOIN consulta
	ON codMedico = cod_med;
	--ou
SELECT nome, espec, 
	DATE_FORMAT(dataHora, '%d/%m/%Y - %H:%i') AS DataHoraAtend
	fROM medico INNER JOIN consulta
	ON codMedico = cod_med;
	--ou
SELECT nome, espec, 
	DATE_FORMAT(dataHora, '%d/%m/%Y') AS DataAtend,
	DATE_FORMAT(dataHora, '%H:%i') AS HoraAtend
	fROM medico INNER JOIN consulta
	ON codMedico = cod_med;
-- Exibir o nome e a especialidade dos médicos e as datas em que atenderam.
-- Somente atendimentos da ortopedia e clinica médica.
SELECT nome, espec, 
	DATE_FORMAT(dataHora, '%d/%m/%Y') AS DataAtend,
	DATE_FORMAT(dataHora, '%H:%i') AS HoraAtend
	fROM medico INNER JOIN consulta
	ON codMedico = cod_med WHERE espec = 'ortopedia' OR espec = 'Clinica Medica';
	--ou
SELECT nome, espec, 
	DATE_FORMAT(dataHora, '%d/%m/%Y') AS DataAtend,
	DATE_FORMAT(dataHora, '%H:%i') AS HoraAtend
	fROM medico INNER JOIN consulta
	ON codMedico = cod_med WHERE espec IN('ortopedia', 'Clinica Medica');

-- Exibir nome, gênero e diagnóstico dos pacientes.
SELECT nome, genero, diagnostico
	FROM paciente INNER JOIN consulta
	ON codPaciente = cod_pac;
	
-- Exibir nome, gênero e diagnóstico dos pacientes. Somente consultas realizadas em 
-- janeiro e fevereiro de 2018.
SELECT nome, genero, diagnostico,
	DATE_FORMAT(dataHora, '%d/%m/%Y - %H:%i') AS DataHoraAtend
	FROM paciente INNER JOIN consulta
	ON codPaciente = cod_pac 
	WHERE YEAR(dataHora) = 2018 AND MONTH(dataHora) IN(1,2);
	
	
	
-- Exibir todos os pacientes, caso tenha informado um contato, exibir os dados deste.
SELECT p.nome AS NomePac, pc.nome AS NomeCont, telefone
	FROM paciente p LEFT JOIN pessoaContato pc
	ON codPaciente = codPac;
	
--Consultas em mais de dsuas tabelas
SELECT medico.nome AS NomeMed, paciente.nome AS NomePac, diagnostico
	FROM medico
	INNER JOIN consulta ON codMedico = cod_med
	INNER JOIN paciente ON codPaciente = cod_pac;
	
SELECT medico.nome AS NomeMed, espec, 
	paciente.nome AS NomePac, genero,
	DATE_FORMAT(DataNasc, '%d/%m/%y') AS Nascimento,
	TRUNCATE(DATEDIFF(dataNasc, dataNasc)/365, 0) AS idadeAtend,
	diagnostico,
	DATE_FORMAT(dataHora, '%d/%m/%y') AS dataAtend,
	DATE_FORMAT(dataHora, '%H:%i') AS HoraAtend
	FROM medico
	INNER JOIN consulta ON codMedico = cod_med
	INNER JOIN paciente ON codPaciente = cod_pac;
	
-- VIEW - Objeto que armazena uma query(consulta).
CREATE VIEW relAtendimento AS
SELECT medico.nome AS NomeMed, espec, 
	paciente.nome AS NomePac, genero,
	DATE_FORMAT(DataNasc, '%d/%m/%y') AS Nascimento,
	TRUNCATE(DATEDIFF(dataNasc, dataNasc)/365, 0) AS idadeAtend,
	diagnostico,
	DATE_FORMAT(dataHora, '%d/%m/%y') AS dataAtend,
	DATE_FORMAT(dataHora, '%H:%i') AS HoraAtend
	FROM medico
	INNER JOIN consulta ON codMedico = cod_med
	INNER JOIN paciente ON codPaciente = cod_pac;
	
SELECT * FROM relAtendimento;
SELECT NomeMed, NomePac, DataAtend FROM relAtendimento;

--Exportar dados para arquivos
--C:\ProgramData\MySQL\MySQL Server 5.6\Uploads temque inverter as brras dentro da query
SELECT * INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 5.6/Uploads/pacientes.txt' FROM paciente;

SELECT * INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 5.6/Uploads/paciente.csv'
	FIELDS TERMINATED BY ';'
	LINES TERMINATED BY '\n'
FROM paciente;

SELECT * INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 5.6/Uploads/relAtendimento.csv'
	FIELDS TERMINATED BY ';'
	LINES TERMINATED BY '\n'
FROM relAtendimento;

--Criar copia de uma tabela sem os dados.
CREATE TABLE CopiaPaciente(LIKE paciente);
DESC CopiaPaciente;
SELECT * FROM CopiaPaciente;

--Importar dados de um arquivo