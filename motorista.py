import random
import datetime
from faker import Faker

# Inicializa o Faker
fake = Faker('pt_BR')

# Lista para armazenar instruções SQL INSERT
sql_statements_motoristas = []

# Gerar instruções SQL INSERT para 50 motoristas
for i in range(1, 51):
    # Gera dados fictícios para o motorista
    nm_motorista = fake.name()
    
    # Alterado para gerar um código como string
    cd_motorista = str(fake.random_number(digits=5))
    
    # Alterado para gerar nr_cnh como string de 11 dígitos
    nr_cnh = str(fake.random_number(digits=11))
    
    nm_categoria_cnh = random.choice(['A', 'B', 'C', 'D', 'E'])
    
    # Gera uma data de validade da CNH aleatória
    start_date_cnh = datetime.date(2023, 1, 1)
    end_date_cnh = datetime.date(2025, 12, 31)
    dt_validade_cnh = start_date_cnh + datetime.timedelta(days=random.randint(0, (end_date_cnh - start_date_cnh).days))
    
    # Cria a instrução SQL
    sql_statement_motorista = f'''
    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES ({i}, {i}, '{nm_motorista}', '{cd_motorista}', '{nr_cnh}', '{nm_categoria_cnh}', TO_DATE('{dt_validade_cnh.strftime('%Y-%m-%d')}', 'YYYY-MM-DD'));
    '''
    sql_statements_motoristas.append(sql_statement_motorista)

# Imprimir as instruções SQL
for statement in sql_statements_motoristas:
    print(statement)
    
