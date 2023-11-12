from faker import Faker
import random

fake = Faker('pt_BR')

# Lista para armazenar instruções SQL INSERT
sql_statements_guincho_solicitado = []

# Gerar instruções SQL INSERT para 46 registros
for i in range(1, 47):
    id_guincho_solicitado = i
    id_veiculo = i
    id_guincho = i
    id_solicitacao = i
    cd_guincho = i
    
    # Cria a instrução SQL
    sql_statement_guincho_solicitado = f'''
    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES ({id_guincho_solicitado}, {id_veiculo}, {id_guincho}, {id_solicitacao}, {cd_guincho});
    '''
    sql_statements_guincho_solicitado.append(sql_statement_guincho_solicitado)

# Imprimir as instruções SQL
for statement in sql_statements_guincho_solicitado:
    print(statement)
