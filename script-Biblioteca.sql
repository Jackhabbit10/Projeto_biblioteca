create database bdBiblioteca;
use bdBiblioteca;

create table Usuarios(
id int primary key auto_increment,
nome varchar(100),
email varchar(100),
senha_hash varchar(255),
role enum ("Bibliotecario","Admin"),
ativo tinyint(1) default 1 ,
criado_Em datetime default current_timestamp
);

CREATE TABLE editora (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(150) NOT NULL,
  criado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE genero (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL,
  criado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE autor (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(150) NOT NULL,
  criado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE livros(
	id int primary key auto_increment, 
    titulo varchar (250),
    autor int,
    editora int,
    genero int,
    ano int,
    isbn varchar(32),
    quantidade_total int,
    quantidade_disponivel int,
    criado_em datetime default current_timestamp
);

ALTER TABLE livros
 ADD CONSTRAINT fk_livros_autor
	FOREIGN KEY (autor) REFERENCES autor(id);
    
ALTER TABLE livros
 ADD CONSTRAINT fk_livros_editora
	FOREIGN KEY (editora) REFERENCES editora(id); 

ALTER TABLE livros
 ADD CONSTRAINT fk_livros_genero
	FOREIGN KEY (genero) REFERENCES genero(id);    

/*Procedure Usuario*/
DELIMITER $$
	DROP PROCEDURE IF EXISTS sp_usuario_criar $$
	CREATE PROCEDURE sp_usuario_criar (
		IN p_nome VARCHAR(100),
        IN p_email VARCHAR(100),
        IN p_senha_hash VARCHAR(255),
        IN p_role VARCHAR(20)
    )
    BEGIN
		INSERT INTO Usuarios (nome, email, senha_Hash, role, ativo, criado_Em) 
        VALUES (p_nome, p_email, p_senha_hash, p_role, 1 , NOW());
    END $$
DELIMITER ;

/*Procedure Gnero*/
DELIMITER $$
	DROP PROCEDURE IF EXISTS sp_genero_criar $$
	CREATE PROCEDURE sp_genero_criar (
		IN p_nome VARCHAR(100)
    )
    BEGIN
		INSERT INTO genero (nome, criado_em) 
        VALUES (p_nome, NOW());
    END $$
DELIMITER ;

/*Procedure Autor*/
DELIMITER $$
	DROP PROCEDURE IF EXISTS sp_autor_criar $$
	CREATE PROCEDURE sp_autor_criar (
		IN p_nome VARCHAR(100)
    )
    BEGIN
		INSERT INTO autor (nome, criado_em) 
        VALUES (p_nome, NOW());
    END $$
DELIMITER ;

/*Procedure Livros*/
DELIMITER $$
	DROP PROCEDURE IF EXISTS sp_livro_criar $$
	CREATE PROCEDURE sp_livro_criar (
		IN p_titulo VARCHAR(250),
        IN p_autor int,
        IN p_editora int,
        IN p_genero int,
        IN p_ano int,
        IN p_isbn VARCHAR(32),
        IN p_quantidade_total int,
        IN p_quantidade_disponivel int
    )
    BEGIN
		INSERT INTO livros (titulo, autor, editora, genero, ano, isbn, quantidade_total, quantidade_disponivel, criado_em) 
        VALUES (p_titulo, p_autor, p_editora, p_genero,p_ano,p_isbn,p_quantidade_total, p_quantidade_disponivel, NOW());
    END $$
DELIMITER ;

CALL sp_usuario_criar(
    'João Admin',
    'joao@biblioteca.com',
    '$2a$11$HASHADMINEXEMPLO9876543210',
    'Admin'
);

CALL sp_genero_criar(
    'Terror'
);

CALL sp_genero_criar(
    'Terror'
);

CALL sp_autor_criar(
    'Machado de Assis'
);

CALL sp_livro_criar(
    'Memorias Póstumulas de Brás Cubas',
    1,
    1,
    3,
    1881,
    9783161484100,
    40,
    20
);

select * from Usuarios;
select * from genero;
select * from autor;
select * from livros;
select * from editora;

insert into editora values (null, 'Clássica Edições', NOW());