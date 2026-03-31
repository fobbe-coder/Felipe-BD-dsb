


CREATE DATABASE locadora_rota_livre;
USE locadora_rota_livre;

CREATE TABLE CLIENTE (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100),
    endereco VARCHAR(150),
    status_inadimplencia BOOLEAN DEFAULT FALSE
);

CREATE TABLE CATEGORIA_VEICULO (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome_categoria VARCHAR(50) NOT NULL,
    valor_diaria DECIMAL(10,2) NOT NULL,
    descricao VARCHAR(200)
);

CREATE TABLE VEICULO (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(10) UNIQUE NOT NULL,
    modelo VARCHAR(50),
    marca VARCHAR(50),
    ano INT,
    quilometragem_atual INT,
    status_veiculo VARCHAR(30),
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES CATEGORIA_VEICULO(id_categoria)
);

CREATE TABLE RESERVA (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    data_reserva DATE,
    data_inicio DATE,
    data_fim_prevista DATE,
    status_reserva VARCHAR(30),
    id_cliente INT,
    id_veiculo INT,
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente),
    FOREIGN KEY (id_veiculo) REFERENCES VEICULO(id_veiculo)
);

CREATE TABLE CONTRATO_LOCACAO (
    id_contrato INT AUTO_INCREMENT PRIMARY KEY,
    data_retirada DATE,
    data_prevista_devolucao DATE,
    quilometragem_inicial INT,
    valor_diaria DECIMAL(10,2),
    tipo_seguro VARCHAR(50),
    condutor VARCHAR(100),
    status_contrato VARCHAR(30),
    id_cliente INT,
    id_veiculo INT,
    id_reserva INT,
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente),
    FOREIGN KEY (id_veiculo) REFERENCES VEICULO(id_veiculo),
    FOREIGN KEY (id_reserva) REFERENCES RESERVA(id_reserva)
);

CREATE TABLE DEVOLUCAO (
    id_devolucao INT AUTO_INCREMENT PRIMARY KEY,
    data_devolucao DATE,
    quilometragem_final INT,
    danos_identificados VARCHAR(200),
    combustivel_faltante DECIMAL(5,2),
    valor_adicional DECIMAL(10,2),
    id_contrato INT UNIQUE,
    FOREIGN KEY (id_contrato) REFERENCES CONTRATO_LOCACAO(id_contrato)
);

CREATE TABLE PAGAMENTO (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    data_pagamento DATE,
    valor DECIMAL(10,2),
    forma_pagamento VARCHAR(30),
    status_pagamento VARCHAR(30),
    id_contrato INT,
    FOREIGN KEY (id_contrato) REFERENCES CONTRATO_LOCACAO(id_contrato)
);

CREATE TABLE MULTA (
    id_multa INT AUTO_INCREMENT PRIMARY KEY,
    data_multa DATE,
    valor_multa DECIMAL(10,2),
    descricao VARCHAR(200),
    status_pagamento VARCHAR(30),
    id_contrato INT,
    FOREIGN KEY (id_contrato) REFERENCES CONTRATO_LOCACAO(id_contrato)
);

CREATE TABLE MANUTENCAO (
    id_manutencao INT AUTO_INCREMENT PRIMARY KEY,
    data_inicio DATE,
    data_fim DATE,
    tipo_manutencao VARCHAR(30),
    descricao_problema VARCHAR(200),
    custo DECIMAL(10,2),
    id_veiculo INT,
    FOREIGN KEY (id_veiculo) REFERENCES VEICULO(id_veiculo)
);

insert INTO CLIENTE (nome, cpf, telefone, email, endereco, status_inadimplencia) VALUES
('Felipe Barbosa','68591004515', '(11)97455-7643', 'felipebarbosa@gmail.com', 'Rua C, 129', false ),
('Ana Clara', '55231053125', '(11)95364-5467', 'anasantos@gmail.com', 'Rua A, 060', false),
('Rodolfo Justos', '68334742205', '(11)97473-1323', 'rodolfozin@hotmail.com', 'Rua H, 005', true),
('Camargo Aranha','89344435482', '(11)93567-0343', 'camargospider@gmail.com', 'Rua F, 305', true);

insert INTO CATEGORIA_VEICULO(nome_categoria, valor_diaria, descricao) values
('Carros alugados', '103.34', 'Carro em perfeito estado.'),
('Carros alugados', '499.99', 'Carro em perfeito estado.'),
('Carros alugados', '259.99', 'Carro Semi-novo'),
('Carros alugados', '657.32', 'Carro alugado');

