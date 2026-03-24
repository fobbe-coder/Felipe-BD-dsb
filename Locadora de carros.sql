CREATE DATABASE locadora_rota_livre;
USE locadora_rota_livre;

CREATE TABLE CLIENTE (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
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

