-- Aula4 (continuação aula3) - 19/07/2018

-- Utilizar a mesma base de dados da aula anterior.
USE aula3;

-- Consultas.

-- Exibir o nome e a data de nascimento dos pacientes nascidos antes de 1980.
SELECT nome, dataNasc
	FROM paciente WHERE dataNasc < '1980-01-01';

SELECT nome, DATE_FORMAT(dataNasc, '%d/%m/%Y') AS Nascimento
	FROM paciente WHERE YEAR(dataNasc) < 1980;
	
-- Exibir o nome e a data de nascimento dos pacientes que fazem aniversário no mês atual.
SELECT nome, DATE_FORMAT(dataNasc, '%d/%m/%Y') AS Nascimento
	FROM paciente WHERE MONTH(dataNasc) = MONTH(NOW());
	
-- Exibir o nome e a especialidade dos médicos e as datas em que atenderam.
SELECT nome, espec, dataHora
	FROM medico INNER JOIN consulta
	ON codMedico = cod_med;

SELECT nome, espec, 
	DATE_FORMAT(dataHora, '%d/%m/%y - %H:%i') AS DataHoraAtend
	FROM medico INNER JOIN consulta
	ON codMedico = cod_med;
	
SELECT nome, espec, 
	DATE_FORMAT(dataHora, '%d/%m/%y') AS DataAtend,
	DATE_FORMAT(dataHora, '%H:%i') AS HoraAtend
	FROM medico INNER JOIN consulta
	ON codMedico = cod_med;	
	
-- Exibir o nome e a especialidade dos médicos e as datas em que atenderam.
-- Somente atendimentos da ortopedia e clinica médica.
SELECT nome, espec, 
	DATE_FORMAT(dataHora, '%d/%m/%y - %H:%i') AS DataHoraAtend
	FROM medico INNER JOIN consulta
	ON codMedico = cod_med
	WHERE espec = 'ortopedia' OR espec = 'clinica médica';

SELECT nome, espec, 
	DATE_FORMAT(dataHora, '%d/%m/%y - %H:%i') AS DataHoraAtend
	FROM medico INNER JOIN consulta
	ON codMedico = cod_med
	WHERE espec IN('ortopedia', 'clinica médica');

-- Exibir nome, gênero e diagnóstico dos pacientes.
SELECT nome, genero, diagnostico
	FROM paciente INNER JOIN consulta
	ON codPaciente = cod_pac;
	
-- Exibir nome, gênero e diagnóstico dos pacientes. Somente consultas realizadas em 
-- janeiro e fevereiro de 2018.
SELECT nome, genero, diagnostico,
	DATE_FORMAT(dataHora, '%d/%m/%y - %H:%i') AS DataHoraAtend
	FROM paciente INNER JOIN consulta
	ON codPaciente = cod_pac
	WHERE dataHora >= '2018-01-01' AND dataHora < '2018-03-01';
	
SELECT nome, genero, diagnostico,
	DATE_FORMAT(dataHora, '%d/%m/%y - %H:%i') AS DataHoraAtend
	FROM paciente INNER JOIN consulta
	ON codPaciente = cod_pac
	WHERE YEAR(dataHora) = 2018 AND MONTH(dataHora) IN(1, 2);
	
-- Exibir todos os pacientes. Caso tenha informado um contato, exibir os dados deste.
SELECT p.nome AS NomePac, pc.nome AS NomeCont, telefone
	FROM paciente p LEFT JOIN pessoaContato pc
	ON codPaciente = codPac;
	
-- Consultas em mais de duas tabelas.
SELECT medico.nome AS NomeMed, 
	paciente.nome AS NomePac, diagnostico
	FROM medico
	INNER JOIN consulta ON codMedico = cod_med
	INNER JOIN paciente ON codPaciente = cod_pac;

SELECT medico.nome AS NomeMed, espec,
	paciente.nome AS NomePac, genero,
	DATE_FORMAT(dataNasc, '%d/%m/%Y') AS Nascimento,
	TRUNCATE(DATEDIFF(dataHora, dataNasc)/365, 0) AS IdadeAtend,
	diagnostico,
	DATE_FORMAT(dataHora, '%d/%m/%y') AS DataAtend,
	DATE_FORMAT(dataHora, '%H:%i') AS HoraAtend
	FROM medico
	INNER JOIN consulta ON codMedico = cod_med
	INNER JOIN paciente ON codPaciente = cod_pac;
	
-- VIEW - Objeto que armazena uma query(consulta).
CREATE VIEW relAtendimento AS
SELECT medico.nome AS NomeMed, espec,
	paciente.nome AS NomePac, genero,
	DATE_FORMAT(dataNasc, '%d/%m/%Y') AS Nascimento,
	TRUNCATE(DATEDIFF(dataHora, dataNasc)/365, 0) AS IdadeAtend,
	diagnostico,
	DATE_FORMAT(dataHora, '%d/%m/%y') AS DataAtend,
	DATE_FORMAT(dataHora, '%H:%i') AS HoraAtend
	FROM medico
	INNER JOIN consulta ON codMedico = cod_med
	INNER JOIN paciente ON codPaciente = cod_pac;	
	
SELECT * FROM relAtendimento;
SELECT NomeMed, NomePac, DataAtend FROM relAtendimento;
	
INSERT INTO consulta VALUES(NULL, 4, 6, 'Teste de View', NOW());
	
SELECT * FROM relAtendimento;
	
-- Exportar dados para arquivos.
SELECT * INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 5.6/Uploads/paciente.txt' FROM paciente;

SELECT * INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 5.6/Uploads/paciente.csv' 
	FIELDS TERMINATED BY ';'
	LINES TERMINATED BY '\n'
FROM paciente;

SELECT * INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 5.6/Uploads/atendimentos.csv' 
	FIELDS TERMINATED BY ';'
	LINES TERMINATED BY '\n'
FROM relAtendimento;

-- Criar cópia de uma tabela sem os dados.
CREATE TABLE copiaPaciente(LIKE paciente);

DESC copiaPaciente;
SELECT * FROM copiaPaciente;

-- Importar dados de um arquivo.
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 5.6/Uploads/paciente.txt' INTO TABLE copiaPaciente;

SELECT * FROM copiaPaciente;






