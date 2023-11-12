from faker import Faker
import random
import datetime

fake = Faker('pt_BR')

# Lista para armazenar instruções SQL INSERT
sql_statements_clientes_veiculos = []

# Gerar instruções SQL INSERT para 46 clientes
for i in range(1, 47):
    id_usuario = i  # Supondo que o id do usuário é o mesmo que o id do cliente
    id_veiculo = i
    id_cliente = i
    nm_cliente_func = fake.first_name()
    
    # Gera datas fictícias para dt_inicio e dt_fim
    dt_inicio = fake.date_this_decade()
    dt_fim = dt_inicio + datetime.timedelta(days=random.randint(30, 365))
    
    cd_slc_atend = fake.random_number(digits=10)

    # Cria a instrução SQL
    sql_statement_cliente_veiculo = f'''
    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES ({id_usuario}, {id_veiculo}, {id_cliente}, '{nm_cliente_func}', TO_DATE('{dt_inicio}', 'YYYY-MM-DD'), TO_DATE('{dt_fim}', 'YYYY-MM-DD'), {cd_slc_atend});
    '''
    sql_statements_clientes_veiculos.append(sql_statement_cliente_veiculo)

# Imprimir as instruções SQL
for statement in sql_statements_clientes_veiculos:
    print(statement)
