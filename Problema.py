from faker import Faker


fake = Faker()

# Lista de problemas possíveis
problemas = [
    "Falhas no funcionamento do motor.",
    "Perda de potência.",
    "Vazamentos de óleo ou líquido de arrefecimento.",
    "Desgaste excessivo das pastilhas de freio.",
    "Falha no sistema de freio antibloqueio (ABS).",
    "Vazamento de fluido de freio.",
    "Falhas nos sistemas de iluminação.",
    "Problemas com baterias descarregadas.",
    "Falha nos sistemas eletrônicos de controle.",
    "Desgaste irregular dos pneus.",
]

# Lista para armazenar instruções SQL INSERT
sql_statements_problemas = []

# Gerar instruções SQL INSERT para cada problema
for i, problema in enumerate(problemas, start=1):
    id_end_problema = i
    id_usuario = i  # Supondo que o id do usuário é o mesmo que o id do problema
    dt_problema = fake.date_this_decade()

    # Cria a instrução SQL
    sql_statement_problema = f'''
    INSERT INTO tb_problema (id_problema, id_end_problema, id_usuario, nm_problema, dt_problema)
    VALUES ({i}, {id_end_problema}, {id_usuario}, '{problema}', TO_DATE('{dt_problema}', 'YYYY-MM-DD'));
    '''
    sql_statements_problemas.append(sql_statement_problema)

# Imprimir as instruções SQL
for statement in sql_statements_problemas:
    print(statement)

