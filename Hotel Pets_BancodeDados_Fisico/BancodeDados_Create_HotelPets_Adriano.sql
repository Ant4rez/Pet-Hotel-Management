create database Hotel_Pets;

-- drop database hotel_pets;

use Hotel_Pets;

-- SQL Script para o Banco de Dados Pet Shop

-- 1. Criação das Tabelas Base (sem FKs que dependam de outras tabelas)

CREATE TABLE Cargo (
    ID_CARGO INT PRIMARY KEY AUTO_INCREMENT,
    Nome_Cargo VARCHAR(100) NOT NULL,
    Descricao_Cargo VARCHAR(100) NOT NULL,
    Turno_Cargo VARCHAR(100) NOT NULL
);

CREATE TABLE Tipo_de_Pagamentos (
    ID_PAGAMENTOS INT PRIMARY KEY AUTO_INCREMENT,
    Tipo_Pagamentos VARCHAR(50) NOT NULL,
    Modalidade_Pagamento VARCHAR(50) NOT NULL,
    Descricao_Pagamentos VARCHAR(50) NOT NULL
);

CREATE TABLE Vacinas_Pet (
    ID_VACINAS INT PRIMARY KEY AUTO_INCREMENT,
    Nome_Vacina VARCHAR(100) NOT NULL,
    Tipo_Vacina VARCHAR(100),
    Validade_Vacina DATE -- Alterado de VARCHAR(50) para DATE
);

CREATE TABLE Estoque_Produtos_Gerais (
    ID_ESTOQUE_PRODUTOS_GERAIS INT PRIMARY KEY AUTO_INCREMENT,
    Tipo_ProdutosGerais VARCHAR(50) NOT NULL,
    Nome_ProdutoGerais VARCHAR(100) NOT NULL,
    Descricao_ProdutosGerais VARCHAR(100) NOT NULL,
    Quantidade_ProdutosGerais INT NOT NULL,
    ValorUnitario_ProdutosGerais DECIMAL(10,2) NOT NULL, -- Alterado de INT para DECIMAL(10,2)
    ValorTotal_ProdutosGerais DECIMAL(10,2) NOT NULL -- Alterado de INT para DECIMAL(10,2)
);

CREATE TABLE Estoque_Produtos_Pets (
    ID_PRODUTOS_PETS INT PRIMARY KEY AUTO_INCREMENT,
    Tipo_ProdutosPets VARCHAR(50) NOT NULL,
    Nome_ProdutosPets VARCHAR(100) NOT NULL,
    Descricao_ProdutosPets VARCHAR(100) NOT NULL,
    Quantidade_ProdutosPets INT NOT NULL,
    ValorUnitario_ProdutosPets DECIMAL(10,2) NOT NULL, -- Alterado de INT para DECIMAL(10,2)
    ValorTotal_ProdutosPets DECIMAL(10,2) NOT NULL -- Alterado de INT para DECIMAL(10,2)
);

CREATE TABLE Acomodacoes_Hotel_Pet (
    ID_ACOMODACOES_HOTEL_PET INT PRIMARY KEY AUTO_INCREMENT,
    Tipo_Acomodacoes VARCHAR(50) NOT NULL,
    Nome_Acomodacoes VARCHAR(100) NOT NULL,
    Tamanho_Acomodacoes VARCHAR(100) NOT NULL,
    ValorDiaria_Acomodacoes DECIMAL(10,2) NOT NULL -- Alterado de VARCHAR(100) para DECIMAL(10,2)
);

-- 2. Criação das Tabelas com FKs que dependem das tabelas criadas acima ou umas das outras

CREATE TABLE Funcionarios (
    ID_FUNCIONARIO INT PRIMARY KEY AUTO_INCREMENT,
    Nome_Funcionario VARCHAR(100) NOT NULL,
    Escolaridade_Funcionario VARCHAR(100) NOT NULL,
    Telephone_Funcionario VARCHAR(100) NOT NULL,
    Cargo_ID INT, -- Alterado de VARCHAR(100) para INT
    Endereco_ID INT -- Alterado de VARCHAR(100) para INT (FK para Endereco_Funcionarios, será adicionada depois)
);

