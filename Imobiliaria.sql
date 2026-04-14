CREATE DATABASE imobiliaria_casa_certa;
USE imobiliaria_casa_certa;

CREATE TABLE CLIENTE (
id_cliente INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
cpf VARCHAR(14) UNIQUE NOT NULL,
telefone VARCHAR(20),
email VARCHAR(100),
endereco VARCHAR(150),
status_inadimplencia BOOLEAN DEFAULT FALSE
);

CREATE TABLE PROPRIETARIO (
id_proprietario INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
cpf VARCHAR(14) UNIQUE NOT NULL,
telefone VARCHAR(20),
email VARCHAR(100),
endereco VARCHAR(150)
);

CREATE TABLE CORRETOR (
id_corretor INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
creci VARCHAR(20) UNIQUE,
telefone VARCHAR(20),
email VARCHAR(100)
);

CREATE TABLE IMOVEL (
id_imovel INT AUTO_INCREMENT PRIMARY KEY,
tipo_imovel VARCHAR(50),
endereco VARCHAR(150),
cidade VARCHAR(50),
estado VARCHAR(50),
valor_venda DECIMAL(12,2),
valor_aluguel DECIMAL(10,2),
status_imovel VARCHAR(30),
id_proprietario INT,
FOREIGN KEY (id_proprietario) REFERENCES PROPRIETARIO(id_proprietario)
);

CREATE TABLE VISITA (
id_visita INT AUTO_INCREMENT PRIMARY KEY,
data_visita DATE,
observacoes VARCHAR(200),
id_cliente INT,
id_imovel INT,
id_corretor INT,
FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente),
FOREIGN KEY (id_imovel) REFERENCES IMOVEL(id_imovel),
FOREIGN KEY (id_corretor) REFERENCES CORRETOR(id_corretor)
);

CREATE TABLE CONTRATO (
id_contrato INT AUTO_INCREMENT PRIMARY KEY,
tipo_contrato VARCHAR(30),
data_inicio DATE,
data_fim DATE,
valor_contrato DECIMAL(10,2),
deposito DECIMAL(10,2),
status_contrato VARCHAR(30),
id_cliente INT,
id_imovel INT,
id_corretor INT,
FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente),
FOREIGN KEY (id_imovel) REFERENCES IMOVEL(id_imovel),
FOREIGN KEY (id_corretor) REFERENCES CORRETOR(id_corretor)
);

CREATE TABLE PAGAMENTO (
id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
data_pagamento DATE,
valor_pago DECIMAL(10,2),
forma_pagamento VARCHAR(30),
multa_atraso DECIMAL(10,2),
status_pagamento VARCHAR(30),
id_contrato INT,
FOREIGN KEY (id_contrato) REFERENCES CONTRATO(id_contrato)
);


INSERT INTO CLIENTE (nome, cpf, telefone, email, endereco) VALUES
('Carlos Silva','111.111.111-11','11988887777','carlos@email.com','Rua A, 120'),
('Ana Souza','222.222.222-22','11977776666','ana@email.com','Rua B, 350'),
('Pedro Santos','555.555.555-55','11966667777','pedro@email.com','Rua C, 80'),
('Mariana Alves','666.666.666-66','11955556666','mariana@email.com','Rua D, 220'),
('Lucas Ferreira','777.777.777-77','11944445555','lucas@email.com','Rua E, 410');


INSERT INTO PROPRIETARIO (nome, cpf, telefone, email, endereco) VALUES
('Marcos Oliveira','333.333.333-33','11999990000','marcos@email.com','Av Central, 200'),
('Fernanda Lima','444.444.444-44','11988889999','fernanda@email.com','Rua das Flores, 90'),
('Ricardo Gomes','888.888.888-88','11933334444','ricardo@email.com','Rua Nova, 100'),
('Patricia Andrade','999.999.999-99','11922223333','patricia@email.com','Av Paulista, 700');


INSERT INTO CORRETOR (nome, creci, telefone, email) VALUES
('João Pereira','CRECI12345','11966665555','joao@imobiliaria.com'),
('Juliana Costa','CRECI67890','11955554444','juliana@imobiliaria.com'),
('André Martins','CRECI11223','11944443333','andre@imobiliaria.com'),
('Carla Rocha','CRECI44556','11933332222','carla@imobiliaria.com');


INSERT INTO IMOVEL (tipo_imovel,endereco,cidade,estado,valor_venda,valor_aluguel,status_imovel,id_proprietario) VALUES
('Apartamento','Rua das Palmeiras 50','São Paulo','SP',450000,2500,'disponivel',1),
('Casa','Av Brasil 300','São Paulo','SP',650000,3500,'disponivel',2),
('Apartamento','Rua Azul 120','São Paulo','SP',380000,2100,'disponivel',3),
('Sala Comercial','Rua Comercial 40','São Paulo','SP',520000,2800,'disponivel',4),
('Casa','Rua Verde 98','São Paulo','SP',720000,4200,'disponivel',1),
('Apartamento','Av Paulista 1000','São Paulo','SP',900000,5000,'disponivel',2);


INSERT INTO VISITA (data_visita,observacoes,id_cliente,id_imovel,id_corretor) VALUES
('2026-05-10','Cliente gostou do imóvel',1,1,1),
('2026-05-11','Cliente pediu nova visita',2,2,2),
('2026-05-12','Cliente achou caro',3,3,3),
('2026-05-13','Cliente interessado',4,4,4),
('2026-05-14','Cliente quer negociar',5,5,1),
('2026-05-15','Cliente voltará com a família',1,6,2);


INSERT INTO CONTRATO (tipo_contrato,data_inicio,data_fim,valor_contrato,deposito,status_contrato,id_cliente,id_imovel,id_corretor) VALUES
('Aluguel','2026-06-01','2027-06-01',2500,5000,'ativo',1,1,1),
('Aluguel','2026-07-01','2027-07-01',3500,7000,'ativo',2,2,2),
('Aluguel','2026-08-01','2027-08-01',2100,4200,'ativo',3,3,3);


INSERT INTO PAGAMENTO (data_pagamento,valor_pago,forma_pagamento,multa_atraso,status_pagamento,id_contrato) VALUES
('2026-06-05',2500,'PIX',0,'pago',1),
('2026-07-05',2500,'Boleto',0,'pago',1),
('2026-07-03',3500,'Cartão',0,'pago',2),
('2026-08-05',3500,'PIX',0,'pago',2),
('2026-08-02',2100,'Boleto',0,'pago',3),
('2026-09-02',2100,'PIX',50,'pago',3);