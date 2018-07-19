-- Aula3 (continuação aula2) - 17/07/2018

-- Exibir os dependentes com grau de parentesco filho e filha, em uma ordem que os filhos 
-- sejam exibidos primeiro.
SELECT * FROM dependente
	WHERE grauParent = 'Filho' OR grauParent = 'Filha'
	ORDER BY grauParent DESC, nome;
	
SELECT * FROM dependente
	WHERE grauParent IN('Filho', 'Filha')
	ORDER BY grauParent DESC, nome;
	
SELECT * FROM dependente
	WHERE grauParent NOT IN('Filho', 'Filha')
	ORDER BY grauParent DESC, nome;

-- Consultas em 2 tabelas (Sintax Defazada).

SELECT nome, rua, bairro, cidade
	FROM funcionario, endereco
	WHERE codFuncionario = cod_func;

SELECT nome, rua, bairro, cidade, uf
	FROM funcionario, endereco
	WHERE codFuncionario = cod_func
	AND uf = 'RJ';
	
-- Exibir o nome dos funcionarios, o nome de seus dependentes e o grau parentesco.
SELECT funcionario.nome, 
	dependente.nome, grauParent
	FROM funcionario, dependente
	WHERE codFuncionario = cod_func;

-- Consultas em 2 tabelas usando JOIN.
SELECT nome, rua, bairro, cidade
	FROM funcionario INNER JOIN endereco
	ON codFuncionario = cod_func;

SELECT nome, rua, bairro, cidade, uf
	FROM funcionario INNER JOIN endereco
	ON codFuncionario = cod_func
	WHERE uf = 'RJ';

-- ALIAS - Apelidar campos e tabelas.
SELECT f.nome AS NomeFunc, 
	d.nome AS NomeDependente, grauParent
	FROM funcionario f INNER JOIN dependente d
	ON codFuncionario = cod_func;
	
-- Exibir os dados de todos os funcionários, e o nome e telefone dos dependentes para quem possui.

SELECT f.nome AS NomeFunc, cpf, salario,
	d.nome AS NomeDep, telefone
	FROM funcionario f LEFT JOIN dependente d
	ON codFuncionario = cod_func;

SELECT f.nome AS NomeFunc, cpf, salario,
	d.nome AS NomeDep, telefone
	FROM dependente d RIGHT JOIN funcionario f
	ON codFuncionario = cod_func;