CREATE TABLE Endereco_Funcionarios (
    ID_ENDERECO INT PRIMARY KEY AUTO_INCREMENT,
    Logradouro_Endereco VARCHAR(100) NOT NULL,
    Numero_Endereco VARCHAR(20) NOT NULL,
    Bairro_Endereco VARCHAR(100) NOT NULL,
    Cidade_Endereco VARCHAR(100) NOT NULL,
    Estado_Endereco VARCHAR(2) NOT NULL,
    CEP_Endereco VARCHAR(9) NOT NULL, -- Alterado de VARCHAR(100) para VARCHAR(9)
    Complemento_Endereco VARCHAR(100) NOT NULL,
    Funcionarios_ID INT -- Alterado de VARCHAR(100) para INT (FK para Funcionarios, será adicionada depois)
);

CREATE TABLE Dono_do_Pet (
    ID_DONO_PET INT PRIMARY KEY AUTO_INCREMENT,
    Nome_DonoPet VARCHAR(50) NOT NULL,
    Telefone_DonoPet VARCHAR(50) NOT NULL
    -- REMOVIDO: Pets_ID e Endereco_Dono_Pet_ID (FKs movidas para as tabelas Pets e Endereco_Dono_do_Pet)
);

CREATE TABLE Endereco_Dono_do_Pet (
    ID_ENDERECO_DONO_PET INT PRIMARY KEY AUTO_INCREMENT,
    Logradouro_Endereco VARCHAR(100) NOT NULL,
    Numero_Endereco VARCHAR(100) NOT NULL,
    Bairro_Endereco VARCHAR(100) NOT NULL,
    Cidade_Endereco VARCHAR(100) NOT NULL,
    Estado_Endereco VARCHAR(100) NOT NULL,
    Complemento_Endereco VARCHAR(100) NOT NULL,
    DonoPet_ID INT NOT NULL -- Adicionado FK para Dono_do_Pet
);

CREATE TABLE Pets (
    ID_PETS INT PRIMARY KEY AUTO_INCREMENT,
    Nome_Pets VARCHAR(50) NOT NULL,
    Raca_Pets VARCHAR(50) NOT NULL,
    Anotacoes_Pets VARCHAR(50) NOT NULL,
    Vacinas_ID INT, -- Alterado de VARCHAR(50) para INT
    DonoPet_ID INT NOT NULL -- Adicionado FK para Dono_do_Pet
);

CREATE TABLE Servicos_Gerais_Pet (
    ID_SERVICOS_GERAIS_PET INT PRIMARY KEY AUTO_INCREMENT,
    Modalidade_ServicoGeraisPet VARCHAR(50) NOT NULL,
    Nome_ServicoGeraisPet VARCHAR(50) NOT NULL,
    Descricao_ServicoGeraisPet VARCHAR(100) NOT NULL,
    EstoqueProdutosGerais_ID INT -- OK: Consistente com Estoque_Produtos_Gerais.ID_ESTOQUE_PRODUTOS_GERAIS
);

CREATE TABLE Servico_Hotelaria_Pet (
    ID_SERVICO_HOTELARIA INT PRIMARY KEY AUTO_INCREMENT,
    Modalidade_ServicoHotelaria VARCHAR(50) NOT NULL,
    Nome_ServicoHotelaria VARCHAR(100) NOT NULL,
    Descricao_ServicoHotelaria VARCHAR(100) NOT NULL,
    ProdutosPets_ID INT, -- Alterado de VARCHAR(100) para INT (FK para Estoque_Produtos_Pets)
    Acomodacoes_Hotel_Pet_ID INT -- Alterado de VARCHAR(100) para INT (FK para Acomodacoes_Hotel_Pet)
);


CREATE TABLE Faturamento (
    ID_FATURAMENTO INT PRIMARY KEY AUTO_INCREMENT,
    DataEntrada_Faturamento DATE NOT NULL,
    DataSaida_Faturamento DATE NOT NULL,
    ValorTotalFaturamento_Faturamento DECIMAL(10,2) NOT NULL, -- Alterado de INT para DECIMAL(10,2)
    Anotacoesgerais_Faturamento VARCHAR(100) NOT NULL,
    Pets_ID INT, -- Adicionado para eliminar a inconsistência.
    DonoPet_ID INT, -- Alterado de VARCHAR(100) para INT
    Pagamentos_ID INT, -- OK: Consistente com Tipo_de_Pagamentos.ID_PAGAMENTOS
    ServicosGeraisPet_ID INT, -- Alterado de VARCHAR(100) para INT
    AcomodacoesHotelPet_ID INT, -- Alterado de VARCHAR(100) para INT
    ServicoHotelariaPet_ID INT, -- Alterado de VARCHAR(100) para INT
    Funcionarios_ID INT -- Alterado de VARCHAR(100) para INT
    );


