import random

# Lista de tipos de veículos pesados
tipos_veiculos_pesados = [
    "Caminhão",
    "Ônibus",
    "Caminhão-guincho",
    "Caminhão-tanque",
    "Carreta",
    "Trator",
    "Máquina de construção",
    "Ônibus escolar",
    "Van de transporte",
    "Caminhão-pipa",
    "Reboque",
    "Caminhão de lixo",
    "Veículo de resgate",
    "Caminhão-baú",
    "Ônibus de turismo",
    "Caminhão-plataforma",
    "Caminhão de mudança",
    "Caminhão de bombeiros",
    "Caminhão frigorífico",
    "Caminhão-cegonha",
    "Caminhão-guindaste",
    "Caminhão-carga seca",
    "Veículo de transporte de animais",
    "Veículo de transporte de carga perigosa",
    "Veículo para construção civil",
    "Veículo de mineração",
    "Veículo de agricultura",
    "Veículo de defesa",
    "Outro veículo pesado"
]

# Função para gerar números aleatórios para as colunas numéricas
def gerar_numero(minimo, maximo):
    return random.randint(minimo, maximo)

# Lista para armazenar instruções SQL INSERT
sql_statements = []

# Gerar instruções SQL INSERT
for i in range(1, 51):
    tipo_veiculo = random.choice(tipos_veiculos_pesados)
    dt_fabricacao = f"TO_DATE('{random.randint(1990, 2023)}-01-01', 'YYYY-MM-DD')"
    nr_eixo = gerar_numero(2, 8)
    nr_peso = gerar_numero(5000, 50000)
    nr_altura = gerar_numero(200, 400)
    nr_comprimento = gerar_numero(500, 1000)
    tp_chassi = gerar_numero(1, 5)
    dt_inicio = f"TO_DATE('{random.randint(1990, 2023)}-01-01', 'YYYY-MM-DD')"
    dt_fim = f"TO_DATE('{random.randint(2023, 2030)}-01-01', 'YYYY-MM-DD')"

    sql_statement = f'''
    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES ({i}, '{tipo_veiculo}', {dt_fabricacao}, {nr_eixo}, {nr_peso}, {nr_altura}, {nr_comprimento}, {tp_chassi}, {dt_inicio}, {dt_fim});
    '''
    sql_statements.append(sql_statement)

# Imprimir as instruções SQL
for statement in sql_statements:
    print(statement)
