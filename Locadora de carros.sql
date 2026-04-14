


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


INSERT INTO CLIENTE (nome, cpf, telefone, email, endereco, status_inadimplencia) VALUES
('Felipe Barbosa','68591004515', '(11)97455-7643', 'felipebarbosa@gmail.com', 'Rua C, 129', false),
('Ana Clara', '55231053125', '(11)95364-5467', 'anasantos@gmail.com', 'Rua A, 060', false),
('Rodolfo Justos', '68334742205', '(11)97473-1323', 'rodolfozin@hotmail.com', 'Rua H, 005', true),
('Camargo Aranha','89344435482', '(11)93567-0343', 'camargospider@gmail.com', 'Rua F, 305', true),
('Juliana Souza','12345678901','(11)98888-1111','juliana@gmail.com','Rua B, 22',false),
('Carlos Mendes','98765432100','(11)97777-2222','carlos@gmail.com','Rua D, 55',false),
('Fernanda Lima','45612378900','(11)96666-3333','fernanda@gmail.com','Rua E, 77',true),
('Paulo Ricardo','32165498700','(11)95555-4444','paulo@gmail.com','Rua G, 99',false),
('Mariana Alves','74125896300','(11)94444-5555','mariana@gmail.com','Rua I, 11',false),
('Lucas Rocha','15975348620','(11)93333-6666','lucas@gmail.com','Rua J, 88',true);


INSERT INTO CATEGORIA_VEICULO(nome_categoria, valor_diaria, descricao) VALUES
('Carros alugados',103.34,'Carro em perfeito estado.'),
('Carros alugados',499.99,'Carro premium.'),
('Carros alugados',259.99,'Carro semi-novo'),
('Carros alugados',657.32,'Carro de luxo'),
('SUV',300.00,'Veículo espaçoso'),
('SUV',450.00,'SUV premium'),
('Econômico',120.00,'Baixo consumo'),
('Econômico',150.00,'Modelo compacto'),
('Luxo',800.00,'Alta performance'),
('Luxo',950.00,'Super esportivo'),
('Utilitário',200.00,'Carga leve'),
('Utilitário',280.00,'Transporte urbano');


INSERT INTO VEICULO (placa, modelo, marca, ano, quilometragem_atual, status_veiculo, id_categoria) VALUES
('LOC-6470','Ford Ka','Ford',2010,0,'Disponível',1),
('MVC-5345','Bugatti Veyron','Bugatti',2017,10000,'Disponível',2),
('JZC-7965','Camaro','Chevrolet',2010,0,'Disponível',3),
('CSX-2453','Fiat Uno','Fiat',2015,100,'Disponível',4),
('AAA-1111','Onix','Chevrolet',2020,5000,'Disponível',5),
('BBB-2222','HB20','Hyundai',2021,3000,'Disponível',6),
('CCC-3333','Corolla','Toyota',2019,20000,'Disponível',7),
('DDD-4444','Civic','Honda',2018,15000,'Disponível',8),
('EEE-5555','Compass','Jeep',2022,4000,'Disponível',9),
('FFF-6666','Renegade','Jeep',2021,6000,'Disponível',10),
('GGG-7777','Strada','Fiat',2020,8000,'Disponível',11),
('HHH-8888','Hilux','Toyota',2022,7000,'Disponível',12);


INSERT INTO RESERVA (data_reserva, data_inicio, data_fim_prevista, status_reserva, id_cliente, id_veiculo) VALUES
('2026-03-01','2026-03-05','2026-03-10','Confirmada',1,1),
('2026-03-02','2026-03-06','2026-03-12','Pendente',2,2),
('2026-03-03','2026-03-07','2026-03-09','Cancelada',3,3),
('2026-03-04','2026-03-08','2026-03-15','Confirmada',4,4),
('2026-03-05','2026-03-09','2026-03-11','Confirmada',5,5),
('2026-03-06','2026-03-10','2026-03-13','Pendente',6,6),
('2026-03-07','2026-03-11','2026-03-14','Confirmada',7,7),
('2026-03-08','2026-03-12','2026-03-16','Cancelada',8,8),
('2026-03-09','2026-03-13','2026-03-18','Confirmada',9,9),
('2026-03-10','2026-03-14','2026-03-19','Pendente',10,10),
('2026-03-11','2026-03-15','2026-03-20','Confirmada',1,11),
('2026-03-12','2026-03-16','2026-03-21','Confirmada',2,12);


