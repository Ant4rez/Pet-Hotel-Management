-- Verificar dados na tabela Cargo
SELECT * FROM Cargo;

-- Verificar dados na tabela Tipo_de_Pagamentos
SELECT * FROM Tipo_de_Pagamentos;

-- Verificar dados na tabela Vacinas_Pet
SELECT * FROM Vacinas_Pet;

-- Verificar dados na tabela Estoque_Produtos_Gerais
SELECT * FROM Estoque_Produtos_Gerais;

-- Verificar dados na tabela Estoque_Produtos_Pets
SELECT * FROM Estoque_Produtos_Pets;

-- Verificar dados na tabela Acomodacoes_Hotel_Pet
SELECT * FROM Acomodacoes_Hotel_Pet;

-- Verificar dados na tabela Funcionarios
SELECT * FROM Funcionarios;

-- Verificar dados na tabela Endereco_Funcionarios
SELECT * FROM Endereco_Funcionarios;

-- Verificar dados na tabela Dono_do_Pet
SELECT * FROM Dono_do_Pet;

-- Verificar dados na tabela Endereco_Dono_do_Pet
SELECT * FROM Endereco_Dono_do_Pet;

-- Verificar dados na tabela Pets
SELECT * FROM Pets;

-- Verificar dados na tabela Servicos_Gerais_Pet
SELECT * FROM Servicos_Gerais_Pet;

-- Verificar dados na tabela Servico_Hotelaria_Pet
SELECT * FROM Servico_Hotelaria_Pet;

-- Verificar dados na tabela Faturamento (todos os faturamentos)
SELECT * FROM Faturamento;

-- 2.1. Funcionários e Seus Cargos
-- Mostra o nome do funcionário e o cargo que ele ocupa.
SELECT
    F.Nome_Funcionario,
    C.Nome_Cargo,
    C.Descricao_Cargo
FROM
    Funcionarios F
JOIN
    Cargo C ON F.Cargo_ID = C.ID_CARGO;

-- 2.2. Funcionários e Seus Endereços
-- Mostra os dados básicos do funcionário e seu endereço completo.
SELECT
    F.Nome_Funcionario,
    F.Telephone_Funcionario,
    EF.Logradouro_Endereco,
    EF.Numero_Endereco,
    EF.Bairro_Endereco,
    EF.Cidade_Endereco,
    EF.Estado_Endereco,
    EF.CEP_Endereco
FROM
    Funcionarios F
JOIN
    Endereco_Funcionarios EF ON F.ID_FUNCIONARIO = EF.Funcionarios_ID;

-- 2.3. Donos de Pets e Seus Endereços
-- Lista os donos de pets com seus respectivos endereços.
SELECT
    DP.Nome_DonoPet,
    DP.Telefone_DonoPet,
    EDP.Logradouro_Endereco,
    EDP.Numero_Endereco,
    EDP.Cidade_Endereco,
    EDP.Estado_Endereco
FROM
    Dono_do_Pet DP
JOIN
    Endereco_Dono_do_Pet EDP ON DP.ID_DONO_PET = EDP.DonoPet_ID;

-- 2.4. Pets e Seus Donos (e Vacinas)
-- Mostra os detalhes dos pets, quem são seus donos e as vacinas associadas.
SELECT
    P.Nome_Pets,
    P.Raca_Pets,
    DP.Nome_DonoPet AS Dono,
    DP.Telefone_DonoPet AS Telefone_Dono,
    VP.Nome_Vacina,
    VP.Validade_Vacina
FROM
    Pets P
JOIN
    Dono_do_Pet DP ON P.DonoPet_ID = DP.ID_DONO_PET
LEFT JOIN -- LEFT JOIN para mostrar pets mesmo que não tenham vacina associada
    Vacinas_Pet VP ON P.Vacinas_ID = VP.ID_VACINAS;

-- 2.5. Faturamentos Detalhados
-- Exibe informações completas de cada faturamento, incluindo detalhes de dono, pagamento, serviço geral, acomodação, serviço de hotelaria e funcionário.
SELECT
    F.ID_FATURAMENTO,
    F.DataEntrada_Faturamento,
    F.ValorTotalFaturamento_Faturamento,
    DP.Nome_DonoPet,
    TP.Tipo_Pagamentos,
    SGP.Nome_ServicoGeraisPet AS Servico_Geral,
    AHP.Nome_Acomodacoes AS Acomodacao_Hotel,
    SHP.Nome_ServicoHotelaria AS Servico_Hotelaria,
    Func.Nome_Funcionario AS Responsavel
FROM
    Faturamento F