-- 3. Adição das Chaves Estrangeiras (FOREIGN KEYs) com ALTER TABLE

-- FKs para Funcionarios
ALTER TABLE Funcionarios
ADD CONSTRAINT FK_Funcionarios_Cargo
FOREIGN KEY (Cargo_ID) REFERENCES Cargo(ID_CARGO);

-- FKs para Endereco_Funcionarios
ALTER TABLE Endereco_Funcionarios
ADD CONSTRAINT FK_Endereco_Funcionarios_Funcionarios
FOREIGN KEY (Funcionarios_ID) REFERENCES Funcionarios(ID_FUNCIONARIO);

-- FKs para Dono_do_Pet (no Endereco_Dono_do_Pet e Pets)
ALTER TABLE Endereco_Dono_do_Pet
ADD CONSTRAINT FK_EnderecoDonoPet_DonoPet
FOREIGN KEY (DonoPet_ID) REFERENCES Dono_do_Pet(ID_DONO_PET);

ALTER TABLE Pets
ADD CONSTRAINT FK_Pets_DonoPet
FOREIGN KEY (DonoPet_ID) REFERENCES Dono_do_Pet(ID_DONO_PET);

-- FKs para Pets (no Vacinas_Pet)
ALTER TABLE Pets
ADD CONSTRAINT FK_Pets_Vacinas
FOREIGN KEY (Vacinas_ID) REFERENCES Vacinas_Pet(ID_VACINAS);

-- FKs para Servicos_Gerais_Pet (no Estoque_Produtos_Gerais)
ALTER TABLE Servicos_Gerais_Pet
ADD CONSTRAINT FK_ServicosGeraisPet_EstoqueProdutosGerais
FOREIGN KEY (EstoqueProdutosGerais_ID) REFERENCES Estoque_Produtos_Gerais(ID_ESTOQUE_PRODUTOS_GERAIS);

-- FKs para Servico_Hotelaria_Pet (no Estoque_Produtos_Pets e Acomodacoes_Hotel_Pet)
ALTER TABLE Servico_Hotelaria_Pet
ADD CONSTRAINT FK_ServicoHotelariaPet_EstoqueProdutosPets
FOREIGN KEY (ProdutosPets_ID) REFERENCES Estoque_Produtos_Pets(ID_PRODUTOS_PETS);

ALTER TABLE Servico_Hotelaria_Pet
ADD CONSTRAINT FK_ServicoHotelariaPet_AcomodacoesHotelPet
FOREIGN KEY (Acomodacoes_Hotel_Pet_ID) REFERENCES Acomodacoes_Hotel_Pet(ID_ACOMODACOES_HOTEL_PET);

-- FKs para Faturamento
ALTER TABLE Faturamento
ADD CONSTRAINT FK_Faturamento_DonoPet
FOREIGN KEY (DonoPet_ID) REFERENCES Dono_do_Pet(ID_DONO_PET);

ALTER TABLE Faturamento
ADD CONSTRAINT FK_Faturamento_Pagamentos
FOREIGN KEY (Pagamentos_ID) REFERENCES Tipo_de_Pagamentos(ID_PAGAMENTOS);

ALTER TABLE Faturamento
ADD CONSTRAINT FK_Faturamento_ServicosGeraisPet
FOREIGN KEY (ServicosGeraisPet_ID) REFERENCES Servicos_Gerais_Pet(ID_SERVICOS_GERAIS_PET);

ALTER TABLE Faturamento
ADD CONSTRAINT FK_Faturamento_AcomodacoesHotelPet
FOREIGN KEY (AcomodacoesHotelPet_ID) REFERENCES Acomodacoes_Hotel_Pet(ID_ACOMODACOES_HOTEL_PET);