INSERT INTO VEICULO (placa, modelo, marca, ano, quilometragem_atual, status_veiculo, id_categoria) VALUES
('LOC-6470', 'Ford Ka', 'Ford', 2010, 0, 'Disponível', 1),
('MVC-5345', 'Bugatti Veyron', 'Bugatti', 2017, 10000, 'Disponível', 2),
('JZC-7965', 'Camaro', 'Chevrolet', 2010, 0, 'Disponível', 3),
('CSX-2453', 'Fiat Uno', 'Fiat', 2015, 100, 'Disponível', 4);

INSERT INTO RESERVA (data_reserva, data_inicio, data_fim_prevista, status_reserva, id_cliente, id_veiculo) VALUES
('2026-03-01', '2026-03-05', '2026-03-10', 'Confirmada', 1, 1),
('2026-03-02', '2026-03-06', '2026-03-12', 'Pendente', 2, 2),
('2026-03-03', '2026-03-07', '2026-03-09', 'Cancelada', 3, 3),
('2026-03-04', '2026-03-08', '2026-03-15', 'Confirmada', 4, 4);

INSERT INTO CONTRATO_LOCACAO (data_retirada, data_prevista_devolucao, quilometragem_inicial, valor_diaria, tipo_seguro, condutor, status_contrato, id_cliente, id_veiculo, id_reserva) VALUES
('2026-03-05', '2026-03-10', 50000, 103.34, 'Básico', 'Felipe Barbosa', 'Ativo', 1, 1, 1),
('2026-03-06', '2026-03-12', 10000, 499.99, 'Completo', 'Ana Clara', 'Ativo', 2, 2, 2),
('2026-03-07', '2026-03-09', 75000, 259.99, 'Básico', 'Rodolfo Justos', 'Finalizado', 3, 3, 3),
('2026-03-08', '2026-03-15', 30000, 657.32, 'Premium', 'Camargo Aranha', 'Ativo', 4, 4, 4);

INSERT INTO DEVOLUCAO 
(data_devolucao, quilometragem_final, danos_identificados, combustivel_faltante, valor_adicional, id_contrato) VALUES
('2026-03-10', 50500, 'Nenhum', 0.00, 0.00, 1),
('2026-03-12', 10200, 'Arranhão leve', 5.00, 150.00, 2),
('2026-03-09', 76000, 'pneu dgastado', 2.00, 200.00, 3),
('2026-03-15', 30500, 'Nenhum', 0.00, 0.00, 4);

INSERT INTO PAGAMENTO 
(data_pagamento, valor, forma_pagamento, status_pagamento, id_contrato) VALUES
('2026-03-10', 516.70, 'Cartão', 'Pago', 1),
('2026-03-12', 2999.94, 'Pix', 'Pago', 2),
('2026-03-09', 519.98, 'Dinheiro', 'Pendente', 3),
('2026-03-15', 4601.24, 'Cartão', 'Pago', 4);

INSERT INTO MULTA (data_multa, valor_multa, descricao, status_pagamento, id_contrato) VALUES
('2026-03-10', 0.00, 'Sem multa', 'Isento', 1),
('2026-03-12', 150.00, 'Atraso na devolução', 'Pago', 2),
('2026-03-09', 200.00, 'Danos no veículo', 'Pendente', 3),
('2026-03-15', 0.00, 'Sem multa', 'Isento', 4);

INSERT INTO MANUTENCAO (data_inicio, data_fim, tipo_manutencao, descricao_problema, custo, id_veiculo) VALUES
('2026-03-11', '2026-03-12', 'Preventiva', 'Revisão geral', 300.00, 1),
('2026-03-13', '2026-03-14', 'Corretiva', 'Arranhão na lataria', 500.00, 2),
('2026-03-10', '2026-03-11', 'Corretiva', 'Troca de pneus', 800.00, 3),
('2026-03-16', '2026-03-17', 'Preventiva', 'Troca de óleo', 200.00, 4);

SELECT * FROM CLIENTE;
SELECT * FROM CATEGORIA_VEICULO;
SELECT * FROM VEICULO;
SELECT * FROM RESERVA;
SELECT * FROM CONTRATO_LOCACAO;
SELECT * FROM DEVOLUCAO;
SELECT * FROM PAGAMENTO;
SELECT * FROM MULTA;
SELECT * FROM MANUTENCAO;