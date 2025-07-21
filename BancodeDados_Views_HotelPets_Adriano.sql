CREATE VIEW Faturamento_Dono_Pet_Por_Produtos AS
SELECT
    F.ID_FATURAMENTO,
    F.DataEntrada_Faturamento,
    F.DataSaida_Faturamento,
    F.ValorTotalFaturamento_Faturamento,
    F.Anotacoesgerais_Faturamento,
    DP.Nome_DonoPet AS Dono_do_Pet,
    TP.Modalidade_Pagamento AS Tipo_Pagamento,
    SGP.Nome_ServicoGeraisPet AS Nome_Produto_Vendido,
    Func.Nome_Funcionario AS Funcionario_Atendente
FROM
    Faturamento F
JOIN
    Dono_do_Pet DP ON F.DonoPet_ID = DP.ID_DONO_PET
JOIN
    Tipo_de_Pagamentos TP ON F.Pagamentos_ID = TP.ID_PAGAMENTOS
LEFT JOIN
    Servicos_Gerais_Pet SGP ON F.ServicosGeraisPet_ID = SGP.ID_SERVICOS_GERAIS_PET
LEFT JOIN
    Funcionarios Func ON F.Funcionarios_ID = Func.ID_FUNCIONARIO
WHERE
    SGP.Nome_ServicoGeraisPet LIKE '%Venda%'; -- Filtra por serviços que são vendas de produtos
    -- Ou, se você tiver uma coluna Modalidade_ServicoGeraisPet na tabela Servicos_Gerais_Pet:
    -- SGP.Modalidade_ServicoGeraisPet = 'Venda';
    
    CREATE VIEW Faturamento_Dono_Pet_Por_Servico_Geral AS
SELECT
    F.ID_FATURAMENTO,
    F.DataEntrada_Faturamento,
    F.DataSaida_Faturamento,
    F.ValorTotalFaturamento_Faturamento,
    F.Anotacoesgerais_Faturamento,
    DP.Nome_DonoPet AS Dono_do_Pet,
    TP.Modalidade_Pagamento AS Tipo_Pagamento,
    SGP.Nome_ServicoGeraisPet AS Nome_Servico,
    Func.Nome_Funcionario AS Funcionario_Atendente
FROM
    Faturamento F
JOIN
    Dono_do_Pet DP ON F.DonoPet_ID = DP.ID_DONO_PET
JOIN
    Tipo_de_Pagamentos TP ON F.Pagamentos_ID = TP.ID_PAGAMENTOS
LEFT JOIN
    Servicos_Gerais_Pet SGP ON F.ServicosGeraisPet_ID = SGP.ID_SERVICOS_GERAIS_PET
LEFT JOIN
    Funcionarios Func ON F.Funcionarios_ID = Func.ID_FUNCIONARIO
WHERE
    SGP.Nome_ServicoGeraisPet NOT LIKE '%Venda%' OR SGP.ID_SERVICOS_GERAIS_PET IS NOT NULL AND F.ServicoHotelariaPet_ID IS NULL;
    -- Filtra por serviços gerais que não são vendas e que não são parte de hotelaria principal,
    -- ou onde ServicoHotelariaPet_ID é NULL (indicando que não é uma hospedagem primária)
    
    CREATE VIEW Faturamento_Dono_Pet_Por_Hotelaria AS
SELECT
    F.ID_FATURAMENTO,
    F.DataEntrada_Faturamento,
    F.DataSaida_Faturamento,
    F.ValorTotalFaturamento_Faturamento,
    F.Anotacoesgerais_Faturamento,
    DP.Nome_DonoPet AS Dono_do_Pet,
    TP.Modalidade_Pagamento AS Tipo_Pagamento,
    AHP.Nome_Acomodacoes AS Acomodacao_Hotel,
    SHP.Nome_ServicoHotelaria AS Servico_Hotelaria,
    Func.Nome_Funcionario AS Funcionario_Atendente
FROM
    Faturamento F
JOIN
    Dono_do_Pet DP ON F.DonoPet_ID = DP.ID_DONO_PET
JOIN
    Tipo_de_Pagamentos TP ON F.Pagamentos_ID = TP.ID_PAGAMENTOS
LEFT JOIN
    Acomodacoes_Hotel_Pet AHP ON F.AcomodacoesHotelPet_ID = AHP.ID_ACOMODACOES_HOTEL_PET
LEFT JOIN
    Servico_Hotelaria_Pet SHP ON F.ServicoHotelariaPet_ID = SHP.ID_SERVICO_HOTELARIA
LEFT JOIN
    Funcionarios Func ON F.Funcionarios_ID = Func.ID_FUNCIONARIO
WHERE
    F.ServicoHotelariaPet_ID IS NOT NULL; -- Filtra por registros que têm um serviço de hotelaria
    

    
    
    
    
    