ALTER TABLE Faturamento
ADD CONSTRAINT FK_Faturamento_ServicoHotelariaPet
FOREIGN KEY (ServicoHotelariaPet_ID) REFERENCES Servico_Hotelaria_Pet(ID_SERVICO_HOTELARIA);

ALTER TABLE Faturamento
ADD CONSTRAINT FK_Faturamento_Funcionarios
FOREIGN KEY (Funcionarios_ID) REFERENCES Funcionarios(ID_FUNCIONARIO);

-- DADOS INICIAIS PARA AS TABELAS

-- ORDEM DE INSERÇÃO: Tabelas sem dependências primeiro

-- 1. TABELA: Cargo
INSERT INTO Cargo (Nome_Cargo, Descricao_Cargo, Turno_Cargo) VALUES
('Veterinário(a)', 'Responsável pelo diagnóstico e tratamento de doenças em animais', 'Diurno'),
('Tosador(a)', 'Realiza banho, tosa e higienização dos pets', 'Diurno'),
('Recepcionista', 'Atendimento ao cliente, agendamentos e suporte administrativo', 'Diurno'),
('Gerente', 'Supervisão geral das operações da loja e da equipe', 'Integral');

-- 2. TABELA: Tipo_de_Pagamentos
INSERT INTO Tipo_de_Pagamentos (Tipo_Pagamentos, Modalidade_Pagamento, Descricao_Pagamentos) VALUES
('Cartão', 'Crédito', 'Pagamento com cartão de crédito'),
('Cartão', 'Débito', 'Pagamento com cartão de débito'),
('Digital', 'Pix', 'Pagamento via Pix'),
('Físico', 'Dinheiro', 'Pagamento em espécie');

-- 3. TABELA: Vacinas_Pet
INSERT INTO Vacinas_Pet (Nome_Vacina, Tipo_Vacina, Validade_Vacina) VALUES
('V10', 'Viral', '2025-07-01'),
('Raiva', 'Viral', '2026-07-01'),
('V4', 'Viral', '2025-08-15'),
('Giárdia', 'Bacteriana', '2025-09-20');

-- 4. TABELA: Estoque_Produtos_Gerais
INSERT INTO Estoque_Produtos_Gerais (Tipo_ProdutosGerais, Nome_ProdutoGerais, Descricao_ProdutosGerais, Quantidade_ProdutosGerais, ValorUnitario_ProdutosGerais, ValorTotal_ProdutosGerais) VALUES
('Alimentação', 'Ração Premium para Cães', 'Saco de 15kg', 50, 150.00, 7500.00),
('Higiene', 'Shampoo Hipoalergênico', 'Para pets com pele sensível', 60, 60.00, 3600.00),
('Acessório', 'Coleira Peitoral Grande', 'Coleira para cães de grande porte', 75, 45.00, 3375.00);

-- 5. TABELA: Estoque_Produtos_Pets
INSERT INTO Estoque_Produtos_Pets (Tipo_ProdutosPets, Nome_ProdutosPets, Descricao_ProdutosPets, Quantidade_ProdutosPets, ValorUnitario_ProdutosPets, ValorTotal_ProdutosPets) VALUES
('Brinquedo', 'Bolinha de Borracha', 'Brinquedo resistente para cães', 40, 30.00, 1200.00),
('Cama', 'Cama de Gato de Pelúcia', 'Cama macia e confortável para gatos', 20, 55.00, 1100.00);

-- 6. TABELA: Acomodacoes_Hotel_Pet
INSERT INTO Acomodacoes_Hotel_Pet (Tipo_Acomodacoes, Nome_Acomodacoes, Tamanho_Acomodacoes, ValorDiaria_Acomodacoes) VALUES
('Individual', 'Quarto Canino 1', 'Pequeno', 80.00),
('Individual', 'Suíte Felina 2', 'Médio', 120.00),
('Familiar', 'Chalé Familiar 3', 'Grande', 180.00);

-- 7. TABELA: Dono_do_Pet
INSERT INTO Dono_do_Pet (Nome_DonoPet, Telefone_DonoPet) VALUES
('João Silva', '(11) 91234-5678'),
('Maria Souza', '(11) 92345-6789'),
('Pedro Almeida', '(11) 93456-7890');


