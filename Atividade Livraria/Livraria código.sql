CREATE DATABASE IF NOT EXISTS livraria;
USE livraria;

CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    data_nascimento DATE,
    telefone VARCHAR(15),
    email VARCHAR(100),
    endereco VARCHAR(150),
    cidade VARCHAR(50),
    estado CHAR(2),
    cep CHAR(8)
);

CREATE TABLE Funcionario (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    cargo VARCHAR(50),
    salario DECIMAL(10,2),
    telefone VARCHAR(15),
    email VARCHAR(100),
    data_admissao DATE
);

CREATE TABLE Fornecedor (
    id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    razao_social VARCHAR(100) NOT NULL,
    cnpj CHAR(14) UNIQUE NOT NULL,
    telefone VARCHAR(15),
    email VARCHAR(100),
    endereco VARCHAR(150),
    cidade VARCHAR(50),
    estado CHAR(2)
);

CREATE TABLE Livro (
    id_livro INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    editora VARCHAR(100),
    isbn VARCHAR(20) UNIQUE,
    categoria VARCHAR(50),
    ano_publicacao YEAR,
    preco DECIMAL(10,2),
    estoque INT,
    id_fornecedor INT,
    CONSTRAINT fk_livro_fornecedor
        FOREIGN KEY (id_fornecedor)
        REFERENCES Fornecedor(id_fornecedor)
);

CREATE TABLE Venda (
    id_venda INT AUTO_INCREMENT PRIMARY KEY,
    data_venda DATE NOT NULL,
    valor_total DECIMAL(10,2),
    forma_pagamento VARCHAR(30),
    id_cliente INT,
    id_funcionario INT,
    CONSTRAINT fk_venda_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES Cliente(id_cliente),
    CONSTRAINT fk_venda_funcionario
        FOREIGN KEY (id_funcionario)
        REFERENCES Funcionario(id_funcionario)
);

CREATE TABLE Item_Venda (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    quantidade INT NOT NULL,
    valor_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    id_venda INT NOT NULL,
    id_livro INT NOT NULL,
    CONSTRAINT fk_item_venda
        FOREIGN KEY (id_venda)
        REFERENCES Venda(id_venda),
    CONSTRAINT fk_item_livro
        FOREIGN KEY (id_livro)
        REFERENCES Livro(id_livro)
);

CREATE TABLE Compra (
    id_compra INT AUTO_INCREMENT PRIMARY KEY,
    data_compra DATE NOT NULL,
    valor_total DECIMAL(10,2),
    forma_pagamento VARCHAR(30),
    id_fornecedor INT,
    id_funcionario INT,
    CONSTRAINT fk_compra_fornecedor
        FOREIGN KEY (id_fornecedor)
        REFERENCES Fornecedor(id_fornecedor),
    CONSTRAINT fk_compra_funcionario
        FOREIGN KEY (id_funcionario)
        REFERENCES Funcionario(id_funcionario)
);

CREATE INDEX idx_livro_titulo ON Livro(titulo);
CREATE INDEX idx_cliente_cpf ON Cliente(cpf);

DELIMITER //

CREATE TRIGGER trg_atualiza_estoque_venda
AFTER INSERT ON Item_Venda
FOR EACH ROW
BEGIN
    UPDATE Livro
    SET estoque = estoque - NEW.quantidade
    WHERE id_livro = NEW.id_livro;
END //

