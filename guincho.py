import random

# Lista de tipos de guinchos
tipos_guinchos = [
    "Guincho de cabo de aço",
    "Guincho hidráulico",
    "Guincho elétrico",
    "Guincho de corrente",
    "Guincho de tambor",
    "Guincho de reboque",
    "Guincho de plataforma",
    "Guincho de rolo",
    "Guincho de polia dupla",
    "Guincho de rotação",
    "Guincho de controle remoto",
    "Guincho de emergência",
    "Guincho para veículos todo-terreno (ATV)",
    "Guincho para barcos",
    "Guincho de acionamento manual",
    "Guincho de veículo de serviço",
    "Guincho de lança",
    "Guincho de recuperação",
    "Guincho de torre",
    "Guincho de arraste",
    "Guincho de elevação",
    "Guincho de pára-choque",
    "Guincho de montagem frontal",
    "Guincho para caminhões pesados",
    "Guincho industrial",
    "Guincho de cabo sintético",
    "Guincho de resgate",
    "Guincho para mineração",
    "Guincho para construção",
    "Guincho de auto carregamento",
    "Guincho para serviço pesado",
    "Guincho de cabo de fibra",
    "Guincho de elevação lateral",
    "Guincho de tambor duplo",
    "Guincho de controle automático",
    "Guincho de plataforma deslizante",
    "Guincho de alta capacidade",
    "Guincho de tração",
    "Guincho para veículos de emergência",
    "Guincho de resgate florestal",
    "Guincho de uso militar",
    "Guincho para veículos de recreação",
    "Guincho para transporte de carga",
    "Guincho de roda",
    "Guincho de plataforma giratória",
    "Guincho de câmara de ar",
    "Guincho de controle por joystick",
    "Guincho para veículos off-road",
    "Guincho de controle de velocidade variável",
    "Guincho para veículos de serviço público"
]

sql_statements_guinchos = []

# Gerar instruções SQL INSERT para os guinchos
for i, tipo_guinho in enumerate(tipos_guinchos, start=1):
    # Gera um número fictício para o guincho dentro do intervalo aceitável
    nr_guincho = random.randint(1000000, 9999999)
    
    # Cria a instrução SQL
    sql_statement_guinho = f'''
    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES ({i}, 1, '{tipo_guinho}', {nr_guincho});
    '''
    sql_statements_guinchos.append(sql_statement_guinho)

# Imprimir as instruções SQL
for statement in sql_statements_guinchos:
    print(statement)