-- ORDEM DE INSERÇÃO: Tabelas com dependências secundárias

-- 8. TABELA: Endereco_Dono_do_Pet (depende de Dono_do_Pet)
INSERT INTO Endereco_Dono_do_Pet (Logradouro_Endereco, Numero_Endereco, Bairro_Endereco, Cidade_Endereco, Estado_Endereco, Complemento_Endereco, DonoPet_ID) VALUES
('Rua A', '123', 'Centro', 'São Paulo', 'SP', 'Casa 1', (SELECT ID_DONO_PET FROM Dono_do_Pet WHERE Nome_DonoPet = 'João Silva')),
('Rua B', '456', 'Jardins', 'São Paulo', 'SP', 'Apto 101', (SELECT ID_DONO_PET FROM Dono_do_Pet WHERE Nome_DonoPet = 'Maria Souza')),
('Rua C', '789', 'Vila Nova', 'Rio de Janeiro', 'RJ', 'Bloco B', (SELECT ID_DONO_PET FROM Dono_do_Pet WHERE Nome_DonoPet = 'Pedro Almeida'));

-- 9. TABELA: Endereco_Funcionarios (depende de Funcionarios, que ainda não foi inserido.
--    Inserimos primeiro o endereço e atualizaremos a FK depois)
INSERT INTO Endereco_Funcionarios (Logradouro_Endereco, Numero_Endereco, Bairro_Endereco, Cidade_Endereco, Estado_Endereco, CEP_Endereco, Complemento_Endereco) VALUES
('Rua das Flores', '101', 'Bela Vista', 'São Paulo', 'SP', '01311-000', 'Ap. 202'),
('Avenida Principal', '202', 'Centro', 'São Paulo', 'SP', '01001-000', 'Sala 5'),
('Rua dos Pinheiros', '303', 'Pinheiros', 'São Paulo', 'SP', '05407-000', 'Conjunto 10');

-- 10. TABELA: Funcionarios (depende de Cargo e Endereco_Funcionarios)
INSERT INTO Funcionarios (Nome_Funcionario, Escolaridade_Funcionario, Telephone_Funcionario, Cargo_ID, Endereco_ID) VALUES
('Ana Paula Santos', 'Superior Completo', '(11) 98765-4321', (SELECT ID_CARGO FROM Cargo WHERE Nome_Cargo = 'Veterinário(a)'), (SELECT ID_ENDERECO FROM Endereco_Funcionarios WHERE Logradouro_Endereco = 'Rua das Flores')),
('Bruno Costa', 'Ensino Médio', '(11) 99876-5432', (SELECT ID_CARGO FROM Cargo WHERE Nome_Cargo = 'Tosador(a)'), (SELECT ID_ENDERECO FROM Endereco_Funcionarios WHERE Logradouro_Endereco = 'Avenida Principal')),
('Carla Oliveira', 'Superior Incompleto', '(11) 97654-3210', (SELECT ID_CARGO FROM Cargo WHERE Nome_Cargo = 'Recepcionista'), (SELECT ID_ENDERECO FROM Endereco_Funcionarios WHERE Logradouro_Endereco = 'Rua dos Pinheiros'));

-- 11. TABELA: Servicos_Gerais_Pet (depende de Estoque_Produtos_Gerais)
INSERT INTO Servicos_Gerais_Pet (Modalidade_ServicoGeraisPet, Nome_ServicoGeraisPet, Descricao_ServicoGeraisPet, EstoqueProdutosGerais_ID) VALUES
('Serviço', 'Banho Completo P', 'Banho, secagem e escovação de pelos', NULL),
('Serviço', 'Tosa Higiênica', 'Tosa de patas, barriga e rosto', NULL),
('Serviço', 'Consulta Rotina', 'Avaliação geral da saúde do pet', NULL),
('Venda', 'Venda Ração', 'Venda de rações do estoque', (SELECT ID_ESTOQUE_PRODUTOS_GERAIS FROM Estoque_Produtos_Gerais WHERE Nome_ProdutoGerais = 'Ração Premium para Cães')),
('Venda', 'Venda Shampoo', 'Venda de produtos de higiene', (SELECT ID_ESTOQUE_PRODUTOS_GERAIS FROM Estoque_Produtos_Gerais WHERE Nome_ProdutoGerais = 'Shampoo Hipoalergênico'));

