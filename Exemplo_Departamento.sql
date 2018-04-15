use SQLTeste

CREATE TABLE Departamento_A 
(
NOME VARCHAR(20), 
CARGO VARCHAR (20), 
FUNCAO_ATIVO BIT
)
 

 
INSERT INTO Departamento_A 
VALUES 
('Thiago Cruz','Analista de Dados',1),
('Joao Vilar','analista de Dados',1),
('Pedro Vieira','Analista de Dados',0),
('Fernando Silva','Analista de Dados',1),
('Paulo André','Analista de Dados',0)
 
 
CREATE TABLE Departamento_B
(
NOME VARCHAR(20), 
CARGO VARCHAR (20), 
FUNCAO_ATIVO BIT
)
 
 
INSERT INTO Departamento_B
 VALUES 
('Maria Eduarda','Desenvolvedor',1),
('Fernando Silva','Desenvolvedor',1),
('Wallas Igor','Desenvolvedor',0),
('Andre Santos','Desenvolvedor',1),
('Paulo André','Desenvolvedor',0),
('Lucas Menezes','Desenvolvedor',1)
 

 SELECT NOME FROM Departamento_A
 UNION 
 SELECT NOME FROM Departamento_B


 SELECT NOME FROM Departamento_A
 UNION ALL
 SELECT NOME FROM Departamento_B


 SELECT NOME FROM Departamento_A
 INTERSECT
 SELECT NOME FROM Departamento_B


 SELECT NOME FROM Departamento_A
 EXCEPT
 SELECT NOME FROM Departamento_B