CREATE FUNCTION fn_calcula_desconto(valor DECIMAL(10,2), percentual_desconto DECIMAL(5,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE valor_final DECIMAL(10,2);
    SET valor_final = valor - (valor * (percentual_desconto / 100));
    RETURN valor_final;
END //

DELIMITER ;

-- --- CLIENTES ---
INSERT INTO Cliente (nome, cpf, data_nascimento, telefone, email, endereco, cidade, estado, cep) VALUES
('Ana Silva', '10293847561', '1990-05-12', '11987654321', 'ana.silva@email.com', 'Rua das Flores, 12', 'São Paulo', 'SP', '01001000'),
('Bruno Santos', '98765432100', '1985-08-23', '21976543210', 'bruno.santos@email.com', 'Av. Copacabana, 500', 'Rio de Janeiro', 'RJ', '22020001'),
('Carla Oliveira', '54321678909', '1998-11-03', '31965432109', 'carla.oli@email.com', 'Rua Bahia, 88', 'Belo Horizonte', 'MG', '30120010'),
('Diego Ferreira', '32165498742', '2001-01-15', '41954321098', 'diego.f@email.com', 'Rua das Palmeiras, 30', 'Curitiba', 'PR', '80010020'),
('Elena Rostova', '65498732163', '1993-07-29', '51943210987', 'elena.r@email.com', 'Av. Ipiranga, 741', 'Porto Alegre', 'RS', '90010030'),
('Fabio Lima', '11122233344', '1988-02-14', '11911112222', 'fabio.lima@email.com', 'Rua Augusta, 1010', 'São Paulo', 'SP', '01305000'),
('Gisele Bündchen', '22233344455', '1980-07-20', '51922223333', 'gisele.b@email.com', 'Av. Borges de Medeiros, 500', 'Porto Alegre', 'RS', '90020020'),
('Heitor Villa', '33344455566', '1995-12-05', '21933334444', 'heitor.v@email.com', 'Rua das Laranjeiras, 45', 'Rio de Janeiro', 'RJ', '22240000'),
('Isabela Freitas', '44455566677', '1992-04-18', '31944445555', 'isabela.f@email.com', 'Av. Afonso Pena, 1500', 'Belo Horizonte', 'MG', '30130005'),
('João Pedro', '55566677788', '1987-09-30', '41955556666', 'joao.pedro@email.com', 'Rua das Flores, 200', 'Curitiba', 'PR', '80020000'),
('Karina Bacchi', '66677788899', '1991-06-22', '11966667777', 'karina.b@email.com', 'Alameda Santos, 800', 'São Paulo', 'SP', '01419001'),
('Lucas Lucco', '77788899900', '1994-03-10', '62977778888', 'lucas.l@email.com', 'Av. T-63, 120', 'Goiânia', 'GO', '74000000'),
('Mariana Rios', '88899900011', '1989-08-08', '31988889999', 'mariana.r@email.com', 'Rua Sergipe, 400', 'Belo Horizonte', 'MG', '30140000'),
('Nicolas Prattes', '99900011122', '1997-05-04', '21999990000', 'nicolas.p@email.com', 'Av. Atlântica, 1200', 'Rio de Janeiro', 'RJ', '22070000'),
('Olivia Palito', '00011122233', '1996-10-12', '11900001111', 'olivia.p@email.com', 'Rua da Consolação, 500', 'São Paulo', 'SP', '01301000'),
('Paulo Gustavo', '12312312344', '1978-10-30', '21912341234', 'paulo.g@email.com', 'Rua Moreira César, 200', 'Niterói', 'RJ', '24230061'),
('Quenia Abreu', '23423423455', '2000-01-25', '71923452345', 'quenia.a@email.com', 'Av. Oceânica, 300', 'Salvador', 'BA', '40140130'),
('Rodrigo Santoro', '34534534566', '1975-08-22', '21934563456', 'rodrigo.s@email.com', 'Av. Vieira Souto, 100', 'Rio de Janeiro', 'RJ', '22420000'),
('Sabrina Sato', '45645645677', '1981-02-04', '11945674567', 'sabrina.s@email.com', 'Av. Brigadeiro Faria Lima, 2000', 'São Paulo', 'SP', '01451000'),
('Thiago Lacerda', '56756756788', '1978-01-19', '21956785678', 'thiago.l@email.com', 'Rua Visconde de Pirajá, 400', 'Rio de Janeiro', 'RJ', '22410000'),
('Ursula Corbero', '67867867899', '1989-08-11', '11967896789', 'ursula.c@email.com', 'Rua Oscar Freire, 900', 'São Paulo', 'SP', '01426001'),
('Victor Hugo', '78978978900', '1999-03-15', '31978907890', 'victor.h@email.com', 'Av. do Contorno, 5000', 'Belo Horizonte', 'MG', '30110000'),
('Wagner Moura', '89089089011', '1976-06-27', '71989018901', 'wagner.m@email.com', 'Rua Chile, 50', 'Salvador', 'BA', '40020000'),
('Xuxa Meneghel', '90190190122', '1963-03-27', '21990129012', 'xuxa.m@email.com', 'Av. das Américas, 3000', 'Rio de Janeiro', 'RJ', '22640000'),
('Yasser Arafat', '01201201233', '1992-11-11', '41901230123', 'yasser.a@email.com', 'Rua XV de Novembro, 1000', 'Curitiba', 'PR', '80020010'),
('Zico Galo', '11211211244', '1953-03-03', '21911221122', 'zico.g@email.com', 'Rua Eurico Rabelo, 10', 'Rio de Janeiro', 'RJ', '20271150'),
('Aline Barros', '22322322355', '1976-08-19', '21922332233', 'aline.b@email.com', 'Av. Ayrton Senna, 2000', 'Rio de Janeiro', 'RJ', '22775002'),
('Beto Carreiro', '33433433466', '1937-09-09', '47933443344', 'beto.c@email.com', 'Rua Inácio Francisco Mello, 1000', 'Penha', 'SC', '88385000'),
('Camila Pitanga', '44544544577', '1977-06-14', '21944554455', 'camila.p@email.com', 'Rua Jardim Botânico, 600', 'Rio de Janeiro', 'RJ', '22461000'),
('Daniel Boaventura', '55655655688', '1970-05-14', '71955665566', 'daniel.b@email.com', 'Av. Tancredo Neves, 1000', 'Salvador', 'BA', '41820020');

INSERT INTO Funcionario (nome, cpf, cargo, salario, telefone, email, data_admissao) VALUES
('Carlos Souza', '85296374105', 'Gerente', 5500.00, '11912345678', 'carlos.gerente@livraria.com', '2020-01-10'),
('Mariana Lima', '74185296314', 'Vendedora', 2800.00, '11923456789', 'mariana.vendas@livraria.com', '2021-03-15'),
('Roberto Alves', '96385274123', 'Vendedor', 2800.00, '11934567890', 'roberto.vendas@livraria.com', '2022-06-01'),
('Fernanda Costa', '15935728468', 'Caixa', 2400.00, '11945678901', 'fernanda.caixa@livraria.com', '2023-02-20'),
('Lucas Mendes', '35715984297', 'Estoquista', 2200.00, '11956789012', 'lucas.estoque@livraria.com', '2023-08-10'),
('Adriana Esteves', '10101010101', 'Vendedora', 2800.00, '11910101010', 'adriana.vendas@livraria.com', '2021-05-10'),
('Bernardo Silva', '20202020202', 'Vendedor', 2800.00, '11920202020', 'bernardo.vendas@livraria.com', '2021-06-12'),
('Camila Pitanga', '30303030303', 'Caixa', 2400.00, '11930303030', 'camila.caixa@livraria.com', '2022-01-15'),
('Daniel Oliveira', '40404040404', 'Estoquista', 2200.00, '11940404040', 'daniel.estoque@livraria.com', '2022-03-20'),
('Eduardo Gomez', '50505050505', 'Supervisor', 4200.00, '11950505050', 'eduardo.super@livraria.com', '2020-08-01'),
('Fabiana Karla', '60606060606', 'Vendedora', 2800.00, '11960606060', 'fabiana.vendas@livraria.com', '2022-07-11'),
('Gabriel Medina', '70707070707', 'Vendedor', 2800.00, '11970707070', 'gabriel.vendas@livraria.com', '2022-09-01'),
('Helena Ranaldi', '80808080808', 'Caixa', 2400.00, '11980808080', 'helena.caixa@livraria.com', '2023-01-10'),
('Igor Rickli', '90909090909', 'Estoquista', 2200.00, '11990909090', 'igor.estoque@livraria.com', '2023-03-05'),
('Juliana Paes', '11223344556', 'Vendedora', 2800.00, '11911223344', 'juliana.vendas@livraria.com', '2021-11-20'),
('Klebber Toledo', '22334455667', 'Vendedor', 2800.00, '11922334455', 'klebber.vendas@livraria.com', '2022-02-14'),
('Lilia Cabral', '33445566778', 'Subgerente', 4800.00, '11933445566', 'lilia.sub@livraria.com', '2020-03-01'),
('Murilo Benício', '44556677889', 'Vendedor', 2800.00, '11944556677', 'murilo.vendas@livraria.com', '2022-05-18'),
('Nathalia Dill', '55667788990', 'Caixa', 2400.00, '11955667788', 'nathalia.caixa@livraria.com', '2023-04-01'),
('Otavio Muller', '66778899001', 'Estoquista', 2200.00, '11966778899', 'otavio.estoque@livraria.com', '2023-06-15'),
('Patricia Pillar', '77889900112', 'Vendedora', 2800.00, '11977889900', 'patricia.vendas@livraria.com', '2021-08-22'),
('Quentin Tarantino', '88990011223', 'Consultor', 3500.00, '11988990011', 'quentin.consultor@livraria.com', '2021-01-05'),
('Reynaldo Gianecchini', '99001122334', 'Vendedor', 2800.00, '11999001122', 'reynaldo.vendas@livraria.com', '2022-10-10'),
('Sheron Menezzes', '00112233445', 'Vendedora', 2800.00, '11900112233', 'sheron.vendas@livraria.com', '2022-12-01'),
('Tais Araujo', '12121212121', 'Supervisor', 4200.00, '11912121212', 'tais.super@livraria.com', '2020-09-15'),
('Umberto Magnani', '23232323232', 'Vendedor', 2800.00, '11923232323', 'umberto.vendas@livraria.com', '2023-01-20'),
('Vanessa Giácomo', '34343434343', 'Caixa', 2400.00, '11934343434', 'vanessa.caixa@livraria.com', '2023-05-10'),
('Willian Bonner', '45454545454', 'Vendedor', 2800.00, '11945454545', 'willian.vendas@livraria.com', '2022-04-05'),
('Yanna Lavigne', '56565656565', 'Vendedora', 2800.00, '11956565656', 'yanna.vendas@livraria.com', '2022-08-20'),
('Zezé Polessa', '67676767676', 'Estoquista', 2200.00, '11967676767', 'zeze.estoque@livraria.com', '2023-07-01');

INSERT INTO Fornecedor (razao_social, cnpj, telefone, email, endereco, cidade, estado) VALUES
('Distribuidora Companhia das Letras', '12345678000195', '1130000001', 'comercial@companhia.com', 'Rua Bandeira, 100', 'São Paulo', 'SP'),
('Editora Rocco Ltda', '23456789000184', '2130000002', 'vendas@rocco.com', 'Av. Rio Branco, 250', 'Rio de Janeiro', 'RJ'),
('Grupo Editorial Record', '34567890000173', '2130000003', 'contato@record.com', 'Rua Argentina, 171', 'Rio de Janeiro', 'RJ'),
('HarperCollins Brasil', '45678901000162', '1130000004', 'pedidos@harpercollins.com', 'Rua Quintana, 800', 'São Paulo', 'SP'),
('Sextante Distribuidora', '56789012000151', '2130000005', 'atendimento@sextante.com', 'Rua Voluntários, 45', 'Rio de Janeiro', 'RJ'),
('Editora Intínseca', '67890123000140', '2131110001', 'contato@intrinseca.com', 'Av. das Américas, 500', 'Rio de Janeiro', 'RJ'),
('Editora Arqueiro', '78901234000139', '2131110002', 'vendas@arqueiro.com', 'Rua Funchal, 200', 'São Paulo', 'SP'),
('Editora Aleph', '89012345000128', '1131110003', 'atendimento@editoraaleph.com', 'Rua Augusta, 1500', 'São Paulo', 'SP'),
('Editora DarkSide Books', '90123456000117', '2131110004', 'darkside@darkside.com', 'Av. Brasil, 1000', 'Rio de Janeiro', 'RJ'),
('Editora Gutemberg', '01234567000106', '3131110005', 'contato@gutenberg.com', 'Rua Paraíba, 300', 'Belo Horizonte', 'MG'),
('Editora L&PM', '11234567000199', '5132220001', 'vendas@lpm.com', 'Rua do Arquipélago, 15', 'Porto Alegre', 'RS'),
('Editora Martin Claret', '22345678000188', '1132220002', 'atendimento@martinclaret.com', 'Rua Python, 40', 'São Paulo', 'SP'),
('Editora Nova Fronteira', '33456789000177', '2132220003', 'comercial@novafronteira.com', 'Rua Cosme Velho, 103', 'Rio de Janeiro', 'RJ'),
('Editora Panini Brasil', '44567890000166', '1132220004', 'atendimento@panini.com', 'Alameda Caiapós, 425', 'Barueri', 'SP'),
('Editora Planeta do Brasil', '55678901000155', '1132220005', 'vendas@editoraplaneta.com', 'Av. Nove de Julho, 5229', 'São Paulo', 'SP'),
('Editora LePM Pocket', '66789012000144', '5132220006', 'pocket@lpm.com', 'Rua do Arquipélago, 18', 'Porto Alegre', 'RS'),
('Editora Todavia', '77890123000133', '1133330001', 'contato@todavialivros.com', 'Rua Doutor Vilaça, 228', 'São Paulo', 'SP'),
('Editora Zahar', '88901234000122', '2133330002', 'vendas@zahar.com', 'Rua México, 31', 'Rio de Janeiro', 'RJ'),
('Editora Ateliê Editorial', '99012345000111', '1133330003', 'comercial@atelie.com', 'Estrada da Aldeinha, 100', 'Cotia', 'SP'),
('Editora Autêntica', '00123456000100', '3133330004', 'atendimento@autentica.com', 'Rua Aimorés, 981', 'Belo Horizonte', 'MG'),
('Editora Cortez', '12312312000199', '1134440001', 'cortez@cortezeditora.com', 'Rua Bartira, 317', 'São Paulo', 'SP'),
('Editora Suma', '23423423000188', '2134440002', 'contato@editorasuma.com', 'Rua Argentina, 171', 'Rio de Janeiro', 'RJ'),
('Editora Paralela', '34534534000177', '1134440003', 'paralela@companhia.com', 'Rua Bandeira, 105', 'São Paulo', 'SP'),
('Editora Vozes', '45645645000166', '2434440004', 'vendas@vozes.com', 'Rua Frei Luís, 100', 'Petrópolis', 'RJ'),
('Editora Brasiliense', '56756756000155', '1134440005', 'brasiliense@brasiliense.com', 'Rua Airi, 78', 'São Paulo', 'SP'),
('Editora Editora 34', '67867867000144', '1135550001', 'editora34@editora34.com', 'Rua do Timbó, 130', 'São Paulo', 'SP'),
('Editora Hedra', '78978978000133', '1135550002', 'hedra@hedra.com', 'Rua Fradique Coutinho, 1139', 'São Paulo', 'SP'),
('Editora Iluminuras', '89089089000122', '1135550003', 'vendas@iluminuras.com', 'Rua Inácio Pereira da Rocha, 389', 'São Paulo', 'SP'),
('Editora Contexto', '90190190000111', '1135550004', 'contexto@editoracontexto.com', 'Rua Dr. Vila Nova, 268', 'São Paulo', 'SP'),
('Editora Editora Perspectiva', '01201201000100', '1135550005', 'atendimento@editoraperspectiva.com', 'Av. Rebouças, 1905', 'São Paulo', 'SP');

INSERT INTO Livro (titulo, autor, editora, isbn, categoria, ano_publicacao, preco, estoque, id_fornecedor) VALUES
('Dom Casmurro', 'Machado de Assis', 'Companhia das Letras', '9788535900012', 'Literatura', 2019, 39.90, 50, 1),
('1984', 'George Orwell', 'Companhia das Letras', '9788535900029', 'Ficção Científica', 2020, 45.00, 30, 1),
('O Hobbit', 'J.R.R. Tolkien', 'HarperCollins', '9788595080036', 'Fantasia', 2018, 59.90, 40, 4),
('Harry Potter e a Pedra Filosofal', 'J.K. Rowling', 'Rocco', '9788532500043', 'Fantasia', 2017, 49.90, 60, 2),
('A Revolução dos Bichos', 'George Orwell', 'Companhia das Letras', '9788535900050', 'Ficção', 2021, 29.90, 25, 1),
('O Código Da Vinci', 'Dan Brown', 'Sextante', '9788575420067', 'Suspense', 2016, 42.00, 20, 5),
('Sapiens: Uma Breve História da Humanidade', 'Yuval Noah Harari', 'L&PM', '978852540078', 'História', 2015, 69.90, 15, 3),
('O Senhor dos Anéis: A Sociedade do Anel', 'J.R.R. Tolkien', 'HarperCollins', '9788595080081', 'Fantasia', 2019, 79.90, 35, 4),
('O Pequeno Príncipe', 'Antoine de Saint-Exupéry', 'HarperCollins', '9788595080098', 'Infantil', 2022, 24.90, 80, 4),
('Cultura Geral', 'Dietrich Schwanitz', 'Record', '9788501000104', 'Educação', 2014, 89.90, 10, 3),
('A Culpa é das Estrelas', 'John Green', 'Intrínseca', '9788580572261', 'Romance', 2012, 34.90, 45, 6),
('O Iluminado', 'Stephen King', 'Suma', '9788581050393', 'Terror', 2012, 64.90, 25, 22),
('Duna', 'Frank Herbert', 'Aleph', '9788576573135', 'Ficção Científica', 2017, 84.90, 30, 8),
('Orgulho e Preconceito', 'Jane Austen', 'Martin Claret', '9788572322614', 'Romance', 2018, 32.00, 50, 12),
('O Alquimista', 'Paulo Coelho', 'Paralela', '9788584390670', 'Ficção', 2017, 39.90, 65, 23),
('O Sol é para Todos', 'Harper Lee', 'José Olympio', '9788503009492', 'Ficção', 2015, 54.90, 20, 3),
('Cien Años de Soledad', 'Gabriel García Márquez', 'Record', '9788501012039', 'Realismo Mágico', 2010, 62.00, 18, 3),
('Fahrenheit 451', 'Ray Bradbury', 'Globo Livros', '9788525052247', 'Ficção Científica', 2012, 41.90, 40, 1),
('Admirável Mundo Novo', 'Aldous Huxley', 'Globo Livros', '9788525056009', 'Ficção Científica', 2014, 47.90, 35, 1),
('Coraline', 'Neil Gaiman', 'Intrínseca', '9788551006740', 'Fantasia', 2020, 49.90, 50, 6),
('O Nome da Rosa', 'Umberto Eco', 'Record', '9788501018611', 'Mistério', 2019, 69.90, 15, 3),
('A Menina que Roubava Livros', 'Markus Zusak', 'Intrínseca', '9788598078175', 'Drama', 2007, 44.90, 55, 6),
('A Bateria de Sete Minutos', 'Stephen King', 'Suma', '9788581051111', 'Terror', 2015, 59.90, 20, 22),
('Socrates e a Filosofia', 'Platão', 'Edipro', '9788574191000', 'Filosofia', 2010, 29.90, 30, 18),
('O Diário de Anne Frank', 'Anne Frank', 'Record', '9788501044457', 'Biografia', 2015, 39.90, 70, 3),
('Neuromancer', 'William Gibson', 'Aleph', '9788576573005', 'Cyberpunk', 2016, 52.00, 25, 8),
('Ensaio Sobre a Cagueira', 'José Saramago', 'Companhia das Letras', '9788535900111', 'Ficção', 1995, 56.90, 22, 1),
('As Crônicas de Nárnia', 'C.S. Lewis', 'HarperCollins', '9788595080012', 'Fantasia', 2017, 99.90, 40, 4),
('Os Miseráveis', 'Victor Hugo', 'Martin Claret', '9788572322000', 'Clássico', 2014, 89.90, 12, 12),
('O Caçador de Pipas', 'Khaled Hosseini', 'Globo Livros', '9788525040001', 'Drama', 2005, 42.90, 48, 6);

INSERT INTO Compra (data_compra, valor_total, forma_pagamento, id_fornecedor, id_funcionario) VALUES
('2024-01-10', 1500.00, 'Boleto', 1, 5),
('2024-01-15', 2300.50, 'PIX', 2, 5),
('2024-02-01', 1200.00, 'Transferência', 3, 1),
('2024-02-20', 3400.00, 'Boleto', 4, 5),
('2024-03-05', 800.00, 'PIX', 5, 1),
('2024-03-10', 4500.00, 'Boleto', 6, 9),
('2024-03-12', 3100.00, 'Transferência', 7, 9),
('2024-03-15', 2800.00, 'PIX', 8, 4),
('2024-03-18', 1900.00, 'Boleto', 9, 9),
('2024-03-20', 2200.00, 'Cartão de Crédito', 10, 14),
('2024-03-22', 1700.00, 'PIX', 11, 14),
('2024-03-25', 3900.00, 'Boleto', 12, 14),
('2024-03-28', 5100.00, 'Transferência', 13, 20),
('2024-04-01', 6200.00, 'Boleto', 14, 20),
('2024-04-03', 1400.00, 'PIX', 15, 20),
('2024-04-05', 2900.00, 'PIX', 16, 30),
('2024-04-08', 3300.00, 'Boleto', 17, 30),
('2024-04-10', 4100.00, 'Transferência', 18, 30),
('2024-04-12', 1500.00, 'Boleto', 19, 5),
('2024-04-15', 2700.00, 'PIX', 20, 5),
('2024-04-18', 3800.00, 'Boleto', 21, 9),
('2024-04-20', 4900.00, 'Transferência', 22, 9),
('2024-04-22', 2100.00, 'PIX', 23, 14),
('2024-04-25', 1800.00, 'Boleto', 24, 14),
('2024-04-28', 3500.00, 'PIX', 25, 20),
('2024-05-01', 4200.00, 'Boleto', 26, 20),
('2024-05-03', 2600.00, 'Transferência', 27, 30),
('2024-05-05', 1300.00, 'PIX', 28, 30),
('2024-05-08', 5500.00, 'Boleto', 29, 5),
('2024-05-10', 3700.00, 'PIX', 30, 9);

INSERT INTO Venda (data_venda, valor_total, forma_pagamento, id_cliente, id_funcionario) VALUES
('2024-03-10', 84.90, 'Cartão de Crédito', 1, 2),
('2024-03-11', 59.90, 'PIX', 2, 3),
('2024-03-12', 139.80, 'Cartão de Débito', 3, 2),
('2024-03-13', 24.90, 'Dinheiro', 4, 4),
('2024-03-14', 24.90, 'Cartão de Crédito', 5, 3),
('2024-03-15', 34.90, 'PIX', 6, 6),
('2024-03-16', 64.90, 'Cartão de Crédito', 7, 7),
('2024-03-17', 84.90, 'Cartão de Débito', 8, 11),
('2024-03-18', 32.00, 'Dinheiro', 9, 12),
('2024-03-19', 39.90, 'PIX', 10, 15),
('2024-03-20', 54.90, 'Cartão de Crédito', 11, 16),
('2024-03-21', 62.00, 'Cartão de Débito', 12, 18),
('2024-03-22', 41.90, 'PIX', 13, 21),
('2024-03-23', 47.90, 'Dinheiro', 14, 23),
('2024-03-24', 49.90, 'Cartão de Crédito', 15, 24),
('2024-03-25', 69.90, 'PIX', 16, 26),
('2024-03-26', 44.90, 'Cartão de Débito', 17, 28),
('2024-03-27', 59.90, 'Cartão de Crédito', 18, 29),
('2024-03-28', 29.90, 'Dinheiro', 19, 2),
('2024-03-29', 39.90, 'PIX', 20, 3),
('2024-03-30', 52.00, 'Cartão de Crédito', 21, 6),
('2024-03-31', 56.90, 'Cartão de Débito', 22, 7),
('2024-04-01', 99.90, 'PIX', 23, 11),
('2024-04-02', 89.90, 'Cartão de Crédito', 24, 12),
('2024-04-03', 42.90, 'Dinheiro', 25, 15),
('2024-04-04', 39.90, 'PIX', 26, 16),
('2024-04-05', 45.00, 'Cartão de Crédito', 27, 18),
('2024-04-06', 59.90, 'Cartão de Débito', 28, 21),
('2024-04-07', 49.90, 'PIX', 29, 23),
('2024-04-08', 29.90, 'Dinheiro', 30, 24);

INSERT INTO Item_Venda (quantidade, valor_unitario, subtotal, id_venda, id_livro) VALUES
(1, 39.90, 39.90, 1, 1),
(1, 45.00, 45.00, 1, 2),
(1, 59.90, 59.90, 2, 3),
(2, 69.90, 139.80, 3, 7),
(1, 24.90, 24.90, 4, 9),
(1, 24.90, 24.90, 5, 9),
(1, 34.90, 34.90, 6, 11),
(1, 64.90, 64.90, 7, 12),
(1, 84.90, 84.90, 8, 13),
(1, 32.00, 32.00, 9, 14),
(1, 39.90, 39.90, 10, 15),
(1, 54.90, 54.90, 11, 16),
(1, 62.00, 62.00, 12, 17),
(1, 41.90, 41.90, 13, 18),
(1, 47.90, 47.90, 14, 19),
(1, 49.90, 49.90, 15, 20),
(1, 69.90, 69.90, 16, 21),
(1, 44.90, 44.90, 17, 22),
(1, 59.90, 59.90, 18, 23),
(1, 29.90, 29.90, 19, 24),
(1, 39.90, 39.90, 20, 25),
(1, 52.00, 52.00, 21, 26),
(1, 56.90, 56.90, 22, 27),
(1, 99.90, 99.90, 23, 28),
(1, 89.90, 89.90, 24, 29),
(1, 42.90, 42.90, 25, 30),
(1, 39.90, 39.90, 26, 1),
(1, 45.00, 45.00, 27, 2),
(1, 59.90, 59.90, 28, 3),
(1, 49.90, 49.90, 29, 4),
(1, 29.90, 29.90, 30, 5);

SELECT 
    V.id_venda, 
    V.data_venda, 
    C.nome AS cliente, 
    F.nome AS funcionario, 
    V.valor_total
FROM Venda V
INNER JOIN Cliente C ON V.id_cliente = C.id_cliente
INNER JOIN Funcionario F ON V.id_funcionario = F.id_funcionario;

SELECT 
    L.titulo, 
    L.autor, 
    L.preco, 
    F.razao_social AS fornecedor
FROM Livro L
INNER JOIN Fornecedor F ON L.id_fornecedor = F.id_fornecedor;

SELECT 
    IV.id_venda, 
    L.titulo AS livro, 
    IV.quantidade, 
    IV.valor_unitario, 
    IV.subtotal
FROM Item_Venda IV
INNER JOIN Livro L ON IV.id_livro = L.id_livro;

SELECT 
    Co.id_compra, 
    Co.data_compra, 
    Forn.razao_social AS fornecedor, 
    Func.nome AS funcionario_comprador, 
    Co.valor_total
FROM Compra Co
INNER JOIN Fornecedor Forn ON Co.id_fornecedor = Forn.id_fornecedor
INNER JOIN Funcionario Func ON Co.id_funcionario = Func.id_funcionario;

SELECT 
    V.id_venda, 
    C.nome AS cliente, 
    Func.nome AS vendedor, 
    L.titulo AS livro, 
    IV.quantidade, 
    IV.subtotal
FROM Venda V
INNER JOIN Cliente C ON V.id_cliente = C.id_cliente
INNER JOIN Funcionario Func ON V.id_funcionario = Func.id_funcionario
INNER JOIN Item_Venda IV ON V.id_venda = IV.id_venda
INNER JOIN Livro L ON IV.id_livro = L.id_livro;

SELECT 
    C.nome, 
    COUNT(V.id_venda) AS total_compras, 
    COALESCE(SUM(V.valor_total), 0) AS total_gasto
FROM Cliente C
LEFT JOIN Venda V ON C.id_cliente = V.id_cliente
GROUP BY C.id_cliente, C.nome;

SELECT 
    F.nome AS funcionario, 
    COUNT(V.id_venda) AS quantidade_vendas, 
    COALESCE(SUM(V.valor_total), 0) AS valor_total_vendido
FROM Funcionario F
LEFT JOIN Venda V ON F.id_funcionario = V.id_funcionario
GROUP BY F.id_funcionario, F.nome;

SELECT 
    Forn.razao_social AS fornecedor, 
    L.titulo AS livro, 
    SUM(IV.quantidade) AS total_unidades_vendidas
FROM Fornecedor Forn
INNER JOIN Livro L ON Forn.id_fornecedor = L.id_fornecedor
INNER JOIN Item_Venda IV ON L.id_livro = IV.id_livro
GROUP BY Forn.id_fornecedor, L.id_livro;