-- 12. TABELA: Servico_Hotelaria_Pet (depende de Estoque_Produtos_Pets e Acomodacoes_Hotel_Pet)
INSERT INTO Servico_Hotelaria_Pet (Modalidade_ServicoHotelaria, Nome_ServicoHotelaria, Descricao_ServicoHotelaria, ProdutosPets_ID, Acomodacoes_Hotel_Pet_ID) VALUES
('Hospedagem', 'Hospedagem Noturna', 'Estadia de 1 noite com refeições inclusas', (SELECT ID_PRODUTOS_PETS FROM Estoque_Produtos_Pets WHERE Nome_ProdutosPets = 'Cama de Gato de Pelúcia'), (SELECT ID_ACOMODACOES_HOTEL_PET FROM Acomodacoes_Hotel_Pet WHERE Nome_Acomodacoes = 'Suíte Felina 2')),
('Hospedagem', 'Hospedagem Completa', 'Estadia com serviços de banho, passeio e brinquedo', (SELECT ID_PRODUTOS_PETS FROM Estoque_Produtos_Pets WHERE Nome_ProdutosPets = 'Bolinha de Borracha'), (SELECT ID_ACOMODACOES_HOTEL_PET FROM Acomodacoes_Hotel_Pet WHERE Nome_Acomodacoes = 'Chalé Familiar 3'));

-- 13. TABELA: Pets (depende de Dono_do_Pet e Vacinas_Pet)
INSERT INTO Pets (Nome_Pets, Raca_Pets, Anotacoes_Pets, Vacinas_ID, DonoPet_ID) VALUES
('Rex', 'Golden Retriever', 'Porte grande, dócil', (SELECT ID_VACINAS FROM Vacinas_Pet WHERE Nome_Vacina = 'V10'), (SELECT ID_DONO_PET FROM Dono_do_Pet WHERE Nome_DonoPet = 'João Silva')),
('Bob', 'Poodle', 'Não solta pelos', (SELECT ID_VACINAS FROM Vacinas_Pet WHERE Nome_Vacina = 'Raiva'), (SELECT ID_DONO_PET FROM Dono_do_Pet WHERE Nome_DonoPet = 'João Silva')),
('Mia', 'Siamês', 'Gato, porte pequeno', (SELECT ID_VACINAS FROM Vacinas_Pet WHERE Nome_Vacina = 'V4'), (SELECT ID_DONO_PET FROM Dono_do_Pet WHERE Nome_DonoPet = 'Maria Souza')),
('Luna', 'Maine Coon', 'Gato, porte grande', (SELECT ID_VACINAS FROM Vacinas_Pet WHERE Nome_Vacina = 'Raiva'), (SELECT ID_DONO_PET FROM Dono_do_Pet WHERE Nome_DonoPet = 'Maria Souza'));

-- ORDEM DE INSERÇÃO: Tabela final (depende de quase tudo)

-- TABELA: Faturamento
-- Este script assume que as outras tabelas (Dono_do_Pet, Pets, Funcionarios, etc.)
-- já estão preenchidas com os dados gerados anteriormente.

INSERT INTO Faturamento (DataEntrada_Faturamento, DataSaida_Faturamento, ValorTotalFaturamento_Faturamento, Anotacoesgerais_Faturamento, Pets_ID, DonoPet_ID, Pagamentos_ID, ServicosGeraisPet_ID, AcomodacoesHotelPet_ID, ServicoHotelariaPet_ID, Funcionarios_ID) VALUES
-- Faturamento 1: Serviço de Banho para o Rex (João Silva)
('2024-07-25', '2024-07-25', 100.00, 'Banho Completo para Rex',
    (SELECT ID_PETS FROM Pets WHERE Nome_Pets = 'Rex'),
    (SELECT DonoPet_ID FROM Pets WHERE Nome_Pets = 'Rex'),
    (SELECT ID_PAGAMENTOS FROM Tipo_de_Pagamentos WHERE Modalidade_Pagamento = 'Débito'),
    (SELECT ID_SERVICOS_GERAIS_PET FROM Servicos_Gerais_Pet WHERE Nome_ServicoGeraisPet = 'Banho Completo P'),
    NULL, NULL,
    (SELECT ID_FUNCIONARIO FROM Funcionarios WHERE Nome_Funcionario = 'Bruno Costa')),

