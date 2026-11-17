CREATE DATABASE IF NOT EXISTS Solucao_Imobiliaria
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE Solucao_Imobiliaria;


CREATE TABLE IMOBILIARIA (
    id_imobiliaria INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    cnpj VARCHAR(18) UNIQUE,
    email VARCHAR(150),
    telefone VARCHAR(20),
    endereco VARCHAR(255),
    status VARCHAR(30) DEFAULT 'Ativa'
);


CREATE TABLE CORRETOR (
    id_corretor INT AUTO_INCREMENT PRIMARY KEY,
    id_imobiliaria INT NOT NULL,
    nome VARCHAR(150) NOT NULL,
    creci VARCHAR(30) UNIQUE,
    email VARCHAR(150) UNIQUE,
    telefone VARCHAR(20),
    status VARCHAR(30) DEFAULT 'Ativo',

    FOREIGN KEY (id_imobiliaria)
        REFERENCES IMOBILIARIA(id_imobiliaria)
);


CREATE TABLE BAIRRO (
    id_bairro INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    municipio VARCHAR(100) NOT NULL DEFAULT 'São Paulo',
    latitude DECIMAL(10, 7),
    longitude DECIMAL(10, 7),

    UNIQUE (nome, municipio)
);


CREATE TABLE POTENCIAL_CLIENTE (
    id_lead INT AUTO_INCREMENT PRIMARY KEY,
    id_imobiliaria INT NOT NULL,
    id_corretor INT NULL,
    id_bairro INT NULL,
    nome VARCHAR(150) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(150),
    tipo_interesse VARCHAR(30),
    faixa_valor DECIMAL(12, 2),
    origem VARCHAR(50),
    status VARCHAR(40) DEFAULT 'Novo',
    pontuacao_qualificacao DECIMAL(5, 2),
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_imobiliaria)
        REFERENCES IMOBILIARIA(id_imobiliaria),

    FOREIGN KEY (id_corretor)
        REFERENCES CORRETOR(id_corretor),

    FOREIGN KEY (id_bairro)
        REFERENCES BAIRRO(id_bairro)
);


CREATE TABLE INTERACAO (
    id_interacao INT AUTO_INCREMENT PRIMARY KEY,
    id_lead INT NOT NULL,
    id_corretor INT NULL,
    canal VARCHAR(50) NOT NULL,
    tipo_interacao VARCHAR(50),
    descricao TEXT,
    data_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(40),

    FOREIGN KEY (id_lead)
        REFERENCES POTENCIAL_CLIENTE(id_lead),

    FOREIGN KEY (id_corretor)
        REFERENCES CORRETOR(id_corretor)
);


CREATE TABLE SESSAO_TRABALHO (
    id_sessao INT AUTO_INCREMENT PRIMARY KEY,
    id_corretor INT NOT NULL,
    inicio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fim DATETIME NULL,
    duracao_minutos INT,
    status VARCHAR(30) DEFAULT 'Iniciada',

    FOREIGN KEY (id_corretor)
        REFERENCES CORRETOR(id_corretor)
);


CREATE TABLE NEGOCIO (
    id_negocio INT AUTO_INCREMENT PRIMARY KEY,
    id_lead INT NOT NULL,
    id_corretor INT NOT NULL,
    id_imobiliaria INT NOT NULL,
    tipo_negocio VARCHAR(30) NOT NULL,
    valor_imovel DECIMAL(15, 2),
    comissao DECIMAL(12, 2),
    data_negocio DATE,
    status VARCHAR(40) DEFAULT 'Em andamento',

    FOREIGN KEY (id_lead)
        REFERENCES POTENCIAL_CLIENTE(id_lead),

    FOREIGN KEY (id_corretor)
        REFERENCES CORRETOR(id_corretor),

    FOREIGN KEY (id_imobiliaria)
        REFERENCES IMOBILIARIA(id_imobiliaria)
);


CREATE TABLE CUSTO_AQUISICAO (
    id_custo INT AUTO_INCREMENT PRIMARY KEY,
    id_imobiliaria INT NOT NULL,
    canal VARCHAR(50),
    descricao TEXT,
    valor DECIMAL(12, 2) NOT NULL,
    data_referencia DATE NOT NULL,

    FOREIGN KEY (id_imobiliaria)
        REFERENCES IMOBILIARIA(id_imobiliaria)
);


CREATE TABLE INTEGRACAO (
    id_integracao INT AUTO_INCREMENT PRIMARY KEY,
    id_imobiliaria INT NULL,
    id_corretor INT NULL,
    plataforma VARCHAR(50) NOT NULL,
    identificador_externo VARCHAR(255),
    status VARCHAR(30) DEFAULT 'Inativa',
    data_conexao DATETIME,

    FOREIGN KEY (id_imobiliaria)
        REFERENCES IMOBILIARIA(id_imobiliaria),

    FOREIGN KEY (id_corretor)
        REFERENCES CORRETOR(id_corretor)
);


CREATE TABLE ANALISE_IA (
    id_analise INT AUTO_INCREMENT PRIMARY KEY,
    id_imobiliaria INT NOT NULL,
    id_corretor INT NULL,
    tipo_analise VARCHAR(100),
    periodo_referencia VARCHAR(50),
    resultado TEXT,
    recomendacao TEXT,
    data_analise DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_imobiliaria)
        REFERENCES IMOBILIARIA(id_imobiliaria),

    FOREIGN KEY (id_corretor)
        REFERENCES CORRETOR(id_corretor)
);