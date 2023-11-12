from faker import Faker
import random

fake = Faker('pt_BR')

# Lista de descrições de serviços
descricoes_servicos = [
    "Troca de Óleo para Caminhão Volvo FH16",
    "Revisão do Sistema de Freios do Kenworth W990",
    "Substituição das Pastilhas de Freio - Scania R730",
    "Diagnóstico de Falha no Motor - Mercedes-Benz Actros",
    "Alinhamento e Balanceamento para Peterbilt 389",
    "Troca de Bateria do MAN TGX",
    "Reparo no Sistema Elétrico do International LoneStar",
    "Verificação de Vazamento de Fluidos - Mack Anthem",
    "Inspeção do Sistema de Transmissão - Freightliner Cascadia",
    "Troca de Filtro de Ar para DAF XF",
    "Ajuste da Suspensão - Renault T Range",
    "Manutenção da Embreagem - Iveco Stralis",
    "Substituição das Lâmpadas - Western Star 5700",
    "Troca de Pneus para FAW Jiefang J7",
    "Reparo na Caixa de Direção - Kamaz 5490",
    "Diagnóstico do Sistema de Injeção - Tata Prima",
    "Limpeza do Sistema de Escape - Isuzu Giga",
    "Atualização de Software - Hino 700",
    "Calibragem de Pneus - Mitsubishi Fuso Super Great",
    "Verificação da Suspensão - Dongfeng KX",
    "Diagnóstico de Problemas Elétricos - Scania S730",
    "Revisão Geral do Volvo VNL",
    "Manutenção do Sistema de Arrefecimento - Mercedes-Benz Arocs",
    "Ajuste na Suspensão - Kenworth T880",
    "Troca de Óleo e Filtros - Peterbilt 579",
    "Verificação do Sistema de Ar Condicionado - MAN TGS",
    "Substituição do Filtro de Combustível - International LT Series",
    "Troca do Fluido de Transmissão - Mack Pinnacle",
    "Inspeção da Direção Hidráulica - Freightliner Coronado",
    "Troca de Lâmpadas de Freio - DAF CF",
    "Verificação da Embreagem - Renault K Range",
    "Manutenção Preventiva - Iveco Eurocargo",
    "Revisão da Barra Estabilizadora - Western Star 4900",
    "Substituição de Componentes do Chassi - FAW Jiefang J6P",
    "Verificação do Sistema de Injeção - Kamaz 65201",
    "Lubrificação do Chassi - Tata Ultra",
    "Troca do Sistema de Freio - Isuzu F-Series",
    "Inspeção do Sistema de Direção - Hino 500",
    "Atualização do Software da Central Eletrônica - Mitsubishi Fuso Fighter",
    "Limpeza do Sistema de Admissão - Dongfeng KL",
    "Revisão Geral do Scania G450",
    "Troca de Óleo da Transmissão - Volvo FMX",
    "Diagnóstico Avançado - Mercedes-Benz Axor",
    "Ajuste na Suspensão - Kenworth W900",
    "Verificação do Sistema de Injeção - Peterbilt 567",
    "Troca do Filtro de Ar - MAN TG-M"
]

# Lista para armazenar instruções SQL INSERT
sql_statements_solicitacoes_atendimento = []

# Gerar instruções SQL INSERT para 46 solicitações
for i in range(1, 47):
    id_solicitacao = i
    id_problema = i
    id_veiculo = i
    id_cliente = i
    cd_solicitacao = fake.random_number(digits=2)
    nm_solicitacao = descricoes_servicos[i - 1]  # Ajuste para acessar a lista corretamente
    # Cria a instrução SQL
    sql_statement_solicitacao_atendimento = f'''
    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES ({id_solicitacao}, {id_problema}, {id_veiculo}, {id_cliente}, {cd_solicitacao}, '{nm_solicitacao}');
    '''
    sql_statements_solicitacoes_atendimento.append(sql_statement_solicitacao_atendimento)

# Imprimir as instruções SQL
for statement in sql_statements_solicitacoes_atendimento:
    print(statement)