-- Faturamento 2: Serviço de Banho para o Bob (João Silva)
('2024-07-26', '2024-07-26', 100.00, 'Banho Completo para Bob',
    (SELECT ID_PETS FROM Pets WHERE Nome_Pets = 'Bob'),
    (SELECT DonoPet_ID FROM Pets WHERE Nome_Pets = 'Bob'),
    (SELECT ID_PAGAMENTOS FROM Tipo_de_Pagamentos WHERE Modalidade_Pagamento = 'Pix'),
    (SELECT ID_SERVICOS_GERAIS_PET FROM Servicos_Gerais_Pet WHERE Nome_ServicoGeraisPet = 'Banho Completo P'),
    NULL, NULL,
    (SELECT ID_FUNCIONARIO FROM Funcionarios WHERE Nome_Funcionario = 'Bruno Costa')),

-- Faturamento 3: Venda de Produto para o Rex (João Silva)
('2024-07-28', '2024-07-28', 150.00, 'Venda de Ração para o Rex',
    (SELECT ID_PETS FROM Pets WHERE Nome_Pets = 'Rex'),
    (SELECT DonoPet_ID FROM Pets WHERE Nome_Pets = 'Rex'),
    (SELECT ID_PAGAMENTOS FROM Tipo_de_Pagamentos WHERE Modalidade_Pagamento = 'Crédito'),
    (SELECT ID_SERVICOS_GERAIS_PET FROM Servicos_Gerais_Pet WHERE Nome_ServicoGeraisPet = 'Venda Ração'),
    NULL, NULL,
    (SELECT ID_FUNCIONARIO FROM Funcionarios WHERE Nome_Funcionario = 'Carla Oliveira')),

-- Faturamento 4: Serviço de Tosa para a Mia (Maria Souza)
('2024-07-27', '2024-07-27', 75.00, 'Tosa Higiênica para Mia',
    (SELECT ID_PETS FROM Pets WHERE Nome_Pets = 'Mia'),
    (SELECT DonoPet_ID FROM Pets WHERE Nome_Pets = 'Mia'),
    (SELECT ID_PAGAMENTOS FROM Tipo_de_Pagamentos WHERE Modalidade_Pagamento = 'Dinheiro'),
    (SELECT ID_SERVICOS_GERAIS_PET FROM Servicos_Gerais_Pet WHERE Nome_ServicoGeraisPet = 'Tosa Higiênica'),
    NULL, NULL,
    (SELECT ID_FUNCIONARIO FROM Funcionarios WHERE Nome_Funcionario = 'Bruno Costa')),

-- Faturamento 5: Hotelaria para a Luna (Maria Souza)
('2024-08-01', '2024-08-04', 360.00, 'Hospedagem de 3 noites',
    (SELECT ID_PETS FROM Pets WHERE Nome_Pets = 'Luna'),
    (SELECT DonoPet_ID FROM Pets WHERE Nome_Pets = 'Luna'),
    (SELECT ID_PAGAMENTOS FROM Tipo_de_Pagamentos WHERE Modalidade_Pagamento = 'Pix'),
    NULL,
    (SELECT ID_ACOMODACOES_HOTEL_PET FROM Acomodacoes_Hotel_Pet WHERE Nome_Acomodacoes = 'Suíte Felina 2'),
    (SELECT ID_SERVICO_HOTELARIA FROM Servico_Hotelaria_Pet WHERE Nome_ServicoHotelaria = 'Hospedagem Noturna'),
    (SELECT ID_FUNCIONARIO FROM Funcionarios WHERE Nome_Funcionario = 'Carla Oliveira')),

-- Faturamento 6: Serviço de Consulta para a Pipoca (Pedro Almeida)
('2024-08-02', '2024-08-02', 80.00, 'Consulta de rotina para Pipoca',
    (SELECT ID_PETS FROM Pets WHERE Nome_Pets = 'Pipoca'),
    (SELECT DonoPet_ID FROM Pets WHERE Nome_Pets = 'Pipoca'),
    (SELECT ID_PAGAMENTOS FROM Tipo_de_Pagamentos WHERE Modalidade_Pagamento = 'Pix'),
    (SELECT ID_SERVICOS_GERAIS_PET FROM Servicos_Gerais_Pet WHERE Nome_ServicoGeraisPet = 'Consulta Rotina'),
    NULL, NULL,
    (SELECT ID_FUNCIONARIO FROM Funcionarios WHERE Nome_Funcionario = 'Ana Paula Santos')),