INSERT INTO CONTRATO_LOCACAO (data_retirada, data_prevista_devolucao, quilometragem_inicial, valor_diaria, tipo_seguro, condutor, status_contrato, id_cliente, id_veiculo, id_reserva) VALUES
('2026-03-05','2026-03-10',50000,103.34,'Básico','Felipe Barbosa','Ativo',1,1,1),
('2026-03-06','2026-03-12',10000,499.99,'Completo','Ana Clara','Ativo',2,2,2),
('2026-03-07','2026-03-09',75000,259.99,'Básico','Rodolfo Justos','Finalizado',3,3,3),
('2026-03-08','2026-03-15',30000,657.32,'Premium','Camargo Aranha','Ativo',4,4,4),
('2026-03-09','2026-03-11',20000,300.00,'Básico','Juliana Souza','Ativo',5,5,5),
('2026-03-10','2026-03-13',15000,450.00,'Completo','Carlos Mendes','Ativo',6,6,6),
('2026-03-11','2026-03-14',18000,120.00,'Básico','Fernanda Lima','Finalizado',7,7,7),
('2026-03-12','2026-03-16',22000,150.00,'Básico','Paulo Ricardo','Ativo',8,8,8),
('2026-03-13','2026-03-18',5000,800.00,'Premium','Mariana Alves','Ativo',9,9,9),
('2026-03-14','2026-03-19',7000,950.00,'Premium','Lucas Rocha','Ativo',10,10,10),
('2026-03-15','2026-03-20',9000,200.00,'Básico','Felipe Barbosa','Ativo',1,11,11),
('2026-03-16','2026-03-21',11000,280.00,'Completo','Ana Clara','Ativo',2,12,12);

INSERT INTO DEVOLUCAO 
(data_devolucao, quilometragem_final, danos_identificados, combustivel_faltante, valor_adicional, id_contrato) VALUES
('2026-03-10',50500,'Nenhum',0.00,0.00,1),
('2026-03-12',10200,'Arranhão leve',5.00,150.00,2),
('2026-03-09',76000,'Pneu desgastado',2.00,200.00,3),
('2026-03-15',30500,'Nenhum',0.00,0.00,4),
('2026-03-11',21000,'Nenhum',1.00,50.00,5),
('2026-03-13',15500,'Arranhão',3.00,120.00,6),
('2026-03-14',18500,'Nenhum',0.00,0.00,7),
('2026-03-16',23000,'Vidro trincado',4.00,300.00,8),
('2026-03-18',5500,'Nenhum',0.00,0.00,9),
('2026-03-19',7500,'Amassado leve',2.00,180.00,10),
('2026-03-20',9500,'Nenhum',0.00,0.00,11),
('2026-03-21',11500,'Nenhum',0.00,0.00,12);

INSERT INTO PAGAMENTO 
(data_pagamento, valor, forma_pagamento, status_pagamento, id_contrato) VALUES
('2026-03-10',516.70,'Cartão','Pago',1),
('2026-03-12',2999.94,'Pix','Pago',2),
('2026-03-09',519.98,'Dinheiro','Pendente',3),
('2026-03-15',4601.24,'Cartão','Pago',4),
('2026-03-11',600.00,'Pix','Pago',5),
('2026-03-13',1350.00,'Cartão','Pago',6),
('2026-03-14',360.00,'Dinheiro','Pago',7),
('2026-03-16',600.00,'Pix','Pendente',8),
('2026-03-18',4000.00,'Cartão','Pago',9),
('2026-03-19',4750.00,'Pix','Pago',10),
('2026-03-20',1000.00,'Dinheiro','Pago',11),
('2026-03-21',1680.00,'Cartão','Pago',12);


INSERT INTO MULTA 
(data_multa, valor_multa, descricao, status_pagamento, id_contrato) VALUES
('2026-03-10',0.00,'Sem multa','Isento',1),
('2026-03-12',150.00,'Atraso na devolução','Pago',2),
('2026-03-09',200.00,'Danos no veículo','Pendente',3),
('2026-03-15',0.00,'Sem multa','Isento',4),
('2026-03-11',50.00,'Combustível baixo','Pago',5),
('2026-03-13',120.00,'Arranhão','Pago',6),
('2026-03-14',0.00,'Sem multa','Isento',7),
('2026-03-16',300.00,'Vidro danificado','Pendente',8),
('2026-03-18',0.00,'Sem multa','Isento',9),
('2026-03-19',180.00,'Amassado leve','Pago',10),
('2026-03-20',0.00,'Sem multa','Isento',11),
('2026-03-21',0.00,'Sem multa','Isento',12);


