CREATE DATABASE SQLTeste
USE SQLTeste

CREATE TABLE Tb_Pessoa
 (
 Pessoa_Id INT PRIMARY KEY,
 Nome_Fk INT FOREIGN KEY REFERENCES Tb_Pessoa (Pessoa_Id) NOT NULL,
 Cidade VARCHAR(50) UNIQUE,
 Idade INT CHECK (Idade >18),
 Data DATE DEFAULT GETDATE()
 )






 /*

 -- Para adicionar uma constraint quando ja tem a coluna criada
 ALTER TABLE TB_Pessoa
 ADD CONSTRAINT pk_PersonID PRIMARY KEY (P_Id,LastName) 

 -- Para criar uma restrição DEFAULT 

 ALTER TABLE TB_Pessoa
 ALTER COLUMN Cidade SET DEFAULT 'SANDNES'

 -- Para eliminar uma restrição padrão

 ALTER TABLE TB_Pessoa
 ALTER COLUMN City DROP DEFAULT