-- Faturamento 7: Venda de produto para o Pipoca (Pedro Almeida)
('2024-08-05', '2024-08-05', 45.00, 'Venda de Coleira Peitoral',
    (SELECT ID_PETS FROM Pets WHERE Nome_Pets = 'Pipoca'),
    (SELECT DonoPet_ID FROM Pets WHERE Nome_Pets = 'Pipoca'),
    (SELECT ID_PAGAMENTOS FROM Tipo_de_Pagamentos WHERE Modalidade_Pagamento = 'Crédito'),
    (SELECT ID_SERVICOS_GERAIS_PET FROM Servicos_Gerais_Pet WHERE Nome_ServicoGeraisPet = 'Venda Acessório'),
    NULL, NULL,
    (SELECT ID_FUNCIONARIO FROM Funcionarios WHERE Nome_Funcionario = 'Carla Oliveira')),

-- Faturamento 8: Hotelaria para o Spike (Pedro Almeida)
('2024-08-08', '2024-08-10', 540.00, 'Hospedagem completa para o Spike',
    (SELECT ID_PETS FROM Pets WHERE Nome_Pets = 'Spike'),
    (SELECT DonoPet_ID FROM Pets WHERE Nome_Pets = 'Spike'),
    (SELECT ID_PAGAMENTOS FROM Tipo_de_Pagamentos WHERE Modalidade_Pagamento = 'Débito'),
    NULL,
    (SELECT ID_ACOMODACOES_HOTEL_PET FROM Acomodacoes_Hotel_Pet WHERE Nome_Acomodacoes = 'Chalé Familiar 3'),
    (SELECT ID_SERVICO_HOTELARIA FROM Servico_Hotelaria_Pet WHERE Nome_ServicoHotelaria = 'Hospedagem Completa'),
    (SELECT ID_FUNCIONARIO FROM Funcionarios WHERE Nome_Funcionario = 'Ana Paula Santos')),

-- Faturamento 9: Venda de produto para o Frajola (Gabriela Lima)
('2024-08-12', '2024-08-12', 55.00, 'Venda de cama de gato',
    (SELECT ID_PETS FROM Pets WHERE Nome_Pets = 'Frajola'),
    (SELECT DonoPet_ID FROM Pets WHERE Nome_Pets = 'Frajola'),
    (SELECT ID_PAGAMENTOS FROM Tipo_de_Pagamentos WHERE Modalidade_Pagamento = 'Dinheiro'),
    (SELECT ID_SERVICOS_GERAIS_PET FROM Servicos_Gerais_Pet WHERE Nome_ServicoGeraisPet = 'Venda Acessório'),
    NULL, NULL,
    (SELECT ID_FUNCIONARIO FROM Funcionarios WHERE Nome_Funcionario = 'Bruno Costa')),

-- Faturamento 10: Hotelaria para o Frajola (Gabriela Lima)
('2024-08-15', '2024-08-16', 240.00, 'Hospedagem de 1 noite para Frajola',
    (SELECT ID_PETS FROM Pets WHERE Nome_Pets = 'Frajola'),
    (SELECT DonoPet_ID FROM Pets WHERE Nome_Pets = 'Frajola'),
    (SELECT ID_PAGAMENTOS FROM Tipo_de_Pagamentos WHERE Modalidade_Pagamento = 'Débito'),
    NULL,
    (SELECT ID_ACOMODACOES_HOTEL_PET FROM Acomodacoes_Hotel_Pet WHERE Nome_Acomodacoes = 'Suíte Felina 2'),
    (SELECT ID_SERVICO_HOTELARIA FROM Servico_Hotelaria_Pet WHERE Nome_ServicoHotelaria = 'Hospedagem Completa'),
    (SELECT ID_FUNCIONARIO FROM Funcionarios WHERE Nome_Funcionario = 'Ana Paula Santos'));