LEFT JOIN Dono_do_Pet DP ON F.DonoPet_ID = DP.ID_DONO_PET
LEFT JOIN Tipo_de_Pagamentos TP ON F.Pagamentos_ID = TP.ID_PAGAMENTOS
LEFT JOIN Servicos_Gerais_Pet SGP ON F.ServicosGeraisPet_ID = SGP.ID_SERVICOS_GERAIS_PET
LEFT JOIN Acomodacoes_Hotel_Pet AHP ON F.AcomodacoesHotelPet_ID = AHP.ID_ACOMODACOES_HOTEL_PET
LEFT JOIN Servico_Hotelaria_Pet SHP ON F.ServicoHotelariaPet_ID = SHP.ID_SERVICO_HOTELARIA
LEFT JOIN Funcionarios Func ON F.Funcionarios_ID = Func.ID_FUNCIONARIO;

-- 2.6. Serviços Gerais de Pet e Seus Produtos Associados
-- Mostra quais produtos gerais estão associados a quais serviços.
SELECT
    SGP.Nome_ServicoGeraisPet,
    SGP.Modalidade_ServicoGeraisPet,
    EPG.Nome_ProdutoGerais,
    EPG.Quantidade_ProdutosGerais
FROM
    Servicos_Gerais_Pet SGP
LEFT JOIN
    Estoque_Produtos_Gerais EPG ON SGP.EstoqueProdutosGerais_ID = EPG.ID_ESTOQUE_PRODUTOS_GERAIS;

-- 2.7. Serviços de Hotelaria e as Acomodações/Produtos Associados
-- Mostra os serviços de hotelaria e as acomodações e produtos específicos que eles utilizam.
SELECT
    SHP.Nome_ServicoHotelaria,
    SHP.Modalidade_ServicoHotelaria,
    AHP.Nome_Acomodacoes AS Acomodacao_Utilizada,
    EPP.Nome_ProdutosPets AS Produto_Associado
FROM
    Servico_Hotelaria_Pet SHP
LEFT JOIN
    Acomodacoes_Hotel_Pet AHP ON SHP.Acomodacoes_Hotel_Pet_ID = AHP.ID_ACOMODACOES_HOTEL_PET
LEFT JOIN
    Estoque_Produtos_Pets EPP ON SHP.ProdutosPets_ID = EPP.ID_PRODUTOS_PETS;
    
    
    -- 3.1. Total Faturado por Mês
SELECT
    strftime('%Y-%m', DataEntrada_Faturamento) AS AnoMes, -- Para SQLite, use YEAR() e MONTH() ou DATE_FORMAT() para outros bancos
    SUM(ValorTotalFaturamento_Faturamento) AS TotalFaturado
FROM
    Faturamento
GROUP BY
    AnoMes
ORDER BY
    AnoMes;

-- Para MySQL/PostgreSQL, seria mais comum:
-- SELECT
--     DATE_FORMAT(DataEntrada_Faturamento, '%Y-%m') AS AnoMes,
--     SUM(ValorTotalFaturamento_Faturamento) AS TotalFaturado
-- FROM
--     Faturamento
-- GROUP BY
--     AnoMes
-- ORDER BY
--     AnoMes;


-- 3.2. Contagem de Pets por Dono
SELECT
    DP.Nome_DonoPet,
    COUNT(P.ID_PETS) AS Quantidade_Pets
FROM
    Dono_do_Pet DP
LEFT JOIN
    Pets P ON DP.ID_DONO_PET = P.DonoPet_ID
GROUP BY
    DP.Nome_DonoPet
ORDER BY
    Quantidade_Pets DESC;

-- 3.3. Quantidade de cada Produto no Estoque Geral
SELECT
    Nome_ProdutoGerais,
    Quantidade_ProdutosGerais
FROM
    Estoque_Produtos_Gerais
ORDER BY
    Nome_ProdutoGerais;
    
    SELECT
    F.ID_FATURAMENTO,
    F.DataEntrada_Faturamento,
    F.ValorTotalFaturamento_Faturamento,
    DP.Nome_DonoPet AS Nome_Cliente,
    TP.Modalidade_Pagamento AS Forma_Pagamento,
    SGP.Nome_ServicoGeraisPet AS Tipo_Servico,
    Func.Nome_Funcionario AS Nome_Funcionario
FROM
    Faturamento F
LEFT JOIN Dono_do_Pet DP ON F.DonoPet_ID = DP.ID_DONO_PET
LEFT JOIN Tipo_de_Pagamentos TP ON F.Pagamentos_ID = TP.ID_PAGAMENTOS
LEFT JOIN Servicos_Gerais_Pet SGP ON F.ServicosGeraisPet_ID = SGP.ID_SERVICOS_GERAIS_PET
LEFT JOIN Funcionarios Func ON F.Funcionarios_ID = Func.ID_FUNCIONARIO;