INSERT INTO MANUTENCAO 
(data_inicio, data_fim, tipo_manutencao, descricao_problema, custo, id_veiculo) VALUES
('2026-03-11','2026-03-12','Preventiva','Revisão geral',300.00,1),
('2026-03-13','2026-03-14','Corretiva','Arranhão na lataria',500.00,2),
('2026-03-10','2026-03-11','Corretiva','Troca de pneus',800.00,3),
('2026-03-16','2026-03-17','Preventiva','Troca de óleo',200.00,4),
('2026-03-12','2026-03-13','Preventiva','Revisão básica',250.00,5),
('2026-03-14','2026-03-15','Corretiva','Freio gasto',600.00,6),
('2026-03-15','2026-03-16','Preventiva','Alinhamento',150.00,7),
('2026-03-17','2026-03-18','Corretiva','Vidro quebrado',700.00,8),
('2026-03-18','2026-03-19','Preventiva','Troca de óleo',200.00,9),
('2026-03-19','2026-03-20','Corretiva','Amassado',400.00,10),
('2026-03-20','2026-03-21','Preventiva','Revisão geral',300.00,11),
('2026-03-21','2026-03-22','Preventiva','Check-up',280.00,12);

-- 1 Quais os clientes com status de inadimplência true?
SELECT nome FROM CLIENTE
WHERE status_inadimplencia = true;
-- R: Rodolfo Justos, Camargo Aranha, Fernanda Lima, Lucas Rocha

-- 2 Quantas pessoas pagaram com pix?
SELECT COUNT(*) FROM PAGAMENTO
WHERE forma_pagamento = 'Pix';
-- R: 4

-- 3 Quais multas tem o valor maior que 100 reais?
SELECT descricao, valor_multa FROM MULTA
WHERE valor_multa > 100;
-- R: Atraso na devolução(150), Danos no veículo(200), Arranhão(120), Vidro danificado(300), Amassado leve(180)

-- 4 Quantas manutenções são preventivas?
SELECT COUNT(*) FROM MANUTENCAO
WHERE tipo_manutencao = 'Preventiva';
-- R: 7

-- 5 Quantas manutenções são corretivas?
SELECT COUNT(*) FROM MANUTENCAO
WHERE tipo_manutencao = 'Corretiva';
-- R: 5

-- 6 Quantos seguros são do tipo premium?
SELECT COUNT(*) FROM CONTRATO_LOCACAO
WHERE tipo_seguro = 'Premium';
-- R: 3

-- 7 Quantos seguros são do tipo completo?
SELECT COUNT(*) FROM CONTRATO_LOCACAO
WHERE tipo_seguro = 'Completo';
-- R: 3

-- 8 Quais veículos tem a diária menor que 200?
SELECT V.modelo FROM VEICULO V
JOIN CATEGORIA_VEICULO C ON V.id_categoria = C.id
WHERE C.valor_diaria < 200;
-- R: Ford Ka, Corolla, Civic

-- 9 Quantas reservas estão pendentes?
SELECT COUNT(*) FROM RESERVA
WHERE status_reserva = 'Pendente';
-- R: 3

-- 10 Quais veículos tem o ano igual ou maior que 2020?
SELECT modelo FROM VEICULO
WHERE ano >= 2020;
-- R: Onix, HB20, Compass, Renegade, Strada, Hilux

-- 11 Quantas devoluções não contém nenhum dano identificado?
SELECT COUNT(*) FROM DEVOLUCAO
WHERE danos_identificados = 'Nenhum';
-- R: 6

-- 12 Quantos clientes existem?
SELECT COUNT(*) FROM CLIENTE;
-- R: 10

-- 13 Quantos veículos estão disponíveis?
SELECT COUNT(*) FROM VEICULO
WHERE status_veiculo = 'Disponível';
-- Resp: 12

-- 14 Quantas reservas estão confirmadas?
SELECT COUNT(*) FROM RESERVA
WHERE status_reserva = 'Confirmada';
-- R: 6

-- 15 Quais clientes começam com a letra A?
SELECT nome FROM CLIENTE
WHERE nome LIKE 'A%';
-- R: Ana Clara

-- 16 Qual a média dos pagamentos?
SELECT AVG(valor) FROM PAGAMENTO;
-- R: 1781.49

-- 17 Qual a maior multa registrada?
SELECT MAX(valor_multa) FROM MULTA;
-- R: 300

-- 18 Qual a menor diária de categoria?
SELECT MIN(valor_diaria) FROM CATEGORIA_VEICULO;
-- R: 103.34

-- 19 Quantos contratos estão ativos?
SELECT COUNT(*) FROM CONTRATO_LOCACAO
WHERE status_contrato = 'Ativo';
-- R: 10

-- 20 Quantas devoluções tiveram combustível faltante?
SELECT COUNT(*) FROM DEVOLUCAO
WHERE combustivel_faltante > 0;
-- R: 6